//
//  PFJoinViewController.h
//  DanceZone
//
//  Created by aOmMiez on 10/5/56 BE.
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
@interface PFJoinViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *topMenuView;
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet PFMapView *mapView;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UINavigationController *navController;
@property (retain, nonatomic) IBOutlet UINavigationItem *NavItem;
@property (retain, nonatomic) IBOutlet CustomNavigationBar *customNavBar;
- (IBAction)classTapped:(id)sender;

- (IBAction)calendarTapped:(id)sender;

- (IBAction)activitiesTapped:(id)sender;

- (IBAction)mapTapped:(id)sender;

- (IBAction)callTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)fbTapped:(id)sender;
- (IBAction)twTapped:(id)sender;
- (IBAction)yuTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *currentLocation;
@end
