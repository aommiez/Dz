//
//  PFTabBarViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFTabBarViewController.h"
#import "PFUpdateViewController.h"
#import "PFShowCaseViewController.h"
#import "PFLessonViewController.h"
#import "PFJoisUsViewController.h"
#import "AMBlurView.h"

#import "PFNotificationViewController.h"
#import "MWPhotoBrowser.h"

@interface PFTabBarViewController : UIViewController<MWPhotoBrowserDelegate>
@property (retain, nonatomic) IBOutlet EFTabBarViewController *tabBarViewController;
@property (retain, nonatomic) IBOutlet PFUpdateViewController *pfUpdateViewController;
@property (retain, nonatomic) IBOutlet PFShowCaseViewController *pfShowCaseViewController;
@property (retain, nonatomic) IBOutlet PFLessonViewController *pfLessonViewController;
@property (retain, nonatomic) IBOutlet PFJoisUsViewController *pfJoisUsViewController;

- (void)hideTabBar;
- (void)showTabBar;
- (IBAction)tapped:(id)sender;
@property (nonatomic, strong) NSMutableArray *photos;
- (void)showPhoto:(NSString *)link;
@end
