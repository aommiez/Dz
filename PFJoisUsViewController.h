//
//  PFJoisUsViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFMapView.h"
#import "PFActivitiesViewController.h"
#import "PFClassViewController.h"
#import "PFCalendarViewController.h"
#import <MessageUI/MessageUI.h> 
#import "PFAboutWebViewController.h"
#import "CustomNavigationBar.h"
#import "AMBlurView.h"
#import "CMMapLauncher.h"
#import <CoreLocation/CoreLocation.h>
#import "PFMapViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "AsyncImageView.h"
#import "PFCalenViewController.h"
@class PFTabBarViewController;
@interface PFJoisUsViewController : UIViewController <MFMailComposeViewControllerDelegate,CLLocationManagerDelegate,PFActivitiesViewControllerDelegate,UINavigationControllerDelegate,PFCalendarViewControllerDelegate,PFClassViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *topMenuView;
@property (retain, nonatomic) PFTabBarViewController *tabbarViewController;
@property (retain, nonatomic) IBOutlet PFMapView *mapView;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UINavigationController *navController;
@property (retain, nonatomic) IBOutlet UINavigationItem *NavItem;
@property (retain, nonatomic) IBOutlet CustomNavigationBar *customNavBar;
- (IBAction)classTapped:(id)sender;

- (IBAction)calendarTapped:(id)sender;

- (IBAction)activitiesTapped:(id)sender;

- (IBAction)mapTapped:(id)sender;
- (IBAction)webTapped:(id)sender;
- (IBAction)callTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)fbTapped:(id)sender;
- (IBAction)twTapped:(id)sender;
- (IBAction)yuTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *currentLocation;
@property (retain, nonatomic) NSDictionary *obj;
@property (retain, nonatomic) IBOutlet UIView *topNav;
@property (retain, nonatomic) IBOutlet UIButton *phoneButton;
@property (retain, nonatomic) IBOutlet UIButton *websiteButton;
@property (retain, nonatomic) IBOutlet UIButton *emailButton;
@property (retain, nonatomic) IBOutlet UIButton *lineButton;
@property (retain, nonatomic) IBOutlet UIButton *facebookButton;
@property (retain, nonatomic) IBOutlet UIButton *twitterButton;
@property (retain, nonatomic) IBOutlet UIButton *youtubeButton;
@property (retain, nonatomic) IBOutlet UIImageView *headImg;
@property (retain, nonatomic) IBOutlet UIView *w;

@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet UIView *subDetail;

- (IBAction)platwoTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *actBut;
@property (retain, nonatomic) IBOutlet UIButton *classBut;
@property (retain, nonatomic) IBOutlet UIButton *calenBut;


@end
