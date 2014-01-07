//
//  PFLessonRegisterViewController.m
//  DanceZone
//
//  Created by aOmMiez on 10/16/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLessonRegisterViewController.h"
#import "CXAlertView.h"
@interface PFLessonRegisterViewController ()

@end

@implementation PFLessonRegisterViewController

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
    self.w.layer.cornerRadius = 5;
    self.w.layer.masksToBounds = YES;
    self.emailTextField.delegate = self;
    self.telNumberTextField.delegate = self;
    self.nameTextField.delegate = self;
    [self.imgUserView.layer setCornerRadius:4.0f];
    [self.registerFormView.layer setCornerRadius:4.0f];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@auth",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        self.nameTextField.text = [dict objectForKey:@"username"];
        self.emailTextField.text = [dict objectForKey:@"email_show"];
        self.telNumberTextField.text = [dict objectForKey:@"phone_show"];
        self.userLabel.text = [dict objectForKey:@"username"];
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [request startAsynchronous];
    
    NSString *urlPicStr = [[[NSString alloc] initWithFormat:@"%@user/%@/picture",API_URL,[defaults objectForKey:@"id"]]autorelease];
    NSURL *urlPic = [NSURL URLWithString:urlPicStr];
    __block ASIHTTPRequest *requestPic = [ASIHTTPRequest requestWithURL:urlPic];
    [requestPic setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [requestPic responseData];
        self.imgUser.image = [UIImage imageWithData:responseData];
    }];
    [requestPic setFailedBlock:^{
        //NSError *error = [request error];
        
    }];
    [requestPic startAsynchronous];
    self.scrollView.contentSize = CGSizeMake(320, self.detailView.frame.size.height);
    [self.scrollView addSubview:self.detailView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_detailView release];
    [_scrollView release];
    [_submitBut release];
    [_waitView release];
    [super dealloc];
}
- (IBAction)bgTapped:(id)sender {
    [self.telNumberTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
}

- (IBAction)submitTapped:(id)sender {
    [self.view addSubview:self.waitView];
    PFLessonManager *lessonManager = [[PFLessonManager alloc] init];
    lessonManager.delegate = self;
    [lessonManager registerLesson:self.emailTextField.text phone:self.telNumberTextField.text name:self.nameTextField.text];
}
#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ( textField == self.emailTextField ) {
        [self.scrollView setContentOffset:CGPointMake(0, 307 - 170) animated:YES];
        //[textField resignFirstResponder];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)PFLessonManager:(id)sender registerLessonResponse:(NSDictionary *)response {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                      message:@"ส่งข้อมูลเสร็จเรียบร้อยแล้ว ทางทีมงานจะติดต่อกลับไปภายใน 24 ชม."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
    [self.submitBut setTitle:@"Submitted" forState:UIControlStateNormal];
    [self.waitView removeFromSuperview];
}
- (void)PFLessonManager:(id)sender registerLessonErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    [self.waitView removeFromSuperview];
}
@end
