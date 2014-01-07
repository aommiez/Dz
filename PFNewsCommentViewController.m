//
//  PFNewsCommentViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/27/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFNewsCommentViewController.h"
#import "UIView+MTAnimation.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 280.0f
#define CELL_CONTENT_MARGIN 4.0f
#define FONT_SIZE_COMMENT 14.0f
BOOL noData;
BOOL refreshData;
@interface PFNewsCommentViewController ()

@end
int maxH;
@implementation PFNewsCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    noData = NO;
    refreshData = NO;
    self.arrObj = [[NSMutableArray alloc] init];
    maxH = 0;
    self.textComment.delegate = self;
    [self.textComment.layer setCornerRadius:4.0];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Comments"];
    [self.navigationItem setTitleView:myLabel];
    self.navigationController.delegate = self;
    UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a2 setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 30.0f)];
    [a2 addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
    [a2 setTitle:@"Back" forState:UIControlStateNormal];
    //UIBarButtonItem *backBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
    //self.navigationItem.leftBarButtonItem = backBut;
    
    [self.commentDownTapped setFrame:CGRectMake(0, 464, self.commentDownTapped.frame.size.width, self.commentDownTapped.frame.size.height)];
    //[self.view addSubview:self.commentDownTapped];
    self.tableView.tableFooterView = self.footTablewView;
    self.textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(20,76,280,150)];
    self.textView.contentInset = UIEdgeInsetsMake(6, 5, 0, 5);
    self.textView.minNumberOfLines = 1;
    self.textView.maxNumberOfLines = 3;
    self.textView.returnKeyType = UIReturnKeyGo; //just as an example
    self.textView.font = [UIFont systemFontOfSize:13.0f];
    self.textView.delegate = self;
    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    self.textView.returnKeyType = UIReturnKeyDefault;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.cornerRadius = 5;
    self.textView.clipsToBounds = YES;
    [self.textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.textView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.textView.layer setBorderWidth: 1.0];
    [self.textView.layer setCornerRadius:8.0f];
    [self.textView.layer setMasksToBounds:YES];
    [self.commentTextFieldView addSubview:self.textView];

    self.commentTextFieldView.frame = CGRectMake(0, 0, 320, 356);
    [self.view addSubview:self.commentTextFieldView];
    
    if (IS_WIDESCREEN) {
        self.textCommentView.frame = CGRectMake(0, 464+60, 320, 356);
    } else {
        self.textCommentView.frame = CGRectMake(0, 440, 320, 356);
    }
    [self.view addSubview:self.textCommentView];
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)] autorelease];
    self.tableView.tableHeaderView = topView;
    
    [self.textComment becomeFirstResponder];
    /*
    PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    newsManager.delegate = self;
    [newsManager getCommentNewsId:self.newsId limit:7 linkUrl:nil];
     */
    self.tableView.delegate = self;
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiCommentObjectId:self.newsId limit:@"5" next:@"NO"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_commentDownTapped release];
    [_footTablewView release];
    [_textCommentView release];
    [_textComment release];

    [_postBut release];
    [_waitView release];
    [_act release];
    [super dealloc];
}
- (void)PFNewsManager:(id)sender getCommentNewsIdResponse:(NSDictionary *)response {

    int commentCell = 0;
    if ( [self.arrObj count] == 0 ) {
        commentCell = 0;
    } else {
        commentCell = ([self.arrObj count]*45);
    }
    
    self.tableView.contentSize = CGSizeMake(320, self.tableView.tableHeaderView.frame.size.height+commentCell+60);
    //[self.tableView reloadData];
}
- (void)PFNewsManager:(id)sender getCommentNewsIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [[NSString alloc] init];
    str =  [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    NSString *text = str;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_COMMENT] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 24.0f) + 10;
    
    NSString *h = [[NSString alloc] initWithFormat:@"%f",height + (CELL_CONTENT_MARGIN * 2)];
    
    int lineValue = [h intValue]/16;
    int heightLable = 20*lineValue;

    return heightLable+40;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCommnetCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCommnetCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *str = [[NSString alloc] init];
    str =  [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    NSString *text = str;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_COMMENT] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 24.0f) + 10;
    
    NSString *h = [[NSString alloc] initWithFormat:@"%f",height + (CELL_CONTENT_MARGIN * 2)];
    
    int lineValue = [h intValue]/16;
    cell.commentLabel.numberOfLines = 0;
    int heightLable = 20*lineValue;
    cell.commentLabel.frame = CGRectMake(cell.commentLabel.frame.origin.x, cell.commentLabel.frame.origin.y, cell.commentLabel.frame.size.width, heightLable);
    
    cell.delegate = self;
    
    
    
    cell.timeComment.frame = CGRectMake(cell.timeComment.frame.origin.x,heightLable +14, cell.timeComment.frame.size.width, cell.timeComment.frame.size.height);
    
    
    cell.timeComment.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"created_text"];
    cell.imgBut.tag = [[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"id"] intValue];
    cell.commentLabel.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    cell.nameLabel.text = [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"username"];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"http://61.19.147.72/api/user/%@/picture",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"id"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        UIImage *img = [UIImage imageWithData:responseData];
        cell.userImg.image = img;
        
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [request startAsynchronous];
    NSInteger sectionsAmount = [tableView numberOfSections];
    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    
    if (indexPath.row == 0 ) {
        if ([self.arrObj count] > 1 ) {
            UIImage *image2 = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5@2x"] deg:180];
            cell.lineImg.image = [UIImage imageNamed:@"LineCommentBoxIp5"];
            cell.headImg.image = image2;
            //cell.headImg.image = [UIImage imageNamed:@"HeadCommentBoxIp5"];
        } else {
            //cell.headImg.image = [UIImage imageNamed:@"HeadCommentBoxIp5"];
            cell.lineImg.image = [UIImage imageNamed:@"FootCommentBoxEndIp5"];
            UIImage *image2 = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5"] deg:180];
            cell.headImg.image = image2;
        }
    } else if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
        cell.lineImg.image = [UIImage imageNamed:@"FootCommentBoxEndIp5"];
        cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];
    } else {
        cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self bgTapped:self];
}
- (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,oldImage.size.width, oldImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)DidUserId:(NSString *)userId {
    if (IS_WIDESCREEN) {
        PFAccountViewController *accountView = [[PFAccountViewController alloc] initWithNibName:@"PFAccountViewController_Wide" bundle:nil];
        accountView.userId = userId;
        accountView.delegate = self;
        [self.navigationController pushViewController:accountView animated:YES];
        
    } else {
        PFAccountViewController *accountView = [[PFAccountViewController alloc] initWithNibName:@"PFAccountViewController" bundle:nil];
        accountView.userId = userId;
        accountView.delegate = self;
        [self.navigationController pushViewController:accountView animated:YES];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if ( scrollView.contentOffset.y < -80.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.frame = CGRectMake(0, 60, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
        if (!noData){
            refreshData = NO;
            PFDzApi *dzApi = [[PFDzApi alloc] init];
            dzApi.delegate = self;
            [dzApi DzApiCommentObjectId:self.newsId limit:@"NO" next:self.paging];
        }
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    
}
- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < -60.0f ) {
        if (!noData){
            refreshData = NO;
            PFDzApi *dzApi = [[PFDzApi alloc] init];
            dzApi.delegate = self;
            [dzApi DzApiCommentObjectId:self.newsId limit:@"NO" next:self.paging];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
    
    if (offset >= 0 && offset <= 5) {
        if (!noData) {
            refreshData = NO;
            PFDzApi *dzApi = [[PFDzApi alloc] init];
            dzApi.delegate = self;
            [dzApi DzApiCommentObjectId:self.newsId limit:@"NO" next:self.paging];
        }
    }
     */
}
- (IBAction)commentTapped:(id)sender {

    [self.textComment becomeFirstResponder];
}
- (IBAction)closeComment:(id)sender {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.view.frame.size.height);
    [UIView animateWithDuration:0.3
                          delay:0.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseOut
                     animations:^ {
                         [self.textView resignFirstResponder];
                         self.commentTextFieldView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)postCommentTapped:(id)sender {
    
    if (![self.textComment.text isEqualToString:@""]) {
        [self.view addSubview:self.waitView];
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiCommentObject:self.newsId msg:self.textComment.text];
    }
}
- (void)closeCommentBox {
    [UIView animateWithDuration:0.3
                          delay:0.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {

                         [self.textComment resignFirstResponder];
                         if ( IS_WIDESCREEN) {
                             self.textCommentView.frame = CGRectMake(0, 464+60, 320, 44);
                         } else {
                             self.textCommentView.frame = CGRectMake(0, 440, 320, 44);
                         }
                         self.textComment.frame = CGRectMake(10, 7, 236, 30);
                         self.postBut.frame = CGRectMake(254, 7, 54, 30);
                     }
                     completion:^(BOOL finished) {
                         [self.waitView removeFromSuperview];
                         self.textComment.tintColor = [UIColor darkGrayColor];
                         self.textComment.text = @"Add Comment";
                         
                     }];
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    if ([self.arrObj count] > 0)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrObj count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (void)PFNewsManager:(id)sender commentNewsByIdResponse:(NSDictionary *)response {
    [self closeCommentBox];
}
- (void)PFNewsManager:(id)sender commentNewsByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(PFNewsCommentViewControllerBackTapped:)]){
        [self.delegate PFNewsCommentViewControllerBackTapped:self];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    //[self.view addSubview:self.overlayView];
    if ([self.textComment.text isEqualToString:@"Add Comment"]) {
        [self.textComment setTextColor:[UIColor blackColor]];
        self.textComment.text = @"";
    }
    [UIView mt_animateViews:@[self.textCommentView] duration:0.33 timingFunction:kMTEaseOutSine animations:^{
        self.textCommentView.frame = CGRectMake(0, 250+60, self.textCommentView.frame.size.width, self.textCommentView.frame.size.height);
    } completion:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-254);
        if (IS_WIDESCREEN) {
            self.textCommentView.frame = CGRectMake(0, 250+60, self.textCommentView.frame.size.width, self.textCommentView.frame.size.height);
            if ([self.arrObj count] > 0)
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrObj count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        } else {
            self.textCommentView.frame = CGRectMake(0, 220, self.textCommentView.frame.size.width, self.textCommentView.frame.size.height);
            if ([self.arrObj count] > 0)
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrObj count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];

    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"])
	{
        if ( maxH < 3) {
            maxH += 1;
            float diff = (textView.frame.size.height - 30);
            CGRect r = self.textCommentView.frame;
            r.size.height += diff;
            r.origin.y -= 15;
            self.textCommentView.frame = r;
            CGRect a = self.textComment.frame;
            a.size.height += 15;
            self.textComment.frame = a;
            CGRect b = self.postBut.frame;
            b.origin.y += 15;
            self.postBut.frame = b;
            return YES;
        } else {
            [self.textComment scrollRangeToVisible:NSMakeRange([self.textComment.text length], 0)];
            return YES;
        }
	}
	return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    [self.textComment scrollRangeToVisible:NSMakeRange([self.textComment.text length], 0)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView setContentOffset:CGPointZero animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController.visibleViewController isKindOfClass:[PFAccountViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFNewsCommentViewControllerBackTapped:)]){
                [self.delegate PFNewsCommentViewControllerBackTapped:self];
            }
        }
    }
}
- (IBAction)bgTapped:(id)sender {
    
    //[self.overlayView removeFromSuperview];
    [self.textComment resignFirstResponder];
    
    [UIView mt_animateViews:@[self.textCommentView] duration:0.34 timingFunction:kMTEaseOutSine animations:^{
        if ( IS_WIDESCREEN) {
            self.textCommentView.frame = CGRectMake(0, 464+60, 320, 44);
        } else {
            self.textCommentView.frame = CGRectMake(0, 440, 320, 44);
        }
        self.textComment.frame = CGRectMake(10, 7, 236, 30);
        self.postBut.frame = CGRectMake(254, 7, 54, 30);
    } completion:^{
        
    }];
    
    [UIView animateWithDuration:0.50
                          delay:0.1  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseOut
                     animations:^ {
                         self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.view.frame.size.height-40);
                         if ([self.arrObj count] > 0)
                             [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrObj count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                         NSLog(@"%f",self.tableView.contentSize.height);
                         
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    if ([self.textComment.text isEqualToString:@""]) {
        [self.textComment setTextColor:[UIColor lightGrayColor]];
        self.textComment.text = @"Add Comment";
    }
}
- (void)PFDzApi:(id)sender DzApiCommentObjectIdResponse:(NSDictionary *)response {
    if (!refreshData) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            //[self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
            [self.arrObj insertObject:[[response objectForKey:@"data"] objectAtIndex:i] atIndex:0];
        }
        
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    

    if ( [[response objectForKey:@"paging"] objectForKey:@"next"] == nil ) {
        noData = YES;
    } else {
        noData = NO;
        self.paging = [[response objectForKey:@"paging"] objectForKey:@"next"];
    }
    [self reloadData:YES];
}
- (void)PFDzApi:(id)sender DzApiCommentObjectIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    
    if (animated) {
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setSubtype:kCATransitionFromBottom];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [animation setFillMode:kCAFillModeBoth];
        [animation setDuration:.5];
        [[self.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
        
    }
}
- (void)PFDzApi:(id)sender DzApiCommentObjectResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    //[self.arrObj insertObject:[[response objectForKey:@"data"] objectAtIndex:i] atIndex:0];
    [self bgTapped:self];
    [self.arrObj insertObject:response atIndex:[self.arrObj count]];
    [self.tableView reloadData];
    [self.textComment setTextColor:[UIColor lightGrayColor]];
    self.textComment.text = @"Add Comment";
    if ([self.arrObj count] > 0)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrObj count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.view.frame.size.height);
    [self.waitView removeFromSuperview];
}
- (void)PFDzApi:(id)sender DzApiCommentObjectErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    [self.waitView removeFromSuperview];
}
- (void)PFAccountViewControllerPhoto:(NSString *)link {
    [self.delegate PFNewsCommentViewControllerPhoto:link];
}
@end
