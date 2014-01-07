//
//  PFYouTubeViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFYouTubeViewController.h"
#import "UIView+MTAnimation.h"
#define FONT_SIZE 15.0f
#define CELL_CONTENT_WIDTH 280.0f
#define CELL_CONTENT_MARGIN 4.0f
#define FONT_SIZE_COMMENT 14.0f
@interface PFYouTubeViewController ()

@end

@implementation PFYouTubeViewController
BOOL noData;
BOOL refreshData;
int maxH;
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
    maxH = 0;
    noData = NO;
    refreshData = NO;
    self.w.layer.cornerRadius = 5;
    self.w.layer.masksToBounds = YES;
    self.arrObj = [[NSMutableArray alloc] init];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [[self.webView.subviews objectAtIndex:0] setBounces:NO];
    [self.detailView.layer setCornerRadius:4.0f];
    [self.detailView setBackgroundColor:RGB(204, 204, 204)];
    self.tableView.tableHeaderView = self.contentView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    NSString *urlStr = [[NSString alloc] initWithFormat:@"http://www.youtube.com/watch?v=%@",self.youtubeId];
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *videoReq = [NSURLRequest requestWithURL:url];
    [self.webView setDelegate:self];
    [self.webView loadRequest:videoReq];
    self.titleLabel.text = [self.youtubeObj objectForKey:@"name"];
    self.desTextView.text = [self.youtubeObj objectForKey:@"description"];

    NSString *dateText = [[NSString alloc] initWithFormat:@"Published  %@",[[self.youtubeObj objectForKey:@"updated_at"]substringToIndex:10]];
    self.dateUploadLabel.text = dateText;
    self.commentLabel.text = [self.youtubeObj objectForKey:@"comment_count"];
    self.likeLabel.text = [self.youtubeObj objectForKey:@"like_count"];
    self.viewLabel.text = [[NSString alloc] initWithFormat:@"%@ views",[self.youtubeObj objectForKey:@"view_count"]];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Showcase"];
    [self.navigationItem setTitleView:myLabel];
    
    if (IS_WIDESCREEN) {
        self.textCommentView.frame = CGRectMake(0, 464+60, 320, 356);
    } else {
        self.textCommentView.frame = CGRectMake(0, 440, 320, 356);
    }
    self.textComment.delegate = self;
    [self.view addSubview:self.textCommentView];
    
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiCommentObjectId:[self.youtubeObj objectForKey:@"id"] limit:@"5" next:@"NO"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [_titleLabel release];
    [_desTextView release];
    [_dateUploadLabel release];
    [_waitView release];
    [_w release];
    [super dealloc];
}
- (UIButton *)findButtonInView:(UIView *)view {
    UIButton *button = nil;
    
    if ([view isMemberOfClass:[UIButton class]]) {
        return (UIButton *)view;
    }
    
    if (view.subviews && [view.subviews count] > 0) {
        for (UIView *subview in view.subviews) {
            button = [self findButtonInView:subview];
            if (button) return button;
        }
    }
    
    return button;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIButton *b = [self findButtonInView:webView];
    [b sendActionsForControlEvents:UIControlEventTouchUpInside];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.arrObj count] == 0 ) {
        return 0;
    } else {
        return  44.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)] autorelease];
    UIImageView *imgViewPrev = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 3)];
    UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43, 300, 3)];
    imgViewLine.image = [UIImage imageNamed:@"LineCommentBoxIp5.png"];
    imgViewPrev.image = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5@2x"] deg:180];;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(loadComment)
     forControlEvents:UIControlEventTouchDown];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:self.prevString forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 3, 300, 40);
    [button setContentMode:UIViewContentModeScaleAspectFit];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"linePrev.png"] forState:UIControlStateNormal];
    //headerView.backgroundColor = [UIColor redColor];
    [headerView addSubview:button];
    [headerView addSubview:imgViewPrev];
    [headerView addSubview:imgViewLine];
    return headerView;
    
}
- (void)loadComment {
    if (!noData){
        refreshData = NO;
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiCommentObjectId:[self.youtubeObj objectForKey:@"id"] limit:@"NO" next:self.paging];
    }
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
    cell.delegate = self;
    cell.commentLabel.frame = CGRectMake(cell.commentLabel.frame.origin.x, cell.commentLabel.frame.origin.y, cell.commentLabel.frame.size.width, heightLable);

    cell.timeComment.frame = CGRectMake(cell.timeComment.frame.origin.x,heightLable +14, cell.timeComment.frame.size.width, cell.timeComment.frame.size.height);
    cell.timeComment.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"created_text"];
    
    cell.imgBut.tag = [[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"id"] intValue];
    cell.commentLabel.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"message"];
    cell.nameLabel.text = [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"username"];
    //NSLog(@"%@",[[[self.commentDict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"from"]);
    //cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"http://61.19.147.72/api/user/%@/picture",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"id"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [cell.myImageView loadImageFromURL:url];

    NSInteger sectionsAmount = [tableView numberOfSections];
    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    
    if (indexPath.row == 0 ) {
        if ([self.arrObj count] > 1 ) {
            
            cell.lineImg.image = [UIImage imageNamed:@"LineCommentBoxIp5"];
            cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];;
            //cell.headImg.image = [UIImage imageNamed:@"HeadCommentBoxIp5"];
        } else {
            //cell.headImg.image = [UIImage imageNamed:@"HeadCommentBoxIp5"];
            cell.lineImg.image = [UIImage imageNamed:@"FootCommentBoxEndIp5"];
            
            cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self bgTapped:self];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[PFAccountViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFYouTubeViewControllerBackTapped:)]){
                [self.delegate PFYouTubeViewControllerBackTapped:self];
            }
        }
    }
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    self.prevString = [[NSString alloc]initWithFormat:@"View previous comments %@ total %@",[[response objectForKey:@"paging"] objectForKey:@"current"],[[response objectForKey:@"paging"] objectForKey:@"length"]];
    
    [self reloadData:YES];
    NSLog(@"%@",self.arrObj);
    
    
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
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

- (IBAction)bgTapped:(id)sender {
    //[self.scrollView setContentOffset:CGPointZero animated:YES];
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
                         //NSLog(@"%f",self.tableView.contentSize.height);
                         
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    if ([self.textComment.text isEqualToString:@""]) {
        [self.textComment setTextColor:[UIColor lightGrayColor]];
        self.textComment.text = @"Add Comment";
    }
}
- (IBAction)postCommentTapped:(id)sender {
    if (![self.textComment.text isEqualToString:@""]) {
        [self.view addSubview:self.waitView];
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiCommentObject:[self.youtubeObj objectForKey:@"id"] msg:self.textComment.text];
        //int commentCount = [[self.commentLabel.text substringToIndex:2]intValue]+1;
        //self.commentLabel.text = [[NSString alloc]initWithFormat:@"%d comment",commentCount];
    }
}
- (void)PFDzApi:(id)sender DzApiCommentObjectResponse:(NSDictionary *)response {
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
- (void)PFAccountViewControllerPhoto:(NSString *)link {
    [self.delegate PFYouTubeViewControllerPhoto:link];
}
@end
