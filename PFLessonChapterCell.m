//
//  PFLessonChapterCell.m
//  DanceZone
//
//  Created by aOmMiez on 9/30/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLessonChapterCell.h"

@implementation PFLessonChapterCell

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
    [_textView release];
    [_detailView release];
    [_nameLabel release];
    [_bgBut release];
    [super dealloc];
}
@end
