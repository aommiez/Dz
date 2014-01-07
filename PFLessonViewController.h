//
//  PFLessonViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFLessonCell.h"
#import "PFLesson1ViewController.h"
#import "CustomNavigationBar.h"
#import "PFLessonManager.h"
#import "AMBlurView.h"
#import "PFUserManager.h"
@interface PFLessonViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UINavigationController *navController;
@property (retain, nonatomic) IBOutlet UINavigationItem *NavItem;
@property (retain, nonatomic) IBOutlet CustomNavigationBar *customNavBar;
@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UIView *topNav;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) IBOutlet UILabel *loadLabel;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act;

@end
