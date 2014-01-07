//
//  PFAppDelegate.h
//  DanceZone
//
//  Created by aOmMiez on 8/22/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFIndexViewController.h"
#import "PFTabBarViewController.h"
#import "UIViewController+Swizzled.h"
#import "PFAccountSettingViewController.h"

@class PFIndexViewController;

@protocol PFAppDelegateOvi <NSObject>

@end

@interface PFAppDelegate : UIResponder <UIApplicationDelegate,PFIndexViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PFIndexViewController *viewController;
@property (strong, nonatomic) PFTabBarViewController *tabBarViewController;
@property (assign, nonatomic) id <PFAppDelegateOvi> delegate;
- (void)logout;
@end
