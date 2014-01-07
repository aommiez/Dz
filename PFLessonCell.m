//
//  PFLessonCell.m
//  DanceZone
//
//  Created by aOmMiez on 8/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLessonCell.h"

@implementation PFLessonCell

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
    [_lessonName release];
    [_bgTypeView release];
    [_dancePic release];
    [super dealloc];
}
@end
