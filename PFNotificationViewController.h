//
//  PFNotificationViewController.h
//  DanceZone
//
//  Created by aOmMiez on 10/4/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNotificationCell.h"
#import "PFUserManager.h"
#import "PFYouTubeViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "PFUpdateDetailViewController.h"
#import "PFLesson1ViewController.h"
#import "PFActivitiesDetailViewController.h"
#import "AMBlurView.h"
#import "PFDzApi.h"
@protocol PFNotificationViewControllerDelegate <NSObject>
- (void)PFNotificationViewControllerNewsTapped:(id)sender newsId:(NSString *)newsId;
@end


@interface PFNotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (assign, nonatomic) id<PFNotificationViewControllerDelegate> delegate;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSDictionary *obj;
@property (retain, nonatomic) IBOutlet AMBlurView *blurView;
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) NSString *nString;
@property (retain, nonatomic) NSString *type;
- (void)PFNotificationViewController:(id)sender obj:(NSDictionary *)obj;
@end
