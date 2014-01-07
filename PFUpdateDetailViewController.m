//
//  PFUpdateDetailViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/25/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFUpdateDetailViewController.h"
#import "UIView+MTAnimation.h"
#define FONT_SIZE 15.0f
#define CELL_CONTENT_WIDTH 280.0f
#define CELL_CONTENT_MARGIN 4.0f
#define FONT_SIZE_COMMENT 14.0f
BOOL noData;
BOOL refreshData;
@interface PFUpdateDetailViewController ()

@end
int maxH;

@implementation PFUpdateDetailViewController
int countHeight;
NSInteger comCount;
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
    self.prevString = [[NSString alloc] init];
    self.arrObj = [[NSMutableArray alloc] init];
    self.w.layer.cornerRadius = 5;
    self.w.layer.masksToBounds = YES;
    [self.view addSubview:self.waitView];
    self.newsObj = [[NSDictionary alloc] init];
    comCount = 0;
    maxH = 0;
    self.navigationController.delegate = self;
    self.textComment.delegate = self;
    [self.textComment.layer setCornerRadius:4.0];
    //self.navigationController.navigationBar.backgroundColor  = [UIColor colorWithRed:255/255.0 green:168/255.0 blue:0/255.0 alpha:0.8];

    UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a2 setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 30.0f)];
    [a2 addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
    [a2 setTitle:@"Back" forState:UIControlStateNormal];
    //[a1 setImage:[UIImage imageNamed:@"SettingIconIp5@2x"] forState:UIControlStateNormal];
    //UIBarButtonItem *backBut = [[UIBarButtonItem alloc] initWithCustomView:a2];
    //self.navigationItem.leftBarButtonItem = backBut;
    // Setup Textbox
    self.tableView.tableFooterView = self.footTablewView;
    self.commentTextFieldView.frame = CGRectMake(0, 0, 320, 356);
    [self.view addSubview:self.commentTextFieldView];
    //self.navigationController.view.frame = CGRectMake(0, 0, 320, 568);
    // Do any additional setup after loading the view from its nib.

    [self.detailView.layer setCornerRadius:4.0f];
    [self.detailView setBackgroundColor:RGB(208, 210, 211)];
    
    PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    newsManager.delegate = self;
    [newsManager getNewsById:self.newsId];
    
    self.commentTextView.delegate = self;
    [self.commentDownTapped setFrame:CGRectMake(0, 464, self.commentDownTapped.frame.size.width, self.commentDownTapped.frame.size.height)];
   // [self.view addSubview:self.commentDownTapped];
    
    self.commentTextFieldView.frame = CGRectMake(0, 0, 320, 356);
    [self.view addSubview:self.commentTextFieldView];
    if (IS_WIDESCREEN) {
        self.textCommentView.frame = CGRectMake(0, 464+60, 320, 356);
    } else {
        self.textCommentView.frame = CGRectMake(0, 440, 320, 356);
    }
    
    [self.view addSubview:self.textCommentView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@news/%@?fields=like,comment",API_URL,self.newsId]autorelease];
    NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
    __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
    [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [requestLikeComment setCompletionBlock:^{
        
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
        
        NSString *likeStr = [[NSString alloc] initWithFormat:@"%d Likes",[[[resJson objectForKey:@"like"] objectForKey:@"length"] intValue]];
        self.likeLabel.text = likeStr;
        NSString *commentStr = [[NSString alloc] initWithFormat:@"%d Comments",[[[resJson objectForKey:@"comment"] objectForKey:@"length"] intValue]];
        self.commentLabel.text = commentStr;
        if ( [[[resJson objectForKey:@"like"] objectForKey:@"is_liked"] intValue] == 1 ) {
            //[self.realLikeBut setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5@2x"] forState:UIControlStateNormal];
            [self.likeBut setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5@2x"] forState:UIControlStateNormal];
            
        }
        
    }];
    [requestLikeComment setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [requestLikeComment startAsynchronous];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //self.commentTextFieldView.frame = CGRectMake(0, 234, self.commentTextFieldView.frame.size.width, self.commentTextFieldView.frame.size.height);
    return;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    /*
    if (textField == self.commentTextView) {
        [textField resignFirstResponder];
        //self.commentTextFieldView.frame = CGRectMake(0, 410, 320, 54);
        return NO;
    }*/
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)] autorelease];
    UIImageView *imgViewPrev = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 3)];
    UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, 37, 300, 3)];
    imgViewLine.image = [UIImage imageNamed:@"LineCommentBoxIp5.png"];
    imgViewPrev.image = [self imageRotatedByDegrees:[UIImage imageNamed:@"FootCommentBoxEndIp5@2x"] deg:180];;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(loadComment)
     forControlEvents:UIControlEventTouchDown];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:self.prevString forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 3, 300, 37);
    [button setContentMode:UIViewContentModeScaleAspectFit];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"linePrev.png"] forState:UIControlStateNormal];
    [headerView addSubview:button];
    [headerView addSubview:imgViewPrev];
    [headerView addSubview:imgViewLine];
    return headerView;
    
}
- (void)loadComment {
    if (!noData){
        [self.view addSubview:self.waitView];
        refreshData = NO;
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiCommentObjectId:self.newsId limit:@"NO" next:self.paging];
    }
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.arrObj count] < 4  ) {
        return 0;
    } else {
        return  40.0;
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
    //return 79;
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
    //NSLog(@"%@",[[[self.commentDict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"from"]);
    //cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"http://61.19.147.72/api/user/%@/picture",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"from"] objectForKey:@"id"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [cell.myImageView loadImageFromURL:url];
    /*
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
    */
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
- (void)PFNewsManager:(id)sender getNewsByIdResponse:(NSDictionary *)response {
    self.newsObj = response;
    
    self.msgLabel.text = [response objectForKey:@"message"];
    NSString *str = [[NSString alloc] init];
    str = [response objectForKey:@"message"];
    
    NSString *text = str;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 24.0f) + 10;
    
    NSString *h = [[NSString alloc] initWithFormat:@"%f",height + (CELL_CONTENT_MARGIN * 2)];

    int lineValue = [h intValue]/16;
    self.msgLabel.numberOfLines = lineValue;
    int heightLable = 20*lineValue;
    self.msgLabel.frame = CGRectMake(self.msgLabel.frame.origin.x, self.msgLabel.frame.origin.y, self.msgLabel.frame.size.width, heightLable);
    self.newsImg.frame = CGRectMake(self.newsImg.frame.origin.x, (self.msgLabel.frame.origin.y+heightLable)+10, self.newsImg.frame.size.width, self.newsImg.frame.size.height);
    self.myImageView.frame = CGRectMake(self.myImageView.frame.origin.x, (self.msgLabel.frame.origin.y+heightLable)+10+64, self.myImageView.frame.size.width, self.myImageView.frame.size.height);
    self.likeCommentShareView.frame = CGRectMake(self.likeCommentShareView.frame.origin.x, (self.newsImg.frame.origin.y+self.newsImg.frame.size.height)-10, self.likeCommentShareView.frame.size.width, self.likeCommentShareView.frame.size.height);
    self.playVideoButton.frame = self.myImageView.frame;
    self.myImageBut.frame = self.myImageView.frame;

    
    if ([[response objectForKey:@"media_type"] isEqualToString:@"video"]) {
        self.playVideoButton.alpha = 1;
        self.myImageBut.alpha = 0;
        NSString *fileUrl = [[NSString alloc] initWithFormat:@"%@",[[response objectForKey:@"video"] objectForKey:@"link"]];
        NSURL *fileURL = [NSURL URLWithString:fileUrl];
        [self.moviePlayerController.view setFrame:CGRectMake(0, 0, 0, 0)];

        NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[response objectForKey:@"video"] objectForKey:@"thumb"]]autorelease];
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.myImageView loadImageFromURL:url];

        self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doneButtonClick:)
                                                     name:MPMoviePlayerWillExitFullscreenNotification
                                                   object:nil];
        [self.view addSubview:self.moviePlayerController.view];
    } else if ([[response objectForKey:@"media_type"] isEqualToString:@"picture"] ){
        
        NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=308&size_y=198",API_URL,[[response objectForKey:@"picture"] objectForKey:@"id"]]autorelease];
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.myImageView loadImageFromURL:url];
    } else {
        NSString *urlStr = [[[NSString alloc] initWithFormat:@"http://61.19.147.72/api/picture/default.jpg"]autorelease];
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.myImageView loadImageFromURL:url];

    }
    NSString *pubDate = [[NSString alloc]initWithFormat:@"%@",[response objectForKey:@"created_text"]];
    
    self.pubDate.text = pubDate;
    self.detailView.frame = CGRectMake(self.detailView.frame.origin.x, self.detailView.frame.origin.y, self.detailView.frame.size.width, self.msgLabel.frame.size.height+self.newsImg.frame.size.height+self.likeCommentShareView.frame.size.height);
    
    self.contentView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.detailView.frame.size.height+50+64);
    self.tableView.tableHeaderView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.tableView.tableHeaderView = self.contentView;

    
    
    
    [self.tableView reloadData];
    [self.tableView endUpdates];
    /*
    PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    newsManager.delegate = self;
    [newsManager getCommentNewsId:self.newsId limit:5 linkUrl:nil];
    */
    
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiCommentObjectId:self.newsId limit:@"5" next:@"NO"];
}
- (void)PFNewsManager:(id)sender getNewsByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (void)dealloc {
    [_likeLabel release];
    [_commentLabel release];
    [_newsImg release];
    [_msgLabel release];
    [_likeCommentShareView release];
    [_playVideoButton release];
    [_pubDate release];
    [_commentTextFieldView release];
    [_commentTextView release];
    [_commentBut release];
    [_realCommentBut release];
    [_likeBut release];
    [_realLikeBut release];
    [_shareBut release];
    [_realShareBut release];
    [_footTablewView release];
    [_commentDownTapped release];
    [_myImageBut release];

    [_postBut release];
    [_waitView release];
    [_w release];
    [super dealloc];
}
- (IBAction)playVideo:(id)sender {
    [self.moviePlayerController.view setFrame:CGRectMake(0, 70, 320, 270)];
    self.moviePlayerController.fullscreen = YES;
    [self.moviePlayerController play];
}
-(void)doneButtonClick:(NSNotification*)aNotification{
    NSLog(@"video done");
    [self.moviePlayerController.view setFrame:CGRectMake(0, 0, 0, 0)];
    [self.moviePlayerController stop];
}
- (void)PFNewsManager:(id)sender getCommentNewsIdResponse:(NSDictionary *)response {
    self.commentDict = response;
    int commentCell = 0;
    if ( [[self.commentDict objectForKey:@"length"] intValue] == 0 ) {
        commentCell = 0;
    } else {
        commentCell = ([self.arrObj count]*45);
    }

    self.tableView.contentSize = CGSizeMake(320, self.tableView.tableHeaderView.frame.size.height+commentCell+60);
    [self.tableView reloadData];

    self.commentBut.frame = CGRectMake(self.likeCommentShareView.frame.origin.x+100+10, self.likeCommentShareView.frame.origin.y+31+11+64, self.realCommentBut.frame.size.width, self.realCommentBut.frame.size.height);
    self.likeBut.frame = CGRectMake(self.likeCommentShareView.frame.origin.x+10, self.likeCommentShareView.frame.origin.y+31+11+64, self.realLikeBut.frame.size.width, self.realLikeBut.frame.size.height);
    self.shareBut.frame = CGRectMake(self.likeCommentShareView.frame.origin.x+198+12, self.likeCommentShareView.frame.origin.y+31+11+64, self.realShareBut.frame.size.width, self.realShareBut.frame.size.height);
    self.commentBut.alpha = 1;
    self.likeBut.alpha = 1;
    self.shareBut.alpha = 1;
    [self.waitView removeFromSuperview];
}
- (void)PFNewsManager:(id)sender getCommentNewsIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (IBAction)commentTapped:(id)sender {
  [self.textComment becomeFirstResponder];
}


