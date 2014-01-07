//
//  EFTabBarItemButton.h
//  Capsules
//
//  Created by Soemsak on 12/20/12.
//  Copyright (c) 2012 Soemsak Loetphornphisit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBadge.h"

@interface EFTabBarItemButton : UIButton
{
    @private
    CustomBadge *_customBadge;
}

@property (retain, nonatomic) UIImage *highlightedImage;
@property (retain, nonatomic) UIImage *stanbyImage;
@property (retain, nonatomic) NSString *badge;

- (void)setBadge:(NSString *)badge;
- (void)presentStanbyState;
- (void)presentHighlightedState;
- (void)hideBadge;
@end
