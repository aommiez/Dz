//
//  PFIndexViewController.m-
//  DanceZone
//
//  Created by aOmMiez on 8/22/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFIndexViewController.h"

@interface PFIndexViewController ()

@end

@implementation PFIndexViewController
FBLoginView *fbloginview;
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
    fbloginview = [[FBLoginView alloc]init];
    fbloginview.readPermissions = @[@"email", @"basic_info"];
    fbloginview.frame = CGRectMake(0, 0, 0, 0);
    fbloginview.delegate = self;
    [self.view addSubview:fbloginview];
    [self.scrollView setContentSize: CGSizeMake(self.loginFormView.frame.size.width, self.loginFormView.frame.size.height+1)];
    
    [self.emailButton setBackgroundImage:[UIImage imageNamed:@"EmailLoginBottonIp5.png"]    forState:UIControlStateHighlighted];
    [self.emailButton setBackgroundImage:[UIImage imageNamed:@"EmailLoginBottonIp5.png"]    forState:UIControlStateSelected];
    [self.emailButton setBackgroundImage:[UIImage imageNamed:@"EmailLoginBottonIp5.png"]    forState:UIControlStateNormal];
    [self.scrollView addSubview:self.loginFormView];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 20)];
    self.emailTextField.leftView = paddingView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = paddingView1;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [paddingView release];
    [paddingView1 release];
    /*
    UALogBasic(@"Foobar");
    UALogFull(@"Foobar");
    UALogPlain(@"Foobar");
    UALog(@"This used to be an NSLog()");*/
    [self performSelector:@selector(hideLoading) withObject:self afterDelay:3.0];
}
- (void)hideLoading {
    self.loadingImg.alpha = 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (void)dealloc {
    [_fbButton release];
    [_emailTextField release];
    [_passwordTextField release];
    [_emailButton release];
    [_logInButton release];
    [_signUpButton release];
    [_scrollView release];
    [_loginFormView release];
    [_waitview release];
    [_loadingImg release];
    [_webView release];
    [_viewWeb release];
    [super dealloc];
}
- (void)hideKeyboard {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
- (IBAction)emailTapped:(id)sender {
    self.emailButton.alpha = 0;
    self.logInButton.frame = CGRectMake(93, 354, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
    self.signUpButton.frame = CGRectMake(93, 354, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
    [UIView animateWithDuration:1.0
                          delay:0.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         self.emailTextField.alpha = 1;
                         self.passwordTextField.alpha = 1;
                         self.logInButton.alpha = 1;
                         self.signUpButton.alpha = 1;
                         self.logInButton.frame = CGRectMake(20, 408, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
                         self.signUpButton.frame = CGRectMake(166, 408, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                        
                     }];

}

- (IBAction)viewTapped:(id)sender {
    [self hideKeyboard];
}
- (IBAction)loginTapped:(id)sender {
    [self hideKeyboard];

    PFUserManager *userManager = [[PFUserManager alloc] init];
    userManager.delegate = self;
    [userManager loginWithEmail:self.emailTextField.text Password:self.passwordTextField.text];
    [self.view addSubview:self.waitview];

}

- (IBAction)fbLogin:(id)sender {
    
    [self.view addSubview:self.waitview];
    for (id obj in fbloginview.subviews) {
        if ([obj isKindOfClass:[UIButton class]]){
            [obj sendActionsForControlEvents: UIControlEventTouchUpInside];
            {
            }
        }
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    //[self.delegate PFIndexViewController:self loginSuccess:nil];
    //NSLog(@"loginViewShowingLoggedInUser");
    
}
- (void)loginView:(FBLoginView *)loginView
          handleError:(NSError *)error {
        NSString *alertMessage, *alertTitle;
        if (error.fberrorShouldNotifyUser) {
            // If the SDK has a message for the user, surface it. This conveniently
            // handles cases like password change or iOS6 app slider state.
            alertTitle = @"Facebook Error";
            alertMessage = error.fberrorUserMessage;
        } else if (error.fberrorCategory == FBErrorCategoryAuthenticationReopenSession) {
            // It is important to handle session closures since they can happen
            // outside of the app. You can inspect the error for more context
            // but this sample generically notifies the user.
            alertTitle = @"Session Error";
            alertMessage = @"Your current session is no longer valid. Please log in again.";
        } else {
            // For simplicity, this sample treats other errors blindly.
            alertTitle  = @"Unknown Error";
            alertMessage = @"Error. Please try again later.";
            NSLog(@"Unexpected error:%@", error);
        }
        [self.waitview removeFromSuperview];
        if (alertMessage) {
            [[[UIAlertView alloc] initWithTitle:alertTitle
                                        message:alertMessage
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
        
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    //NSLog(@"%@",user);
    [self.view addSubview:self.waitview];
    //NSLog(@"%@",user);
    if (![self connected]) {
        [[[UIAlertView alloc] initWithTitle:@"Dance Zone"
                                    message:@"No internet connection"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else {
        PFUserManager *userManager = [[PFUserManager alloc] init];
        userManager.delegate = self;
        [userManager loginWithFacebook:[user objectForKey:@"email"] fbid:[user objectForKey:@"id"] firstName:[user objectForKey:@"first_name"] lastName:[user objectForKey:@"last_name"] username:[user objectForKey:@"username"]];
    }
    
    
}
#pragma mark - user manager
- (void)PFUserManager:(id)sender loginWithFacebookResponse:(NSDictionary *)response {
    NSDictionary *user = [[[NSDictionary alloc] initWithDictionary:[response objectForKey:@"user"]] autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user objectForKey:@"username"] forKey:@"username"];
    [defaults setObject:[user objectForKey:@"id"] forKey:@"id"];
    [defaults setObject:[user objectForKey:@"first_name"] forKey:@"first_name"];
    [defaults setObject:[user objectForKey:@"email"] forKey:@"email"];
    [defaults setObject:[response objectForKey:@"token"] forKey:@"token"];
    [defaults synchronize];
    [self.delegate PFIndexViewController:self loginSuccess:response];
    [self.waitview removeFromSuperview];


}
- (void)PFUserManager:(id)sender loginWithFacebookErrorResponse:(NSString *)errorResponse {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                      message:errorResponse
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
    [self.waitview removeFromSuperview];

}
- (void)PFUserManager:(id)sender loginWithEmailResponse:(NSDictionary *)response {
    NSDictionary *user = [[[NSDictionary alloc] initWithDictionary:[response objectForKey:@"user"]] autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user objectForKey:@"id"] forKey:@"id"];
    [defaults setObject:[user objectForKey:@"first_name"] forKey:@"first_name"];
    [defaults setObject:[user objectForKey:@"email"] forKey:@"email"];
    [defaults setObject:[response objectForKey:@"token"] forKey:@"token"];
    [defaults setObject:[user objectForKey:@"username"] forKey:@"username"];
    [defaults synchronize];
    [self.delegate PFIndexViewController:self loginSuccess:response];
    [self.waitview removeFromSuperview];

}
- (void)PFUserManager:(id)sender loginWithEmailErrorResponse:(NSString *)errorResponse {
    //UALogBasic(@"%@",errorResponse);
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                      message:errorResponse
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
    [self.waitview removeFromSuperview];

}
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField { //Keyboard becomes visible
    [self.scrollView setContentOffset:CGPointMake(0, 307 - 170) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}
- (IBAction)signupTapped:(id)sender {
    [self hideKeyboard];
    if (IS_WIDESCREEN) {
        PFSignUpViewController *signupViewController = [[PFSignUpViewController alloc] initWithNibName:@"PFSignUpViewController_Wide" bundle:nil];
        signupViewController.delegate = self;
        [self.view addSubview:signupViewController.view];
    } else {
        PFSignUpViewController *signupViewController = [[PFSignUpViewController alloc] initWithNibName:@"PFSignUpViewController" bundle:nil];
        signupViewController.delegate = self;
        [self.view addSubview:signupViewController.view];
    }
    
}

- (void)PFSignUpViewController:(id)sender signupSuccess:(NSDictionary *)response {
    NSDictionary *user = [[[NSDictionary alloc] initWithDictionary:[response objectForKey:@"user"]] autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[user objectForKey:@"id"] forKey:@"id"];
    [defaults setObject:[user objectForKey:@"first_name"] forKey:@"first_name"];
    [defaults setObject:[user objectForKey:@"email"] forKey:@"email"];
    [defaults setObject:[response objectForKey:@"token"] forKey:@"token"];
    [defaults setObject:[user objectForKey:@"username"] forKey:@"username"];
    [defaults synchronize];
    [self.delegate PFIndexViewController:self loginSuccess:response];
    [self.waitview removeFromSuperview];
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
- (IBAction)webTapped:(id)sender {
    [self.view addSubview:self.waitview];
    NSURL *url = [NSURL URLWithString:@"http://pla2fusion.com"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (IBAction)closeWebTapped:(id)sender {
    [self.viewWeb removeFromSuperview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.waitview removeFromSuperview];
    [self.view addSubview:self.viewWeb];
}

@end