- (IBAction)likeTapped:(id)sender {
    //[self.view addSubview:self.waitView];
    [self.likeBut setHighlighted:YES];
    PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *newsIdStr =[[NSString alloc] initWithFormat:@"%@",self.newsId];
    NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@news/%@?fields=like,comment",API_URL,newsIdStr]autorelease];
    NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
    __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
    [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [requestLikeComment setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
        if ( [[[resJson objectForKey:@"like"] objectForKey:@"is_liked"] intValue] == 1 ) {
            [newsManager unLikeNewsId:[defaults objectForKey:@"token"] newsId:newsIdStr];
            [self.likeBut setBackgroundImage:[UIImage imageNamed:@"LikeBottonIp5"] forState:UIControlStateNormal];
            int likeCount = [[self.likeLabel.text substringToIndex:2]intValue]-1;
            self.likeLabel.text = [[NSString alloc]initWithFormat:@"%d Likes",likeCount];
        } else {
            [newsManager likeNewsId:[defaults objectForKey:@"token"] newsId:newsIdStr];
            [self.likeBut setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5@2x"] forState:UIControlStateNormal];
            int likeCount = [[self.likeLabel.text substringToIndex:2]intValue]+1;
            self.likeLabel.text = [[NSString alloc]initWithFormat:@"%d Likes",likeCount];
        }
        [self.likeBut setHighlighted:NO];
        
    }];
    [requestLikeComment setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [requestLikeComment startAsynchronous];
}

- (IBAction)shareTapped:(id)sender {
    NSString *urlString = [[NSString alloc]init];
    if ([[self.newsObj objectForKey:@"media_type"] isEqualToString:@"picture"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@",[[self.newsObj objectForKey:@"picture"] objectForKey:@"link"]];
    } else {
        urlString = [[[NSString alloc] initWithFormat:@"http://61.19.147.72/api/picture/default.jpg"]autorelease];
    }
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller addURL:[NSURL URLWithString:urlString]];
        [controller setInitialText:[self.newsObj objectForKey:@"message"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)closeComment:(id)sender {
    
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
- (void)closeCommentBox {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.view.frame.size.height);
    [self.tableView setContentOffset:CGPointZero animated:YES];
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
                       
                         [self.textComment setTextColor:[UIColor lightGrayColor]];
                             self.textComment.text = @"Add Comment";
    
                         [self.waitView removeFromSuperview];
                         
                     }];
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    if ([[self.commentDict objectForKey:@"data"] count] > 0)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[self.commentDict objectForKey:@"data"] count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.view.frame.size.height);
    [UIView commitAnimations];
}
- (void)PFNewsManager:(id)sender commentNewsByIdResponse:(NSDictionary *)response {
    [self closeCommentBox];
}
- (void)PFNewsManager:(id)sender commentNewsByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (IBAction)postCommentTapped:(id)sender {
    if (![self.textComment.text isEqualToString:@""]) {
        [self.view addSubview:self.waitView];
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiCommentObject:self.newsId msg:self.textComment.text];
        int commentCount = [[self.commentLabel.text substringToIndex:2]intValue]+1;
        self.commentLabel.text = [[NSString alloc]initWithFormat:@"%d comment",commentCount];
    }
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //self.tableView.tableFooterView = self.footTablewView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
    if ( scrollView == self.tableView ) {
        float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
        if (offset >= 0 && offset <= 5) {
            if ( [[self.commentDict objectForKey:@"paging"] objectForKey:@"next"] == nil ) {
                NSLog(@"no data rows");
            } else {
                NSLog(@"load more rows");
                PFNewsManager *newsManager = [[PFNewsManager alloc] init];
                newsManager.delegate = self;
                [newsManager getCommentNewsId:self.newsId limit:0 linkUrl:[[self.commentDict objectForKey:@"paging"] objectForKey:@"next"]];
            }
        }
    }*/
}
- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(PFUpdateDetailViewControllerBackTapped:)]){
        [self.delegate PFUpdateDetailViewControllerBackTapped:self];
    }
}
- (IBAction)imgTapped:(id)sender {
    [self.delegate PFUpdateDetailViewControllerPhoto:[[self.newsObj objectForKey:@"picture"] objectForKey:@"link"]];
    [self bgTapped:self];
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
    [self.scrollView setContentOffset:CGPointZero animated:YES];
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


#pragma mark -
#pragma mark View

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.visibleViewController isKindOfClass:[PFAccountViewController class]]) {
        
    } else if ([self.navigationController.visibleViewController isKindOfClass:[MWPhotoBrowser class]]) {
        
    }else {
        if (self.navigationController.visibleViewController != self) {
            if([self.delegate respondsToSelector:@selector(PFUpdateDetailViewControllerBackTapped:)]){
                [self.delegate PFUpdateDetailViewControllerBackTapped:self];
            }
        }
    }
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}
- (void)PFAccountViewControllerPhoto:(NSString *)link {
    [self.delegate PFUpdateDetailViewControllerPhoto:link];
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
    self.commentBut.frame = CGRectMake(self.likeCommentShareView.frame.origin.x+100+10, self.likeCommentShareView.frame.origin.y+31+11+64, self.realCommentBut.frame.size.width, self.realCommentBut.frame.size.height);
    self.likeBut.frame = CGRectMake(self.likeCommentShareView.frame.origin.x+10, self.likeCommentShareView.frame.origin.y+31+11+64, self.realLikeBut.frame.size.width, self.realLikeBut.frame.size.height);
    self.shareBut.frame = CGRectMake(self.likeCommentShareView.frame.origin.x+198+12, self.likeCommentShareView.frame.origin.y+31+11+64, self.realShareBut.frame.size.width, self.realShareBut.frame.size.height);
    self.commentBut.alpha = 1;
    self.likeBut.alpha = 1;
    self.shareBut.alpha = 1;
    [self.waitView removeFromSuperview];
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
@end
