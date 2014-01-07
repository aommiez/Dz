//
//  PFLesson1ViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFLesson2ViewController.h"
#import "PFLessonManager.h"
#import "PFLessonChapterCell.h"
#import "AMBlurView.h"
#import "PFLesson2ViewController.h"
@interface PFLesson1ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) NSString *lessonId;
@property (retain, nonatomic) NSString *lessonName;
@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSString *colorString;
@property (retain, nonatomic) IBOutlet UIView *w;
@end
