//
//  PFClassViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"
#import "PFClassTimeViewController.h"
#import "PFClassManager.h"
#import "AsyncImageView.h"
#import "PFClassCell.h"

@protocol PFClassViewControllerDelegate <NSObject>

- (void)PFClassViewControllerBack;

@end

@interface PFClassViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) NSArray *tableData;
@property (assign, nonatomic) id<PFClassViewControllerDelegate> delegate;
@property (retain, nonatomic) NSDictionary *dict;
@end
