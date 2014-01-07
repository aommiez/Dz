//
//  PFSignUpViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/24/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFUserManager.h"

@protocol PFSignUpViewControllerDelegate <NSObject>

- (void)PFSignUpViewController:(id)sender signupSuccess:(NSDictionary *)res;

@end


@interface PFSignUpViewController : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *signFormView;
- (IBAction)backTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *usernameTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordConfirmTextField;
@property (retain, nonatomic) IBOutlet UITextField *genderTextField;
@property (retain, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (retain, nonatomic) UIDatePicker *pick;
@property (retain, nonatomic) UIButton *pickDone;
- (IBAction)bgTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *submitButton;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UISegmentedControl *selectGender;
- (IBAction)submitTapped:(id)sender;
- (IBAction)dateBTapped:(id)sender;
@property (assign, nonatomic) id <PFSignUpViewControllerDelegate> delegate;
@end
