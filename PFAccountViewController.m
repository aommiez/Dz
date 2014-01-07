//
//  PFAccountViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"

@interface PFAccountViewController ()

@end

@implementation PFAccountViewController

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
    [self.ContentView.layer setCornerRadius:4.0f];
    [self.imgUserView.layer setCornerRadius:4.0f];
    [self.fbView.layer setCornerRadius:4.0f];
    [self.emailView.layer setCornerRadius:4.0f];
    [self.phoneView.layer setCornerRadius:4.0f];
    [self getProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getProfile{

    
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@/picture",API_URL,self.userId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        self.profileImg.image = [UIImage imageWithData:responseData];
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
        
    }];
    [request startAsynchronous];
    PFUserManager *userManager = [[PFUserManager alloc] init];
    userManager.delegate = self;
    [userManager getProfileById:self.userId];
}
- (IBAction)backTapped:(id)sender {
    [self.view removeFromSuperview];
}
- (void)dealloc {
    [_ContentView release];
    [_imgUserView release];
    [_fbView release];
    [_emailView release];
    [_phoneView release];
    [_navTitle release];
    [_nameLabel release];
    [_facebookLable release];
    [_emailLabel release];
    [_profileImg release];
    [_phoneLable release];
    [super dealloc];
}

- (void)PFUserManager:(id)sender getProfileByIdResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    self.facebookLable.text = [[NSString alloc ]initWithFormat:@"facebook.com/%@",[response objectForKey:@"facebook_id"]];
    self.emailLabel.text = [response objectForKey:@"email_show"];
    self.phoneLable.text = [response objectForKey:@"phone_show"];
    self.nameLabel.text = [response objectForKey:@"username"];
    self.navTitle.text = [response objectForKey:@"username"];
    
}
- (void)PFUserManager:(id)sender getProfileByIdErrorResponse:(NSString *)errorResponse {
    
}

- (IBAction)imgTapped:(id)sender {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@/picture?display=full",API_URL,self.userId]autorelease];
    [self.delegate PFAccountViewControllerPhoto:urlStr];
}

@end
