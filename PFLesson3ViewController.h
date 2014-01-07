//
//  PFLesson3ViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "AsyncImageView.h"

@protocol PFLesson3ViewControllerDelegate <NSObject>

- (void)PFLesson3ViewControllerDelegateResetVideo;

@end

@interface PFLesson3ViewController : UIViewController

@property (assign, nonatomic) id<PFLesson3ViewControllerDelegate> delegate;

@property (retain, nonatomic) NSDictionary *videoObj;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (retain, nonatomic) NSURL *fileURL;
@property (retain, nonatomic) IBOutlet UIImageView *videoImg;

@property (retain, nonatomic) IBOutlet UITextView *desTextView;
@property (retain, nonatomic)  MPMoviePlayerController *moviePlayerController;

- (IBAction)playVideo:(id)sender;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *videoView;

- (IBAction)downloadFile:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *downloadBut;
@property (retain, nonatomic) IBOutlet UIProgressView *progressView;
@property (retain, nonatomic) IBOutlet UIButton *delFile;
- (IBAction)delFileTapped:(id)sender;

@end
