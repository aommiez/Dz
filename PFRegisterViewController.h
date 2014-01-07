//
//  PFRegisterViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "PFClassManager.h"
@interface PFRegisterViewController : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIView *imgUserView;
@property (retain, nonatomic) IBOutlet UIImageView *imgUser;
@property (retain, nonatomic) IBOutlet UIView *registerFormView;
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *telNumberTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) NSDictionary *obj;

@property (retain, nonatomic) IBOutlet UITextView *textview1;

@property (retain, nonatomic) IBOutlet UILabel *userLabel;

- (IBAction)bgTapped:(id)sender;
- (IBAction)registerTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIControl *detailView;
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *w;
@end
