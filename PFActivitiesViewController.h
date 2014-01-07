//
//  PFActivitiesViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFActivitiesCell.h"
#import "CustomNavigationBar.h"
#import "PFActivitiesDetailViewController.h"
#import "PFActivitiesManager.h"
#import "AMBlurView.h"


@protocol PFActivitiesViewControllerDelegate <NSObject>

- (void)PFActivitiesViewControllerPhoto:(NSString *)link;
- (void)PFActivitiesViewControllerBack;
@end

@interface PFActivitiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,PFActivitiesDetailViewControllerDelegate>
@property (assign, nonatomic) id<PFActivitiesViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) NSDictionary *obj;
@property (retain, nonatomic) IBOutlet UIButton *mButton;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) IBOutlet UILabel *loadLabel;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act;
@end
