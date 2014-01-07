//
//  PFLesson2Cell.h
//  DanceZone
//
//  Created by aOmMiez on 9/5/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
@interface PFLesson2Cell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *videoDes;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@property (retain, nonatomic) IBOutlet UIButton *downloadBut;
- (IBAction)downloadFile:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *delFile;
- (IBAction)delFileTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIProgressView *progressView;
@property (retain, nonatomic) IBOutlet UIImageView *lockImg;

@end
