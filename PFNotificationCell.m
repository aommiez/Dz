//
//  PFNotificationCell.m
//  DanceZone
//
//  Created by aOmMiez on 10/5/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFNotificationCell.h"

@implementation PFNotificationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_msgLabel release];
    [_timeLabel release];
    [_imgType release];
    [_bg release];
    [super dealloc];
}
@end
