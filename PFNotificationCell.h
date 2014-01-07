//
//  PFNotificationCell.h
//  DanceZone
//
//  Created by aOmMiez on 10/5/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFNotificationCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *msgLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imgType;
@property (retain, nonatomic) IBOutlet UIImageView *bg;

@end
