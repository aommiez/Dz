//
//  PFNewsCommentCell.m
//  DanceZone
//
//  Created by aOmMiez on 9/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFNewsCommentCell.h"

@implementation PFNewsCommentCell

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
    [_commentLabel release];
    [_nameLabel release];
    [_userImg release];
    [_imgBut release];
    [_bgComment release];
    [_lineImg release];
    [_headImg release];
    [_hView release];
    [_timeComment release];
    [super dealloc];
}
- (IBAction)userImgTapped:(id)sender {
    NSString *userId = [[NSString alloc] initWithFormat:@"%ld",(long)self.imgBut.tag];
    [self.delegate DidUserId:userId];
    
}
@end
