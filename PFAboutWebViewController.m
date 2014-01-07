//
//  PFAboutWebViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/25/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFAboutWebViewController.h"

@interface PFAboutWebViewController ()

@end

@implementation PFAboutWebViewController

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
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@",self.webUrl];
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *videoReq = [NSURLRequest requestWithURL:url];
    [self.webView setDelegate:self];
    [self.webView loadRequest:videoReq];
    [self showActivityIndicator];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:self.navTitleText];
    [self.navigationItem setTitleView:myLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [_navTitle release];
    [_loadingView release];
    [super dealloc];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self removeLoadingView];
    NSLog(@"finish");
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self removeLoadingView];
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}
-(void) showActivityIndicator
{
    //Add a UIView in your .h and give it the same property as you have given to your webView.
    //Also ensure that you synthesize these properties on top of your implementation file
    
    
    //self.loadingView.alpha = 0.5;
    
    //Create and add a spinner to loadingView in the center and animate it. Then add this loadingView to self.View using
    [self.view addSubview:self.loadingView];
}
-(void) removeLoadingView
{
    [self.loadingView removeFromSuperview];
}
@end
