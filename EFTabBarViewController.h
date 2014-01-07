//
//  EFTabBarViewController.h
//  Capsules
//
//  Created by Soemsak on 12/6/12.
//  Copyright (c) 2012 Soemsak Loetphornphisit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBadge.h"
#import "EFTabBarItemButton.h"
#import "AMBlurView.h"
@protocol EFTabBarViewControllerDelegate <NSObject>
@optional
- (void)EFTabBarViewController:(id)sender selectedIndex:(int)index;
@end

@interface EFTabBarViewController : UIViewController
@property (retain, nonatomic) AMBlurView *mainView;
@property (retain, nonatomic) AMBlurView *tabBarView;
@property (retain, nonatomic) UIImageView *tabBarBackgroundImageView;

@property (retain, nonatomic) IBOutlet UILabel *mesg0Label;
@property (retain, nonatomic) IBOutlet UILabel *mesg1Label;
@property (retain, nonatomic) IBOutlet UILabel *mesg2Label;

@property (assign, nonatomic) id <EFTabBarViewControllerDelegate> delegate;


@property (readonly, nonatomic) NSMutableArray *itemButtons;
@property (readonly, nonatomic) NSMutableArray *viewControllers;

@property (nonatomic, retain) UIView* notificationView;

@property (nonatomic) int selectedIndex;
@property (readonly, nonatomic) int shownNotificationIndex;

- (id)initWithBackgroundImage:(UIImage*)image viewControllers:(id)firstObj, ... ;

- (void)hideTabBarWithAnimation:(BOOL)isAnimated;
- (void)showTabBarWithAnimation:(BOOL)isAnimated;

- (void)setNotificationViewForIndex:(NSUInteger)tabIndex mesg0:(NSString*)mesg0 mesg1:(NSString*)mesg1 mesg2:(NSString*)mesg2;
- (void)hideNotificationView;

@end
