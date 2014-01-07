//
//  PFClassTimeViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFClassDetailViewController.h"
#import "PFClassTimeCell.h"
#import "PFClassManager.h"
@interface PFClassTimeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) NSString *classId;
@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UIView *footTableView;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) NSString *titleBar;
@end
