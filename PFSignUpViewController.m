//
//  PFSignUpViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/24/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFSignUpViewController.h"

@interface PFSignUpViewController ()

@end

@implementation PFSignUpViewController
NSString *gender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navBg setBackgroundColor:NAV_RGB];
	gender = nil;
    self.pick = [[UIDatePicker alloc] init];
    self.pickDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.pickDone setFrame:CGRectMake(50, 370, 200, 44)];
    self.pickDone.alpha = 0;
    [self.pick setFrame:CGRectMake(0,200,320,120)];
    self.pick.alpha = 0;
    
    UIView *usernameView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.usernameTextField.leftView = usernameView;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.passwordTextField.leftView = passwordView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView *passwordConfirmView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.passwordConfirmTextField.leftView = passwordConfirmView;
    self.passwordConfirmTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.emailTextField.leftView = emailView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView *genderView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.genderTextField.leftView = genderView;
    self.genderTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView *dateOfBirthView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.dateOfBirthTextField.leftView = dateOfBirthView;
    self.dateOfBirthTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.scrollView setContentSize:CGSizeMake(self.signFormView.frame.size.width, self.signFormView.frame.size.height+1)];
    [self.scrollView addSubview:self.signFormView];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordConfirmTextField.delegate = self;
    self.genderTextField.delegate = self;
    self.dateOfBirthTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [_signFormView release];
    [_usernameTextField release];
    [_emailTextField release];
    [_passwordTextField release];
    [_passwordConfirmTextField release];
    [_genderTextField release];
    [_dateOfBirthTextField release];
    [_submitButton release];
    [_selectGender release];
    [_navBg release];
    [super dealloc];
}
- (IBAction)backTapped:(id)sender {
    [self hideKeyboard];
    [self.view removeFromSuperview];
}

- (void)hideKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordConfirmTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.genderTextField resignFirstResponder];
    [self.dateOfBirthTextField resignFirstResponder];
}
- (void)fadeTextField {
    self.usernameTextField.alpha = 0;
    self.emailTextField.alpha = 0;
    self.passwordConfirmTextField.alpha = 0;
    self.passwordTextField.alpha = 0;
    self.genderTextField.alpha = 0;
    self.dateOfBirthTextField.alpha = 0;
    self.submitButton.alpha = 0;
}
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ( textField == self.dateOfBirthTextField ) {
        //[self.scrollView setContentOffset:CGPointMake(0, 307 - 170) animated:YES];
        [textField resignFirstResponder];
        
        
        
    }
    
}


-(void)dateBirthButtonClicked {
    [UIView animateWithDuration:0.3
                          delay:0.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         [self.scrollView setAlpha:1];
                         NSString *dateString = [NSDateFormatter localizedStringFromDate:self.pick.date
                                                                               dateStyle:NSDateFormatterShortStyle
                                                                               timeStyle:NSDateFormatterNoStyle];
                         [self.dateOfBirthTextField setText:dateString];
                         self.pick.alpha = 0;
                         self.pickDone.alpha = 0;
                         [self.pickDone removeFromSuperview];
                         [self.pick removeFromSuperview];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    [self hideKeyboard];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}
- (IBAction)bgTapped:(id)sender {
    [self hideKeyboard];
}

- (IBAction)submitTapped:(id)sender {
    if (self.selectGender.selectedSegmentIndex == 0) {
        gender = @"Male";
    } else {
        gender = @"Female";
    }
    if ( [self.usernameTextField.text isEqualToString:@""]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                          message:@"Username Incorrect"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        return;
    } else if ( [self.emailTextField.text isEqualToString:@""]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                          message:@"Email Incorrect"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        return;
    } else if ( ![self validateEmail:[self.emailTextField text]] ) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                          message:@"Enter a valid email address"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        return;
    } else if ( [self.passwordTextField.text isEqualToString:@""]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                          message:@"Password Incorrect"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        return;
    } else if (![self.passwordTextField.text isEqualToString:self.passwordConfirmTextField.text]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                          message:@"And password do not match."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        return;
    }  else if ( [self.dateOfBirthTextField.text isEqualToString:@""]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                          message:@"Birth of Date Incorrect"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        return;
    } else {
        NSLog(@"%@ %@ %@ %@ ",self.usernameTextField.text,self.emailTextField.text,self.passwordTextField.text,self.dateOfBirthTextField.text);
        PFUserManager *userManager = [[PFUserManager alloc] init];
        userManager.delegate = self;
        [userManager signupWithUsername:self.usernameTextField.text email:self.emailTextField.text password:self.passwordTextField.text gender:gender dateOfBirth:self.dateOfBirthTextField.text];
    }
}

- (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}
#pragma mark - user manager delegate
- (void)PFUserManager:(id)sender signupWithUsernameResponse:(NSDictionary *)response {
    [self.delegate PFSignUpViewController:self signupSuccess:response];
    [self.view removeFromSuperview];
}
- (void)PFUserManager:(id)sender signupWithUsernameErrorResponse:(NSString *)errorResponse {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                      message:errorResponse
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
}
- (IBAction)dateBTapped:(id)sender {
    [self hideKeyboard];
    [UIView animateWithDuration:0.3
                          delay:0.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         [self.pickDone setFrame:CGRectMake(50, 370, 200, 44)];
                         [self.pickDone setTintColor:[UIColor whiteColor]];
                         [self.pickDone setTitle:@"Ok !" forState:UIControlStateNormal];
                         [self.pickDone addTarget:self action:@selector(dateBirthButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                         self.pickDone.alpha = 1;
                         [self.view addSubview:self.pickDone];
                         self.pick.alpha = 1;
                         [self.pick setFrame:CGRectMake(0,200,320,120)];
                         self.pick.backgroundColor = [UIColor whiteColor];
                         self.pick.hidden = NO;
                         self.pick.datePickerMode = UIDatePickerModeDate;
                         self.pick.tintColor = [UIColor whiteColor];
                         [self.view addSubview:self.pick];
                         [self.scrollView setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
@end
