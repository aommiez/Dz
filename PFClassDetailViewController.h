//
//  PFClassDetailViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PFRegisterViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PFClassDetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIView *imgView;
@property (retain, nonatomic) IBOutlet UIView *nameLessonView;
- (IBAction)registerTapped:(id)sender;
@property (retain, nonatomic) NSDictionary *obj;
@property (retain, nonatomic) IBOutlet UIButton *registerButton;
@property (retain, nonatomic) IBOutlet UILabel *lable1;
@property (retain, nonatomic)  MPMoviePlayerController *moviePlayerController;
@property (retain, nonatomic) IBOutlet UIImageView *img1;
- (IBAction)playVideo:(id)sender;


@end
