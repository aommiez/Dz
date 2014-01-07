//
//  PFShowcaseCell.m
//  DanceZone
//
//  Created by aOmMiez on 8/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFShowcaseCell.h"

@implementation PFShowcaseCell

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
    [_youtubeImg release];
    [_desLabel release];
    [_viewLabel release];
    [_likeLabel release];
    [_commentLabel release];
    [super dealloc];
}
@end
