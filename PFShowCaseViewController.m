//
//  PFShowCaseViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFShowCaseViewController.h"
#import "PFTabBarViewController.h"
@interface PFShowCaseViewController ()

@end

@implementation PFShowCaseViewController

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
   
    if (IS_WIDESCREEN) {
        AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navController.navigationBar.frame), 64)];
        [backgroundView setBlurTintColor:[UIColor colorWithRed:1.000000 green:0.685938 blue:0.007812 alpha:0.792188]];
        [self.navController.view insertSubview:backgroundView belowSubview:self.navController.navigationBar];
    } else {
        self.topNav.frame = CGRectMake(0, 0, 320, 20);
        [self.navController.view addSubview:self.topNav];
    }
    
    NSShadow *titleShadow = [[NSShadow alloc] init];
    titleShadow.shadowOffset = CGSizeMake(0.0f, -1.0f);
    titleShadow.shadowColor = [UIColor blackColor];
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                NSShadowAttributeName: titleShadow};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Showcase"];
    [self.NavItem setTitleView:myLabel];
    self.dict = [[NSDictionary alloc] init];
    PFShowCaseManager *showcaseManager = [[PFShowCaseManager alloc] init];
    showcaseManager.delegate = self;
    [showcaseManager getShowCase];
    //self.navController.navigationBar.translucent = NO;
    [self.view addSubview:self.navController.view];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 12)];
    self.tableView.tableHeaderView = topView;
    self.tableView.tableFooterView = self.footTablewView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_tableView release];
    [_footTablewView release];
    [_waitIndicator release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dict objectForKey:@"length"] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 132;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    */
    PFShowcaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowcaseCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShowcaseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row
                                                                                                       ] objectForKey:@"thumb"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.myImageView loadImageFromURL:url];
    /*
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        UIImage *img = [UIImage imageWithData:responseData];
        cell.youtubeImg.frame = CGRectMake(cell.youtubeImg.frame.origin.x+6,cell.youtubeImg.frame.origin.y+6,144,100);
        cell.youtubeImg.image = img;
        cell.youtubeImg.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        cell.youtubeImg.layer.shadowOffset = CGSizeMake(1, 1);
        cell.youtubeImg.layer.shadowOpacity = 1;
        cell.youtubeImg.layer.shadowRadius = 1;
        cell.youtubeImg.clipsToBounds = NO;
        [cell.myImageView loadImageFromURL:url];

    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [request startAsynchronous];
     */
    
    NSString *viewCount = [[NSString alloc] initWithFormat:@"%@ views",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"view_count"]];
    
    NSString *likeCount = [[NSString alloc] initWithFormat:@"%@",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"like_count"]];
    NSString *commentCount = [[NSString alloc] initWithFormat:@"%@",[[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"comment_count"]];
    cell.desLabel.text = [[[self.dict objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.viewLabel.text = viewCount;
    cell.likeLabel.text = likeCount;
    cell.commentLabel.text = commentCount;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tabbarViewController hideTabBar];
    if (IS_WIDESCREEN) {
        PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController_Wide" bundle:nil];
        youTubeViewController.youtubeId = [[[self.dict objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"youtube_id"];
        youTubeViewController.youtubeObj = [[self.dict objectForKey:@"data"] objectAtIndex:[indexPath row]];
        youTubeViewController.delegate = self;
        [self.navController pushViewController:youTubeViewController animated:YES];
    } else {
        PFYouTubeViewController *youTubeViewController = [[PFYouTubeViewController alloc] initWithNibName:@"PFYouTubeViewController" bundle:nil];
        youTubeViewController.youtubeId = [[[self.dict objectForKey:@"data"] objectAtIndex:[indexPath row]] objectForKey:@"youtube_id"];
        youTubeViewController.youtubeObj = [[self.dict objectForKey:@"data"] objectAtIndex:[indexPath row]];
        youTubeViewController.delegate = self;
        [self.navController pushViewController:youTubeViewController animated:YES];
    }
}
- (void)PFShowCaseManager:(id)sender getShowCaseResponse:(NSDictionary *)response {
    self.dict = response;
    //[showcaseManager getShowCaseId:[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"]];
    self.w.alpha = 0;
    [self.tableView reloadData];

}
- (void)PFShowCaseManager:(id)sender getShowCaseErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
/*
- (void)PFShowCaseManager:(id)sender getShowCaseIdResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
}
- (void)PFShowCaseManager:(id)sender getShowCaseIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
 */

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if ( scrollView.contentOffset.y < 0.0f ) {
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -100.0f ) {
        PFShowCaseManager *showcaseManager = [[PFShowCaseManager alloc] init];
        showcaseManager.delegate = self;
        [showcaseManager getShowCase];
    } 
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ( scrollView.contentOffset.y < -100.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.frame = CGRectMake(0, 50, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}
- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
    self.loadLabel.text = @"";
    self.act.alpha = 0;
}
- (void)PFYouTubeViewControllerBackTapped:(id)sender {
    [self.tabbarViewController showTabBar];
}
@end
