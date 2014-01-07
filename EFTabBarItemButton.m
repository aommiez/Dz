//
//  EFTabBarItemButton.m
//  Capsules
//
//  Created by Soemsak on 12/20/12.
//  Copyright (c) 2012 Soemsak Loetphornphisit. All rights reserved.
//

#import "EFTabBarItemButton.h"

@implementation EFTabBarItemButton

- (void)dealloc{
    [_highlightedImage release];
    [_stanbyImage release];
    [_badge release];
    [super dealloc];
}

#pragma mark - 
- (void)presentStanbyState{
    [self setImage:self.stanbyImage forState:UIControlStateNormal];
    [self setImage:self.stanbyImage forState:UIControlStateHighlighted];
}

- (void)presentHighlightedState{
    [self setImage:self.highlightedImage forState:UIControlStateNormal];
    [self setImage:self.highlightedImage forState:UIControlStateHighlighted];

}

- (void)setBadge:(NSString *)badge{
    [_badge release];
    _badge = badge;
    [_badge retain];
    [_customBadge removeFromSuperview];
    _customBadge = [CustomBadge customBadgeWithString:_badge
                                      withStringColor:[UIColor whiteColor]
                                       withInsetColor:[UIColor redColor]
                                       withBadgeFrame:YES
                                  withBadgeFrameColor:[UIColor whiteColor]
                                            withScale:1.0
                                          withShining:YES];
    [_customBadge setFrame:CGRectMake(self.frame.size.width - _customBadge.frame.size.width,
                                      0,
                                      _customBadge.frame.size.width,
                                      _customBadge.frame.size.height)];
	[self addSubview:_customBadge];
    [_customBadge setHidden:NO];
}

- (void)hideBadge{
    [_customBadge setHidden:YES];
}

@end
