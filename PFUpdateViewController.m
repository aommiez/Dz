//
//  PFUpdateViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFUpdateViewController.h"
#import "PFTabBarViewController.h"

@interface PFUpdateViewController ()

@end
BOOL load;
BOOL noDataz;
BOOL refreshData;
@implementation PFUpdateViewController

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
    self.w.layer.cornerRadius = 5;
    self.w.layer.masksToBounds = YES;
    [self.view addSubview:self.waitView];
    load = NO;
    noDataz = NO;
    refreshData = NO;
    //self.navController.view.frame = CGRectMake(0, 0, 320, 524);
    //[self.navBg setBackgroundColor:NAV_RGB];
    
    if (IS_WIDESCREEN) {
        AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navController.navigationBar.frame), 64)];
        [backgroundView setBlurTintColor:[UIColor colorWithRed:1.000000 green:0.685938 blue:0.007812 alpha:0.792188]];
        [self.navController.view insertSubview:backgroundView belowSubview:self.navController.navigationBar];
    } else {
        self.topNav.frame = CGRectMake(0, 0, 320, 20);
        [self.navController.view addSubview:self.topNav];
    }
 
    self.arrObj = [[NSMutableArray alloc] init];
    
    
    NSShadow *titleShadow = [[NSShadow alloc] init];
    titleShadow.shadowOffset = CGSizeMake(0.0f, -1.0f);
    titleShadow.shadowColor = [UIColor blackColor];
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                NSShadowAttributeName: titleShadow};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    self.navController.delegate = self;
    self.navController.navigationBar.tintColor = [UIColor whiteColor];

    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Dance Zone"];
    [self.NavItem setTitleView:myLabel];

    
    UIButton *a1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a1 setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [a1 addTarget:self action:@selector(accountTapped) forControlEvents:UIControlEventTouchUpInside];
    [a1 setImage:[UIImage imageNamed:@"SettingIconIp5"] forState:UIControlStateNormal];
    UIBarButtonItem *random = [[UIBarButtonItem alloc] initWithCustomView:a1];
    self.tableView.frame = CGRectMake(0, 64, 320, self.tableView.bounds.size.height);
    self.NavItem.leftBarButtonItem = random;
    
    
    UIButton *a2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [a2 setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [a2 addTarget:self action:@selector(noteTapped) forControlEvents:UIControlEventTouchUpInside];
    [a2 setImage:[UIImage imageNamed:@"NotificationIconIp5"] forState:UIControlStateNormal];
    UIBarButtonItem *random1 = [[UIBarButtonItem alloc] initWithCustomView:a2];
    self.tableView.frame = CGRectMake(0, 64, 320, self.tableView.bounds.size.height);
    self.NavItem.rightBarButtonItem = random1;
    
    
    self.navController.navigationBar.translucent = YES;

    [self.view addSubview:self.navController.view];
    /*PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    newsManager.delegate = self;
    [newsManager getNews];
     */
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiFeed:@"5" link:@"NO"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_tableView release];
    [_navBg release];
    [_topView release];
    [_waitView release];
    [_loadLabel release];
    [_act release];
    [super dealloc];
}
- (void)noteTapped:(NSString *)nObj type:(NSString *)type {
    if (IS_WIDESCREEN){
        PFNotificationViewController *notificationView = [[PFNotificationViewController alloc] initWithNibName:@"PFNotificationViewController_Wide" bundle:nil];
        notificationView.delegate = self;
        notificationView.nString = nObj;
        notificationView.type = type;
        [self.navController pushViewController:notificationView animated:YES];
    } else {
        PFNotificationViewController *notificationView = [[PFNotificationViewController alloc] initWithNibName:@"PFNotificationViewController" bundle:nil];
        notificationView.delegate = self;
        [self.navController pushViewController:notificationView animated:YES];
    }
}
- (void)noteTapped {
    if (IS_WIDESCREEN){
        PFNotificationViewController *notificationView = [[PFNotificationViewController alloc] initWithNibName:@"PFNotificationViewController_Wide" bundle:nil];
        notificationView.delegate = self;
        [self.navController pushViewController:notificationView animated:YES];
    } else {
        PFNotificationViewController *notificationView = [[PFNotificationViewController alloc] initWithNibName:@"PFNotificationViewController" bundle:nil];
        notificationView.delegate = self;
        [self.navController pushViewController:notificationView animated:YES];
    }
}
- (void)accountTapped {
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFAccountSettingViewController *accountSetting = [[PFAccountSettingViewController alloc] initWithNibName:@"PFAccountSettingViewController_Wide" bundle:nil];
        accountSetting.delegate = self;
        [self.navController pushViewController:accountSetting animated:YES];
    } else {
        PFAccountSettingViewController *accountSetting = [[PFAccountSettingViewController alloc] initWithNibName:@"PFAccountSettingViewController" bundle:nil];
        accountSetting.delegate = self;
        [self.navController pushViewController:accountSetting animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 356;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpdateCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpdateCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.delegate = self;
    

    // if type
    if ( [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"news"]) {

        // type news
        if ( [[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"news"] objectForKey:@""] isEqualToString:@"video" ]) {
            
            NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"news"] objectForKey:@"video"] objectForKey:@"thumb"]]autorelease];
            NSURL *url = [NSURL URLWithString:urlStr];

            [cell.myImageView loadImageFromURL:url];
            
        } else {
            NSString *urlStr = [[NSString alloc] init];
            NSLog(@"%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"news"] objectForKey:@"media_type"]);
            //NSLog(@"%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"news"] objectForKey:@"picture"]);
            if (IS_WIDESCREEN) {
                urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=616&size_y=396",API_URL,[[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"news"] objectForKey:@"picture"] objectForKey:@"id"]]autorelease];
            } else {
                urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=308&size_y=198",API_URL,[[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"news"] objectForKey:@"picture"] objectForKey:@"id"]]autorelease];
            }
            NSURL *url = [NSURL URLWithString:urlStr];
            
            [cell.myImageView loadImageFromURL:url];
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@news/%@?fields=like,comment",API_URL,[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"id"]]autorelease];
        NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
        __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
        [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
        [requestLikeComment setCompletionBlock:^{
            
            SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
            id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
            
            NSString *likeStr = [[NSString alloc] initWithFormat:@"%d Likes",[[[resJson objectForKey:@"like"] objectForKey:@"length"] intValue]];
            cell.likeLabel.text = likeStr;
            NSString *commentStr = [[NSString alloc] initWithFormat:@"%d Comments",[[[resJson objectForKey:@"comment"] objectForKey:@"length"] intValue]];
            cell.commentLabel.text = commentStr;
            if ( [[[resJson objectForKey:@"like"] objectForKey:@"is_liked"] intValue] == 1 ) {
                [cell.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5@2x"] forState:UIControlStateNormal];
            }
        }];
        [requestLikeComment setFailedBlock:^{
            //NSError *error = [request error];
        }];
        [requestLikeComment startAsynchronous];
        
        
        
        NSString *pubDate = [[NSString alloc]initWithFormat:@"%@",[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"news"]objectForKey:@"created_text"]];
        cell.pubDate.text = pubDate;
        cell.likeButton.tag = [[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"id"] intValue];
        cell.commentBut.tag = [[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"id"] intValue];
        cell.shareBut.tag = [[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"id"] intValue];
        cell.imgBut.tag = [indexPath row];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.detailView.layer setCornerRadius:4.0f];
        [cell.detailView setBackgroundColor:RGB(204, 204, 204)];
        cell.newsTitle.text = [[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"news"]objectForKey:@"message"];
        
        UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapOnce:)];
        UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapTwice:)];
        
        
        tapOnce.numberOfTapsRequired = 1;
        tapTwice.numberOfTapsRequired = 2;
        
        //stops tapOnce from overriding tapTwice
        [tapOnce requireGestureRecognizerToFail:tapTwice];
        
        //then need to add the gesture recogniser to a view - this will be the view that recognises the gesture
        [cell.imgBut addGestureRecognizer:tapOnce];
        [cell.imgBut addGestureRecognizer:tapTwice];
    } else if ( [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"showcase"]) {
        NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"showcase"] objectForKey:@"thumb"] ]autorelease];
 
        NSURL *url = [NSURL URLWithString:urlStr];
        [cell.myImageView loadImageFromURL:url];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@showcase/%@?fields=like,comment",API_URL,[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"id"]]autorelease];

        NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
        __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
        [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
        [requestLikeComment setCompletionBlock:^{
            
            SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
            id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
            
            NSString *likeStr = [[NSString alloc] initWithFormat:@"%d Likes",[[[resJson objectForKey:@"like"] objectForKey:@"length"] intValue]];
            cell.likeLabel.text = likeStr;
            NSString *commentStr = [[NSString alloc] initWithFormat:@"%d Comments",[[[resJson objectForKey:@"comment"] objectForKey:@"length"] intValue]];
            cell.commentLabel.text = commentStr;
            if ( [[[resJson objectForKey:@"like"] objectForKey:@"is_liked"] intValue] == 1 ) {
                [cell.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5@2x"] forState:UIControlStateNormal];
            }
            
            
        }];
        [requestLikeComment setFailedBlock:^{
            //NSError *error = [request error];
        }];
        [requestLikeComment startAsynchronous];
        
        cell.shareBut.tag = [[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"showcase"] objectForKey:@"id"] intValue];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.detailView.layer setCornerRadius:4.0f];
        [cell.detailView setBackgroundColor:RGB(204, 204, 204)];
        cell.newsTitle.text = [[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"showcase"]objectForKey:@"description"];
        NSString *pubDate = [[NSString alloc]initWithFormat:@"%@",[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"showcase"]objectForKey:@"created_text"]];
        cell.pubDate.text = pubDate;
        
        cell.likeButton.tag = [[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"showcase"] objectForKey:@"id"] intValue];
        
        
        
        UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(showCaseTapped:)];
        tapOnce.numberOfTapsRequired = 1;
        [cell.imgBut addGestureRecognizer:tapOnce];
    } else if ([[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"activity"]) {
        
        NSString *urlStr = [[NSString alloc] init];
        
        if (IS_WIDESCREEN ) {
            urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=616&size_y=396",API_URL,[[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"activity"] objectForKey:@"picture"] objectForKey:@"id"] ]autorelease];
        } else {
            urlStr = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=308&size_y=198",API_URL,[[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"activity"] objectForKey:@"picture"] objectForKey:@"id"] ]autorelease];
        }
        
        NSURL *url = [NSURL URLWithString:urlStr];
        [cell.myImageView loadImageFromURL:url];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@activity/%@?fields=like,comment",API_URL,[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"id"]]autorelease];
    
        NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
        __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
        [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
        [requestLikeComment setCompletionBlock:^{
            
            SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
            id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
            
            NSString *likeStr = [[NSString alloc] initWithFormat:@"%d Likes",[[[resJson objectForKey:@"like"] objectForKey:@"length"] intValue]];
            cell.likeLabel.text = likeStr;
            NSString *commentStr = [[NSString alloc] initWithFormat:@"%d Comments",[[[resJson objectForKey:@"comment"] objectForKey:@"length"] intValue]];
            cell.commentLabel.text = commentStr;
            if ( [[[resJson objectForKey:@"like"] objectForKey:@"is_liked"] intValue] == 1 ) {
                [cell.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5@2x"] forState:UIControlStateNormal];
            }
            
            
        }];
        [requestLikeComment setFailedBlock:^{
            //NSError *error = [request error];
        }];
        [requestLikeComment startAsynchronous];
        cell.shareBut.tag = [[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"activity"] objectForKey:@"id"] intValue];
        cell.likeButton.tag = [[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"activity"] objectForKey:@"id"] intValue];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.detailView.layer setCornerRadius:4.0f];
        [cell.detailView setBackgroundColor:RGB(204, 204, 204)];
        cell.newsTitle.text = [[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"activity"]objectForKey:@"message"];
        NSString *pubDate = [[NSString alloc]initWithFormat:@"%@",[[[self.arrObj objectAtIndex:[indexPath row]] objectForKey:@"activity"]objectForKey:@"created_text"]];
        cell.pubDate.text = pubDate;
        UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(activityTapped:)];
        tapOnce.numberOfTapsRequired = 1;
        [cell.imgBut addGestureRecognizer:tapOnce];
    }
    return cell;
}
- (void)activityTapped:(UIGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.tableView];
    NSIndexPath *tapIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController_Wide" bundle:nil];
        activitiesDetailViewController.obj = [[self.arrObj objectAtIndex:[tapIndexPath row]] objectForKey:@"activity"];
        activitiesDetailViewController.delegate = self;
        [self.navController pushViewController:activitiesDetailViewController animated:YES];
    } else {
        PFActivitiesDetailViewController *activitiesDetailViewController = [[PFActivitiesDetailViewController alloc] initWithNibName:@"PFActivitiesDetailViewController" bundle:nil];
        activitiesDetailViewController.obj = [[self.arrObj objectAtIndex:[tapIndexPath row]] objectForKey:@"activity"];
        activitiesDetailViewController.delegate = self;
        [self.navController pushViewController:activitiesDetailViewController animated:YES];
    }
}
- (void)showCaseTapped:(UIGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.tableView];
    NSIndexPath *tapIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController_Wide" bundle:nil];
        youTubeViewController.youtubeId = [[[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"showcase"]objectForKey:@"youtube_id"];
        youTubeViewController.youtubeObj = [[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"showcase"];
        youTubeViewController.delegate = self;
        [self.navController pushViewController:youTubeViewController animated:YES];
    } else {
        PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController" bundle:nil];
        youTubeViewController.youtubeId = [[[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"showcase"]objectForKey:@"youtube_id"];
        youTubeViewController.youtubeObj = [[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"showcase"];
        youTubeViewController.delegate = self;
        [self.navController pushViewController:youTubeViewController animated:YES];
    }
}
- (void)tapOnce:(UIGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.tableView];
    NSIndexPath *tapIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController_Wide" bundle:nil];
        updateDetailViewController.newsId = [[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"id"];
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    } else {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController" bundle:nil];
        updateDetailViewController.newsId = [[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"id"];
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    }
}
- (void)tapTwice:(UIGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.tableView];
    NSIndexPath *tapIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    [self.tabbarViewController showPhoto:[[[self.arrObj objectAtIndex:tapIndexPath.row] objectForKey:@"picture"] objectForKey:@"link"]];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController_Wide" bundle:nil];
        updateDetailViewController.newsId = [[[self.dict objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"id"];
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    } else {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController" bundle:nil];
        updateDetailViewController.newsId = [[[self.dict objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"id"];
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    }*/
}

- (void)PFAccountSettingViewControllerBackTapped:(id)sender {
    [self.tabbarViewController showTabBar];
}
- (void)PFAccountSettingViewControllerPhoto:(NSString *)link {
    [self.tabbarViewController showPhoto:link];
}
- (void)PFUpdateDetailViewControllerBackTapped:(id)sender {
    //[self reloadData:YES];
    if (!noDataz){
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height-270);
    } else {
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
    }
    [self.tabbarViewController showTabBar];

}
- (void)PFUpdateDetailViewControllerPhoto:(NSString *)link {
    [self.tabbarViewController showPhoto:link];
}
- (void)PFYouTubeViewControllerBackTapped:(id)sender {
    [self.tabbarViewController showTabBar];
}
- (void)PFActivitiesDetailViewControllerBack {
    [self.tabbarViewController showTabBar];
}
- (void)PFNewsCommentViewControllerPhoto:(NSString *)link {
    [self.tabbarViewController showPhoto:link];
}
- (void)PFYouTubeViewControllerPhoto:(NSString *)link {
    [self.tabbarViewController showPhoto:link];
}
- (void)PFActivitiesDetailViewControllerPhoto:(NSString *)link {
    [self.tabbarViewController showPhoto:link];
}
- (void)shareFb:(NSDictionary *)res {

    NSString *urlString = [[NSString alloc]init];
    NSString *msg = [[NSString alloc]init];
    if ([[res objectForKey:@"type"] isEqualToString:@"activity"]) {
        msg = [[res objectForKey:@"activity"] objectForKey:@"message"];
        urlString = [[[NSString alloc] initWithFormat:@"%@",[[[res objectForKey:@"activity"] objectForKey:@"picture"] objectForKey:@"link"]]autorelease];
   
    } else if ([[res objectForKey:@"type"] isEqualToString:@"news"]) {
        msg = [[res objectForKey:@"news"] objectForKey:@"message"];
        if ([[[res objectForKey:@"news"] objectForKey:@"media_type"] isEqualToString:@"picture"]) {
            urlString = [[NSString alloc]initWithFormat:@"%@",[[[res objectForKey:@"news"] objectForKey:@"picture"] objectForKey:@"link"]];
        } else {
            urlString = [[[NSString alloc] initWithFormat:@"http://61.19.147.72/api/picture/default.jpg"]autorelease];
        }
    } else if ([[res objectForKey:@"type"] isEqualToString:@"showcase"]) {
        msg = [[[NSString alloc] initWithFormat:@"%@     https://www.youtube.com/%@",[[res objectForKey:@"showcase"] objectForKey:@"description"],[[res objectForKey:@"showcase"] objectForKey:@"youtube_id"]]autorelease];
        urlString = [[[NSString alloc] initWithFormat:@"%@",[[res objectForKey:@"showcase"] objectForKey:@"thumb"]]autorelease];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller addURL:[NSURL URLWithString:urlString]];
        [controller setInitialText:msg];
        [self presentViewController:controller animated:YES completion:Nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Dance Zone"
                                    message:@"โปรด Login Facebook ใน Setting เครื่องก่อนครับ"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}
- (void)commentView:(NSString *)newsId {
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFNewsCommentViewController *newsComment = [[PFNewsCommentViewController alloc] initWithNibName:@"PFNewsCommentViewController_Wide" bundle:nil];
        newsComment.newsId = newsId;
        newsComment.delegate = self;
        [self.navController pushViewController:newsComment animated:YES];
    } else {
        PFNewsCommentViewController *newsComment = [[PFNewsCommentViewController alloc] initWithNibName:@"PFNewsCommentViewController" bundle:nil];
        newsComment.newsId = newsId;
        newsComment.delegate = self;
        [self.navController pushViewController:newsComment animated:YES];
    }
}
- (void)PFNewsCommentViewControllerBackTapped:(id)sender {
    [self.tabbarViewController showTabBar];
    refreshData = YES;
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiFeed:@"5" link:@"NO"];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	//NSLog(@"%f",scrollView.contentOffset.y);
    
	//[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ( scrollView.contentOffset.y < 0.0f ) {
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -60.0f ) {
        refreshData = YES;
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        dzApi.delegate = self;
        [dzApi DzApiFeed:@"5" link:@"NO"];
        
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if ( scrollView.contentOffset.y < -100.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.frame = CGRectMake(0, 60, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));

    if (offset >= 0 && offset <= 5) {
        if (!noDataz) {
            refreshData = NO;
            PFDzApi *dzApi = [[PFDzApi alloc] init];
            dzApi.delegate = self;
            [dzApi DzApiFeed:@"NO" link:self.paging];
        }
    }
}
- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
}

- (void)imgTapped:(NSString *)imgId {
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController_Wide" bundle:nil];
        updateDetailViewController.newsId = [[self.arrObj objectAtIndex:[imgId intValue]] objectForKey:@"id"];
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    } else {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController" bundle:nil];
        updateDetailViewController.newsId = [[self.arrObj objectAtIndex:[imgId intValue]] objectForKey:@"id"];
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    }
}
- (void)PFNotificationViewControllerNewsTapped:(id)sender newsId:(NSString *)newsId {
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController_Wide" bundle:nil];
        updateDetailViewController.newsId = newsId;
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    } else {
        PFUpdateDetailViewController *updateDetailViewController = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController" bundle:nil];
        updateDetailViewController.newsId = newsId;
        updateDetailViewController.delegate = self;
        [self.navController pushViewController:updateDetailViewController animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}
#pragma make - Dz API Delegate
- (void)PFDzApi:(id)sender DzAPiFeedResponse:(NSDictionary *)response {
  
    if (!refreshData) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    
    if ( [[response objectForKey:@"paging"] objectForKey:@"next"] == nil ) {
        noDataz = YES;
    } else {
        noDataz = NO;
        self.paging = [[response objectForKey:@"paging"] objectForKey:@"next"];
    }
    
    [self reloadData:YES];
    
    [self.waitView removeFromSuperview];

}
- (void)PFDzApi:(id)sender DzAPiFeedErrorResponse:(NSString *)errorResponse {
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
    
    if (!noDataz){
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height-270);
    } else {
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
    }
    
    //NSLog(@"%f",self.tableView.contentSize.height);
}

@end
