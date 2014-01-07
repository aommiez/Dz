//
//  PFUpdateViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFUpdateCell.h"
#import "PFAccountViewController.h"
#import "CustomNavigationBar.h"
#import "PFUpdateDetailViewController.h"
#import "PFNewsManager.h"
#import "SBJSON.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PFAccountSettingViewController.h"
#import <Social/Social.h>
#import "PFNewsCommentViewController.h"
#import "AMBlurView.h"
#import "PFNotificationViewController.h"
#import "PFDzApi.h"
#import "PFYouTubeViewController.h"
#import "PFActivitiesDetailViewController.h"

@class PFTabBarViewController;
@interface PFUpdateViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,PFAccountSettingViewControllerDelegate,PFUpdateDetailViewControllerDelegate,PFNewsCommentViewControllerDelegate,UINavigationControllerDelegate,PFNotificationViewControllerDelegate,UIScrollViewDelegate,PFYouTubeViewControllerDelegate,PFActivitiesDetailViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UINavigationController *navController;
@property (retain, nonatomic) IBOutlet UINavigationItem *NavItem;
@property (retain, nonatomic) IBOutlet CustomNavigationBar *customNavBar;
@property (retain, nonatomic) PFTabBarViewController *tabbarViewController;
@property (retain, nonatomic) UIImage *imgView;

@property (retain, nonatomic) IBOutlet UIView *topNav;

@property (retain, nonatomic) NSString *paging;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) IBOutlet UILabel *loadLabel;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (retain, nonatomic) NSString *linkImg;
@property (retain, nonatomic) NSMutableArray *arrObj;
@end
