//
//  PFClassDetailViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFClassDetailViewController.h"

@interface PFClassDetailViewController ()

@end

@implementation PFClassDetailViewController

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
    self.lable1.text = [self.obj objectForKey:@"description"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:[self.obj objectForKey:@"name"]];
    [self.navigationItem setTitleView:myLabel];
    [self.imgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imgView.layer setShadowOpacity:0.8];
    [self.imgView.layer setShadowRadius:3.0];
    [self.imgView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.nameLessonView setBackgroundColor:RGB(230, 237, 153)];
    [self.nameLessonView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.nameLessonView.layer setShadowOpacity:0.8];
    [self.nameLessonView.layer setShadowRadius:3.0];
    [self.nameLessonView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.registerButton.layer setCornerRadius:4.0f];
    self.registerButton.backgroundColor = [UIColor lightGrayColor];
    
    NSLog(@"%@",self.obj);
    
    NSString *fileUrl = [[NSString alloc] initWithFormat:@"%@",[[self.obj objectForKey:@"video"] objectForKey:@"link"]];
    NSURL *fileURL = [NSURL URLWithString:fileUrl];
    [self.moviePlayerController.view setFrame:CGRectMake(0, 0, 0, 0)];
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    [self.view addSubview:self.moviePlayerController.view];
    
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[[self.obj objectForKey:@"video"] objectForKey:@"thumb"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        UIImage *img = [UIImage imageWithData:responseData];
        self.img1.image = img;
        
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_imgView release];
    [_nameLessonView release];
    [_registerButton release];
    [_lable1 release];
    [_img1 release];
    [super dealloc];
}
- (IBAction)registerTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFRegisterViewController *registerViewController = [[PFRegisterViewController alloc] initWithNibName:@"PFRegisterViewController_Wide" bundle:nil];
        registerViewController.obj = self.obj;
        [self.navigationController pushViewController:registerViewController animated:YES];
    } else {
        PFRegisterViewController *registerViewController = [[PFRegisterViewController alloc] initWithNibName:@"PFRegisterViewController" bundle:nil];
        registerViewController.obj = self.obj;
        [self.navigationController pushViewController:registerViewController animated:YES];
    }
}
- (IBAction)playVideo:(id)sender {
    [self.moviePlayerController.view setFrame:CGRectMake(0, 70, 320, 270)];
    self.moviePlayerController.fullscreen = YES;
    [self.moviePlayerController play];
}
-(void)doneButtonClick:(NSNotification*)aNotification{
    NSLog(@"video done");
    [self.moviePlayerController.view setFrame:CGRectMake(0, 0, 0, 0)];
    [self.moviePlayerController stop];
}
@end
