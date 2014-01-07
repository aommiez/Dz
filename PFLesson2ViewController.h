//
//  PFLesson2ViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFLesson2Cell.h"
#import "PFLessonManager.h"
#import "PFLesson3ViewController.h"
#import "QuartzCore/CALayer.h"
#import "PFLessonRegisterViewController.h"
#import "CXAlertView.h"
@interface PFLesson2ViewController : UIViewController <UITableViewDelegate,UITextFieldDelegate,PFLesson3ViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) NSString *capterId;
@property (retain, nonatomic) NSString *lessonId;
@property (retain, nonatomic) NSDictionary *videoObj;
@property (retain, nonatomic) IBOutlet UIView *w;
@end
