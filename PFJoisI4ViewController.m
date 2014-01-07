//
//  PFJoisI4ViewController.m
//  DanceZone
//
//  Created by aOmMiez on 10/16/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFJoisI4ViewController.h"

@interface PFJoisI4ViewController ()

@end

@implementation PFJoisI4ViewController

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
    // Do any additional setup after loading the view from its nib.
    //AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navController.navigationBar.frame), 64)];
    //[backgroundView setBlurTintColor:[UIColor colorWithRed:255/255.0 green:168/255.0 blue:0/255.0 alpha:1]];
    self.tableView.frame = CGRectMake(0, 64, 320, self.tableView.bounds.size.height);
    //[self.navController.view insertSubview:backgroundView belowSubview:self.navController.navigationBar];

    [self.view addSubview:self.navController.view];
    [self.view addSubview:self.topNav];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Join Us"];
    [self.NavItem setTitleView:myLabel];
    
    self.tableView.tableHeaderView = self.detailView;
    //[self.view addSubview:self.detailView];
    CLLocationCoordinate2D location;
	location.latitude = (double) 18.7965137;
	location.longitude = (double) 98.9760178;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    [self.mapView addAnnotation:point];
    [self.mapView setCenterCoordinate:location zoomLevel:13 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)classTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFClassViewController *classViewController = [[PFClassViewController alloc] initWithNibName:@"PFClassViewController_Wide" bundle:nil];
        [self.navController pushViewController:classViewController animated:YES];
    } else {
        PFClassViewController *classViewController = [[PFClassViewController alloc] initWithNibName:@"PFClassViewController" bundle:nil];
        [self.navController pushViewController:classViewController animated:YES];
    }
}


- (IBAction)calendarTapped:(id)sender {
    PFCalendarViewController *calendarViewController = [[PFCalendarViewController alloc] initWithSunday:YES timeZone:[NSTimeZone timeZoneWithName:@"Asia/Bangkok"]];
    [self.navController pushViewController:calendarViewController animated:YES];
}

- (IBAction)activitiesTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFActivitiesViewController *activitiesViewController = [[PFActivitiesViewController alloc] initWithNibName:@"PFActivitiesViewController_Wide" bundle:nil];
        [self.navController pushViewController:activitiesViewController animated:YES];
    } else {
        PFActivitiesViewController *activitiesViewController = [[PFActivitiesViewController alloc] initWithNibName:@"PFActivitiesViewController" bundle:nil];
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0897014082"]];
}

- (IBAction)emailTapped:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Dance Zone Test Email";
    // Email Content
    NSString *messageBody = @"Dance Zone is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"dancezone@windowslive.com"];
    
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
        aboutWebViewController.webUrl = @"https://www.facebook.com/dancezone";
        aboutWebViewController.navTitleText = @"Facebook";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = @"https://www.facebook.com/dancezone";
        aboutWebViewController.navTitleText = @"Facebook";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}

- (IBAction)twTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = @"https://twitter.com/dancewithdz";
        aboutWebViewController.navTitleText = @"Twitter";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = @"https://twitter.com/dancewithdz";
        aboutWebViewController.navTitleText = @"Twitter";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    }
}

- (IBAction)yuTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController_Wide" bundle:nil];
        aboutWebViewController.webUrl = @"http://www.youtube.com/dzcm";
        aboutWebViewController.navTitleText = @"Youtube";
        [self.navController pushViewController:aboutWebViewController animated:YES];
    } else {
        PFAboutWebViewController *aboutWebViewController = [[PFAboutWebViewController alloc] initWithNibName:@"PFAboutWebViewController" bundle:nil];
        aboutWebViewController.webUrl = @"http://www.youtube.com/dzcm";
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

- (void)dealloc {
    [_topNav release];
    [super dealloc];
}
@end
