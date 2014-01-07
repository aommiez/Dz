//
//  PFNewsCommentCell.h
//  DanceZone
//
//  Created by aOmMiez on 9/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol PFNewsCommentCellDelegate <NSObject>

- (void)DidUserId:(NSString *)userId;

@end

@interface PFNewsCommentCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *userImg;
- (IBAction)userImgTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *imgBut;
@property (assign, nonatomic) id <PFNewsCommentCellDelegate> delegate;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@property (retain, nonatomic) IBOutlet UIImageView *bgComment;
@property (retain, nonatomic) IBOutlet UIImageView *lineImg;

@property (retain, nonatomic) IBOutlet UIImageView *headImg;
@property (retain, nonatomic) IBOutlet UIImageView *hView;

@property (retain, nonatomic) IBOutlet UILabel *timeComment;

@end
