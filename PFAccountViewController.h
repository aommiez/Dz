//
//  PFAccountViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFAccountSettingViewController.h"
#import "PFUserManager.h"

@protocol PFAccountViewControllerDelegate <NSObject>

- (void)PFAccountViewControllerPhoto:(NSString *)link;

@end


@interface PFAccountViewController : UIViewController
- (IBAction)backTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *ContentView;
@property (retain, nonatomic) IBOutlet UIView *imgUserView;
@property (retain, nonatomic) IBOutlet UIView *fbView;
@property (retain, nonatomic) IBOutlet UIView *emailView;
@property (retain, nonatomic) IBOutlet UIView *phoneView;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UILabel *navTitle;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *facebookLable;
@property (retain, nonatomic) IBOutlet UILabel *emailLabel;
@property (retain, nonatomic) IBOutlet UIImageView *profileImg;
@property (retain, nonatomic) IBOutlet UILabel *phoneLable;
@property (retain, nonatomic) NSString *userId;
@property (assign, nonatomic) id<PFAccountViewControllerDelegate> delegate;


- (IBAction)imgTapped:(id)sender;



@end
