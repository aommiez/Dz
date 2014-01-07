//
//  PFActivitiesDetailViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFActivitiesDetailViewController.h"
#import "UIView+MTAnimation.h"
#define FONT_SIZE 15.0f
#define CELL_CONTENT_WIDTH 280.0f
#define CELL_CONTENT_MARGIN 4.0f
#define FONT_SIZE_COMMENT 14.0f
@interface PFActivitiesDetailViewController ()

@end

@implementation PFActivitiesDetailViewController
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
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Activities"];
    [self.navigationItem setTitleView:myLabel];
    self.actName.text = [self.obj objectForKey:@"name"];
    self.actMessage.text = [self.obj objectForKey:@"message"];

    self.timeLabel.text = [[NSString alloc] initWithFormat:@"%@",[self.obj objectForKey:@"created_text"]];
    [self.detailView setBackgroundColor:RGB(204, 204, 204)];
    NSString *urlStr = [[NSString alloc] init];
    if (IS_WIDESCREEN) {
        urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=640",API_URL,[[self.obj objectForKey:@"picture"] objectForKey:@"id"]] autorelease];
    } else {
        urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=320",API_URL,[[self.obj objectForKey:@"picture"] objectForKey:@"id"]] autorelease];
    }

    NSURL *url = [NSURL URLWithString:urlStr];

    //[self.cImg loadImageFromURL:url];
    __block ASIHTTPRequest *requestz = [ASIHTTPRequest requestWithURL:url];
    [requestz setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [requestz responseData];
        UIImage *img = [UIImage imageWithData:responseData];
        
        if (IS_WIDESCREEN) {
            self.actImg.frame = CGRectMake(self.actImg.frame.origin.x, self.actImg.frame.origin.y, img.size.width/2, img.size.height/2);
            self.actImg.image = img;
            self.footContentView.frame = CGRectMake(self.footContentView.frame.origin.x, self.actImg.frame.size.height+44, self.footContentView.frame.size.width, self.footContentView.frame.size.height);
            self.contentView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.footContentView.frame.size.height+40+img.size.height/2);
            //self.detailView.frame = CGRectMake(self.detailView.frame.origin.x, self.detailView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height+img.size.height/2);
        } else {
            self.actImg.frame = CGRectMake(self.actImg.frame.origin.x, self.actImg.frame.origin.y, 300, img.size.height);
            self.actImg.image = img;
            self.footContentView.frame = CGRectMake(self.footContentView.frame.origin.x, self.actImg.frame.size.height+44, self.footContentView.frame.size.width, self.footContentView.frame.size.height);
            self.contentView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.footContentView.frame.size.height+40+img.size.height);
            //self.detailView.frame = CGRectMake(self.detailView.frame.origin.x, self.detailView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height+img.size.height);
            
        }
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
        [self.actImg addGestureRecognizer:singleTap];
        [self.actImg setMultipleTouchEnabled:YES];
        [self.actImg setUserInteractionEnabled:YES];
        self.tableView.tableHeaderView = self.contentView;
        self.tableView.tableFooterView = self.footTableView;
    }];
    [requestz setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [requestz startSynchronous];
    
    
    self.tableData = [NSArray arrayWithObjects:@"HIPHOP", @"JAZZ", @"COVER", @"BBOY", @"bla bla bla", nil];
    [self.detailView.layer setCornerRadius:4.0f];
    
    if (IS_WIDESCREEN) {
        self.textCommentView.frame = CGRectMake(0, 464+60, 320, 356);
    } else {
        self.textCommentView.frame = CGRectMake(0, 440, 320, 356);
    }
    self.textComment.delegate = self;
    [self.view addSubview:self.textCommentView];
    PFActivitiesManager *activitiesManager = [[PFActivitiesManager alloc] init];
    activitiesManager.delegate = self;
    [activitiesManager getActivitiesById:[self.obj objectForKey:@"id"]];
    
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiCommentObjectId:[self.obj objectForKey:@"id"] limit:@"5" next:@"NO"];
    
}
- (void)tapOnce:(UIGestureRecognizer *)gesture {
    [self bgTapped:self];
    NSString *url = [[NSString alloc]initWithFormat:@"%@",[[self.obj objectForKey:@"picture"] objectForKey:@"link"]];
    //[self.tabbarViewController showPhoto:urlStrz];
    [self.delegate PFActivitiesDetailViewControllerPhoto:url];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_navBg release];
    [_detailView release];
    [_contentView release];
    [_tableView release];
    [_footTableView release];
    [_actImg release];
    [_actName release];
    [_actMessage release];
    [_timeLabel release];
    [_joinBut release];
    [_waitView release];
    [_w release];
    [_cImg release];
    [_footContentView release];
    [super dealloc];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.arrObj count] < 4 ) {
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
        [dzApi DzApiCommentObjectId:[self.obj objectForKey:@"id"] limit:@"NO" next:self.paging];
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
    
    if ([self.arrObj count] < 4 ) {
        if (indexPath.row == 0 ) {
            if ([self.arrObj count] > 1 ) {
                UIImage *image2 = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5@2x"] deg:180];
                cell.lineImg.image = [UIImage imageNamed:@"LineCommentBoxIp5"];
                //cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];;
                cell.headImg.image = image2;
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
    } else {
        if (indexPath.row == 0 ) {
            if ([self.arrObj count] > 1 ) {
                UIImage *image2 = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5@2x"] deg:180];
                cell.lineImg.image = [UIImage imageNamed:@"LineCommentBoxIp5"];
                cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];;
                //cell.headImg.image = [UIImage imageNamed:@"HeadCommentBoxIp5"];
            } else {
                //cell.headImg.image = [UIImage imageNamed:@"HeadCommentBoxIp5"];
                cell.lineImg.image = [UIImage imageNamed:@"FootCommentBoxEndIp5"];
                UIImage *image2 = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5"] deg:180];
                cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];;
            }
        } else if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
            cell.lineImg.image = [UIImage imageNamed:@"FootCommentBoxEndIp5"];
            cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];
        } else {
            cell.headImg.image = [UIImage imageNamed:@"BodyCommentBoxIp5"];
        }
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

