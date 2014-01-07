//
//  PFJoisUsViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFJoisUsViewController.h"
#import "PFTabBarViewController.h"
@interface PFJoisUsViewController ()

@end

@implementation PFJoisUsViewController
int hf;
NSString *urlImg;
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
    self.subDetail.alpha = 0;
    self.tableView.frame = CGRectMake(0, 64, 320, self.tableView.bounds.size.height);
    [self.view addSubview:self.navController.view];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Join Us"];
    [self.NavItem setTitleView:myLabel];
    
    //[self.view addSubview:self.detailView];
    self.navController.delegate = self;
    CLLocationCoordinate2D location;
	location.latitude = (double) 18.7965137;
	location.longitude = (double) 98.9760178;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    [self.mapView addAnnotation:point];
    [self.mapView setCenterCoordinate:location zoomLevel:13 animated:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:@selector(reloadView) userInfo:nil repeats:YES];
    [self reloadView];

    
}

- (void)reloadView {
    NSString *urlStr = [[NSString alloc] initWithString:@"http://61.19.147.72/api/setting"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    __block ASIHTTPRequest *requestComment = [ASIHTTPRequest requestWithURL:url];
    [requestComment setCompletionBlock:^{
        
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[requestComment responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        //NSLog(@"%@",dict);
        self.obj = dict;
        [self.phoneButton setTitle:[self.obj objectForKey:@"phone"] forState:UIControlStateNormal];
        [self.websiteButton setTitle:[self.obj objectForKey:@"website"] forState:UIControlStateNormal];
        [self.lineButton setTitle:[self.obj objectForKey:@"line"] forState:UIControlStateNormal];
        [self.emailButton setTitle:[self.obj objectForKey:@"email"] forState:UIControlStateNormal];
        [self.twitterButton setTitle:[self.obj objectForKey:@"twitter"] forState:UIControlStateNormal];
        [self.youtubeButton setTitle:[self.obj objectForKey:@"youtube"] forState:UIControlStateNormal];
        
        NSString *urlStrz = [[NSString alloc] init];
        if (IS_WIDESCREEN) {
            urlStrz = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=600",API_URL,[[self.obj objectForKey:@"picture"] objectForKey:@"id"]] autorelease];
        } else {
            urlStrz = [[[NSString alloc] initWithFormat:@"%@pic/%@?display=custom&size_x=300",API_URL,[[self.obj objectForKey:@"picture"] objectForKey:@"id"]] autorelease];
        }
        
        
        urlImg = urlStrz;
        NSURL *urlz = [NSURL URLWithString:urlStrz];
        
        
        __block ASIHTTPRequest *requestz = [ASIHTTPRequest requestWithURL:urlz];
        [requestz setCompletionBlock:^{
            
            // Use when fetching binary data
            NSData *responseData = [requestz responseData];
            UIImage *img = [UIImage imageWithData:responseData];
            
            if (IS_WIDESCREEN) {
                self.headImg.frame = CGRectMake(self.headImg.frame.origin.x, self.headImg.frame.origin.y, img.size.width/2, img.size.height/2);
                self.headImg.image = img;
                self.detailView.frame = CGRectMake(self.detailView.frame.origin.x, self.detailView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height+img.size.height/2);
            } else {
                self.headImg.frame = CGRectMake(self.headImg.frame.origin.x, self.headImg.frame.origin.y, 300, img.size.height);
                self.headImg.image = img;
                self.detailView.frame = CGRectMake(self.detailView.frame.origin.x, self.detailView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height+img.size.height);
            }
            
            
    
            self.subDetail.frame = CGRectMake(0, self.headImg.frame.size.height+70, 320, self.subDetail.frame.size.height);
            
            [self.tableView setContentSize:CGSizeMake(self.detailView.frame.size.width,self.subDetail.frame.size.height+self.headImg.frame.size.height+100)];
            
            self.subDetail.alpha = 1;
            self.w.alpha = 0;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
            [self.headImg addGestureRecognizer:singleTap];
            [self.headImg setMultipleTouchEnabled:YES];
            [self.headImg setUserInteractionEnabled:YES];
            
            self.tableView.tableHeaderView = self.detailView;
        }];
        [requestz setFailedBlock:^{
            //NSError *error = [request error];
        }];
        [requestz startSynchronous];
        
        
    }];
    [requestComment setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [requestComment startAsynchronous];
    
}
- (void)tapOnce:(UIGestureRecognizer *)gesture {
     NSString *urlStrz = [[[NSString alloc] initWithFormat:@"%@pic/%@",API_URL,[[self.obj objectForKey:@"picture"] objectForKey:@"id"]] autorelease];
    [self.tabbarViewController showPhoto:urlStrz];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [_topMenuView release];
    [_detailView release];
    [_mapView release];
    [_navBg release];
    [_tableView release];
    [_topNav release];
    [_phoneButton release];
    [_websiteButton release];
    [_emailButton release];
    [_lineButton release];
    [_facebookButton release];
    [_twitterButton release];
    [_youtubeButton release];
    [_headImg release];
    [_detailView release];
    [_subDetail release];

    [_actBut release];
    [_classBut release];
    [_calenBut release];
    [super dealloc];
}

- (IBAction)classTapped:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.classBut.highlighted = YES;
    }];
    if (IS_WIDESCREEN) {
        PFClassViewController *classViewController = [[PFClassViewController alloc] initWithNibName:@"PFClassViewController_Wide" bundle:nil];
        classViewController.delegate = self;
        [self.navController pushViewController:classViewController animated:YES];
    } else {
        PFClassViewController *classViewController = [[PFClassViewController alloc] initWithNibName:@"PFClassViewController" bundle:nil];
        classViewController.delegate = self;
        [self.navController pushViewController:classViewController animated:YES];
    }
}


