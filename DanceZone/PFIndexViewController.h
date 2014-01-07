//
//  PFIndexViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/22/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PFSignUpViewController.h"
#import "PFTabBarViewController.h"
#import "UALogger.h"
#import "PFUserManager.h"
#import "Reachability.h"
@protocol PFIndexViewControllerDelegate <NSObject>

- (void)PFIndexViewController:(id)sender loginSuccess:(NSDictionary *)res;

@end

@interface PFIndexViewController : UIViewController <UITextFieldDelegate,PFSignUpViewControllerDelegate,UIWebViewDelegate>
@property (assign, nonatomic) id <PFIndexViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (retain, nonatomic) IBOutlet UIButton *fbButton;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UIButton *emailButton;
@property (retain, nonatomic) IBOutlet UIButton *logInButton;
@property (retain, nonatomic) IBOutlet UIButton *signUpButton;
- (IBAction)emailTapped:(id)sender;
- (IBAction)viewTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *loginFormView;
- (IBAction)signupTapped:(id)sender;
- (IBAction)loginTapped:(id)sender;
- (IBAction)fbLogin:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *waitview;

@property (retain, nonatomic) IBOutlet UIImageView *loadingImg;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIView *viewWeb;
- (IBAction)webTapped:(id)sender;
- (IBAction)closeWebTapped:(id)sender;

@end
