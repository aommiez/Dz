//
//  PFRegisterViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFRegisterViewController.h"

@interface PFRegisterViewController ()

@end

@implementation PFRegisterViewController

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:[self.obj objectForKey:@"name"]];
    [self.navigationItem setTitleView:myLabel];
    
    //self.textview1.text = [self.obj objectForKey:@"description"];
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
    [_imgUserView release];
    [_imgUser release];
    [_registerFormView release];
    [_nameTextField release];
    [_telNumberTextField release];
    [_emailTextField release];
    [_textview1 release];
    [_userLabel release];
    [_scrollView release];
    [_detailView release];
    [super dealloc];
}
- (void)hideKeyBoard {
    [self.emailTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.telNumberTextField resignFirstResponder];
}
- (IBAction)bgTapped:(id)sender {
    [self hideKeyBoard];
}

- (IBAction)registerTapped:(id)sender {
    [self.view addSubview:self.waitView];
    PFClassManager *classManager = [[PFClassManager alloc] init];
    classManager.delegate = self;
    [classManager registerClassId:[self.obj objectForKey:@"class_id"] groupId:[self.obj objectForKey:@"id"] email:self.emailTextField.text phone:self.telNumberTextField.text name:self.nameTextField.text];
}
- (void)PFClassManager:(id)sender registerClassIdResponse:(NSDictionary *)response {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Dance Zone!"
                                                      message:@"ลงทะเบียนเสร็จเรียบร้อยแล้ว ทางทีมงานจะติดต่อกลับไปภายใน 24 ชม."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
    [self.waitView removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)PFClassManager:(id)sender registerClassIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    [self.waitView removeFromSuperview];
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
@end