- (IBAction)joinTapped:(id)sender {
    
    PFActivitiesManager *actManager = [[PFActivitiesManager alloc] init];
    actManager.delegate = self;
    
    if ( [self.joinBut.titleLabel.text isEqualToString:@"Join"]) {
        [self.view addSubview:self.waitView];
        [actManager joinActivitiesId:[self.obj objectForKey:@"id"]];
    } else  if ( [self.joinBut.titleLabel.text isEqualToString:@"Joined"]) {
        [self showConfirmAlert];
    }
}
- (void)showConfirmAlert
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Confirm"];
    [alert setMessage:@"ต้องการยกเลิกการร่วมกิจกรรม ?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
    [alert release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    PFActivitiesManager *actManager = [[PFActivitiesManager alloc] init];
    actManager.delegate = self;
    if (buttonIndex == 0)
    {
        [self.view addSubview:self.waitView];
        [actManager unjoinActivitiesId:[self.obj objectForKey:@"id"]];
    }
    else if (buttonIndex == 1)
    {
        [self.waitView removeFromSuperview];
    }
}
- (void)PFActivitiesManager:(id)sender joinActivitiesIdResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    [self.joinBut setTitle:@"Joined" forState:UIControlStateNormal];
    [self.joinBut setBackgroundImage:[UIImage imageNamed:@"ButtonOrg.png"] forState:UIControlStateNormal];
    [self.waitView removeFromSuperview];
}
- (void)PFActivitiesManager:(id)sender joinActivitiesIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@", errorResponse);
    [self.waitView removeFromSuperview];
}
- (void)PFActivitiesManager:(id)sender unjoinActivitiesIdResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    [self.joinBut setTitle:@"Join" forState:UIControlStateNormal];
    [self.joinBut setBackgroundImage:[UIImage imageNamed:@"SubmitBottonIp5.png"] forState:UIControlStateNormal];
    [self.waitView removeFromSuperview];
}
- (void)PFActivitiesManager:(id)sender unjoinActivitiesIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    [self.waitView removeFromSuperview];
}
- (void)PFActivitiesManager:(id)sender getActivitiesByIdResponse:(NSDictionary *)response {
    if ([[response objectForKey:@"is_joined"] intValue] == 0 ) {
        [self.joinBut setBackgroundImage:[UIImage imageNamed:@"SubmitBottonIp5.png"] forState:UIControlStateNormal];
        [self.joinBut setTitle:@"Join" forState:UIControlStateNormal];
    } else {
        [self.joinBut setBackgroundImage:[UIImage imageNamed:@"ButtonOrg.png"] forState:UIControlStateNormal];
        [self.joinBut setTitle:@"Joined" forState:UIControlStateNormal];
    }
}
- (void)PFActivitiesManager:(id)sender getActivitiesByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    [self.waitView removeFromSuperview];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[PFAccountViewController class]]) {
        
    } else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFActivitiesDetailViewControllerBack)]){
                [self.delegate PFActivitiesDetailViewControllerBack];
            }
        }
    }
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (IBAction)postCommentTapped:(id)sender {
    if (![self.textComment.text isEqualToString:@""]) {
        [self.view addSubview:self.waitView];
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiCommentObject:[self.obj objectForKey:@"id"] msg:self.textComment.text];
        //int commentCount = [[self.commentLabel.text substringToIndex:2]intValue]+1;
        //self.commentLabel.text = [[NSString alloc]initWithFormat:@"%d comment",commentCount];
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
    self.prevString = [[NSString alloc]initWithFormat:@"View previous comments %@ total %@",[[response objectForKey:@"paging"] objectForKey:@"current"],[[response objectForKey:@"paging"] objectForKey:@"length"]];
    
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
    [self.delegate PFActivitiesDetailViewControllerPhoto:link];
}
@end