- (IBAction)calendarTapped:(id)sender {
    self.w.frame = CGRectMake(115, 200, self.w.frame.size.width, self.w.frame.size.height);
    self.w.alpha = 1 ;
    [self.detailView addSubview:self.w];
    [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    [self performSelector:@selector(loadCar) withObject:sender afterDelay:1];
    //PFCalenViewController *cv = [[PFCalenViewController alloc] init];
    //[self.navController pushViewController:cv animated:YES];
}
- (void)doHighlight:(UIButton*)b {
    [b setHighlighted:YES];
}
- (void)loadCar {
    PFCalendarViewController *calendarViewController = [[PFCalendarViewController alloc] initWithSunday:YES timeZone:[NSTimeZone timeZoneWithName:@"Asia/Bangkok"]];
    calendarViewController.delegate = self;
    [self.tabbarViewController hideTabBar];
    [self.navController pushViewController:calendarViewController animated:YES];
}
- (IBAction)activitiesTapped:(id)sender {
    [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    //[self.actBut setBackgroundImage:[UIImage imageNamed:@"PhoneIconIp5.png"] forState:UIControlStateNormal];
    //[sender setImage:[UIImage imageNamed:@"PhoneIconIp5.png"] forState:UIControlStateNormal];
    [self.tabbarViewController hideTabBar];
    
    if (IS_WIDESCREEN) {
        PFActivitiesViewController *activitiesViewController = [[PFActivitiesViewController alloc] initWithNibName:@"PFActivitiesViewController_Wide" bundle:nil];
        activitiesViewController.delegate = self;
        [self.navController pushViewController:activitiesViewController animated:YES];
    } else {
        PFActivitiesViewController *activitiesViewController = [[PFActivitiesViewController alloc] initWithNibName:@"PFActivitiesViewController" bundle:nil];
        activitiesViewController.delegate = self;
        [self.navController pushViewController:activitiesViewController animated:YES];
    }
}

- (IBAction)mapTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFMapViewController *activitiesViewController = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController_Wide" bundle:nil];

        [self.navController pushViewController:activitiesViewController animated:YES];
    } else {
        PFMapViewController *activitiesViewController = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController" bundle:nil];
     
        [self.navController pushViewController:activitiesViewController animated:YES];
    }
    //self.locationManager = [[CLLocationManager alloc] init];
    //self.locationManager.delegate = self;
    //self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    //self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    //[self.locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentLocation = newLocation;
    CLLocationCoordinate2D location;
	location.latitude = (double) 18.7965137;
	location.longitude = (double) 98.9760178;
    [CMMapLauncher launchMapApp:CMMapAppAppleMaps
              forDirectionsFrom:[CMMapPoint mapPointWithName:@"Origin"
                                                  coordinate:newLocation.coordinate]
                             to:[CMMapPoint mapPointWithName:@"Destination"
                                                  coordinate:location]];
}

- (IBAction)callTapped:(id)sender {
    NSString *phone = [[[NSString alloc] initWithFormat:@"telprompt://%@",[self.obj objectForKey:@"phone"]] autorelease];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

- (IBAction)emailTapped:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Dance Zone Email";
    // Email Content
    NSString *messageBody = @"Dance Zone is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:[self.obj objectForKey:@"email"]];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (IBAction)fbTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"facebook"];
        aboutWebViewController.navTitleText = @"Facebook";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"facebook"];
        aboutWebViewController.navTitleText = @"Facebook";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}

- (IBAction)twTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"twitter"];
        aboutWebViewController.navTitleText = @"Twitter";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"twitter"];
        aboutWebViewController.navTitleText = @"Twitter";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}

- (IBAction)yuTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"youtube"];
        aboutWebViewController.navTitleText = @"Youtube";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"youtube"];
        aboutWebViewController.navTitleText = @"Youtube";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)webTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"website"];
        aboutWebViewController.navTitleText = @"Dz Web Site";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = [self.obj objectForKey:@"website"];
        aboutWebViewController.navTitleText = @"Dz Web Site";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}
- (void)PFActivitiesViewControllerPhoto:(NSString *)link {
    [self.tabbarViewController showPhoto:link];
}
- (void)PFActivitiesViewControllerBack {
    self.actBut.highlighted = NO;
    [self.tabbarViewController showTabBar];
}
- (void)PFCalendarViewControllerBack {
    self.w.alpha = 0;
    [self.w removeFromSuperview];
    self.calenBut.highlighted = NO;
    [self.tabbarViewController showTabBar];
}
- (void)PFClassViewControllerBack {
    self.classBut.highlighted = NO;
}
- (IBAction)platwoTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = @"http://www.pla2fusion.com";
        aboutWebViewController.navTitleText = @"Pla2 Web Site";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = @"http://www.pla2fusion.com";
        aboutWebViewController.navTitleText = @"Pla2 Web Site";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}
@end
