//
//  PFShowCaseViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFShowcaseCell.h"
#import "PFYouTubeViewController.h"
#import "CustomNavigationBar.h"
#import "PFShowCaseManager.h"
#import "AMBlurView.h"

@class PFTabBarViewController;

@interface PFShowCaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,PFYouTubeViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UINavigationController *navController;
@property (retain, nonatomic) IBOutlet UINavigationItem *NavItem;
@property (retain, nonatomic) IBOutlet CustomNavigationBar *customNavBar;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UIView *footTablewView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *waitIndicator;
@property (retain, nonatomic) IBOutlet UIView *topNav;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) IBOutlet UILabel *loadLabel;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (retain, nonatomic) PFTabBarViewController *tabbarViewController;
@end
