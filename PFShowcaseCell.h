//
//  PFShowcaseCell.h
//  DanceZone
//
//  Created by aOmMiez on 8/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface PFShowcaseCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *youtubeImg;
@property (retain, nonatomic) IBOutlet UILabel *desLabel;
@property (retain, nonatomic) IBOutlet UILabel *viewLabel;
@property (retain, nonatomic) IBOutlet UILabel *likeLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@end
