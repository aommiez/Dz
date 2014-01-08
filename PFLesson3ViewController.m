//
//  PFLesson3ViewController.m
//  DanceZone
//
//  Created by aOmMiez on 9/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLesson3ViewController.h"

@interface PFLesson3ViewController ()

@end

@implementation PFLesson3ViewController

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

 
    self.scrollView.contentSize = CGSizeMake(320, self.videoView.frame.size.height);
    [self.scrollView addSubview:self.videoView];
    
    self.desTextView.text = [self.videoObj objectForKey:@"description"];
    
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    NSString *nameId = [[NSString alloc] initWithFormat:@"%@.mp4",[self.videoObj objectForKey:@"id"]];
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:nameId];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExists) {
        self.fileURL = [NSURL fileURLWithPath:filePath];
        self.downloadBut.alpha = 0;
        self.delFile.alpha = 1;
    } else {
        NSString *fileUrl = [[NSString alloc] initWithFormat:@"%@",[self.videoObj objectForKey:@"link"]];
        self.fileURL = [NSURL URLWithString:fileUrl];
    }
    

    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:self.fileURL];

    [self.moviePlayerController.view setFrame:CGRectMake(0, 0, 0, 0)];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayerController];
    NSString *urlStr = [self.videoObj objectForKey:@"thumb"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self.myImageView loadImageFromURL:url];
    [self.myImageView setContentMode:UIViewContentModeScaleToFill];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:self.moviePlayerController];


    [self.view addSubview:self.moviePlayerController.view];
    //[self playVideo:self];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_videoImg release];
    [_desTextView release];
    [_scrollView release];
    [_videoView release];
    [_downloadBut release];
    [_progressView release];
    [_delFile release];
    [_moviePlayerController release];
    [super dealloc];
}
- (IBAction)playVideo:(id)sender {
    self.myImageView.alpha = 1;
    //[self.moviePlayerController.view setFrame:CGRectMake(0, 45, 320, 228)];
    self.moviePlayerController.fullscreen = YES;
    [self.moviePlayerController play];
}


- (void)moviePlayBackDidFinish:(NSNotification*)notification {
    self.myImageView.alpha = 1;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         self.moviePlayerController.fullscreen = NO;
                     }
                     completion:^(BOOL finished) {
                         self.moviePlayerController.fullscreen = NO;
                         
                     }];
}
-(void)doneButtonClick:(NSNotification*)aNotification{
    [self.moviePlayerController stop];
    self.moviePlayerController.fullscreen = NO;
}
- (IBAction)downloadFile:(id)sender {
    /*
    [[[UIAlertView alloc] initWithTitle:@"DanceZone"
                                message:@"Download Video Backgroud Mode"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];*/
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@",[self.videoObj objectForKey:@"link"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDownloadProgressDelegate:self];
    [request setCompletionBlock:^{
        self.downloadBut.alpha = 0;
        self.delFile.alpha = 1;
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
        NSString *nameId = [[NSString alloc] initWithFormat:@"%@.mp4",[self.videoObj objectForKey:@"id"]];
        NSString *filePath = [resourceDocPath stringByAppendingPathComponent:nameId];
        [responseData writeToFile:filePath atomically:YES];
        //self.fileURL = [NSURL fileURLWithPath:filePath];
        //self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:self.fileURL];
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [request startAsynchronous];
}
- (void)setProgress:(float)progress
{
    [self.progressView setProgress:progress];
}
- (IBAction)delFileTapped:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    NSString *nameId = [[NSString alloc] initWithFormat:@"%@.mp4",[self.videoObj objectForKey:@"id"]];
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:nameId];
    [fileManager removeItemAtPath:filePath error:nil];
    self.downloadBut.alpha = 1;
    self.delFile.alpha = 0;
    
}


@end
