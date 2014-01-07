//
//  PFUpdateCell.h
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNewsManager.h"
#import "PFNewsCommentViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import <Social/Social.h>
#import "AsyncImageView.h"
#import "PFDzApi.h"
@protocol PFUpdateCellDelegate <NSObject>

- (void)shareFb:(NSDictionary *)res;
- (void)commentView:(NSString *)newsId;
- (void)imgTapped:(NSString *)imgId;
@end

@interface PFUpdateCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet UIImageView *newsImg;
@property (retain, nonatomic) IBOutlet UILabel *newsTitle;
@property (retain, nonatomic) IBOutlet UILabel *likeLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;
@property (retain, nonatomic) IBOutlet UIButton *likeButton;
@property (retain, nonatomic) IBOutlet UILabel *pubDate;
- (IBAction)commentTapped:(id)sender;
- (IBAction)shareTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *commentBut;
@property (retain, nonatomic) IBOutlet UIButton *shareBut;
@property (assign, nonatomic) id delegate;
- (IBAction)likeTapped:(id)sender;
- (IBAction)imgTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *imgBut;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@property (retain, nonatomic) IBOutlet UIView *overlayView;


@end
