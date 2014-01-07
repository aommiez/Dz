//
//  PFLessonCell.h
//  DanceZone
//
//  Created by aOmMiez on 8/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface PFLessonCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lessonName;
@property (retain, nonatomic) IBOutlet UIView *bgTypeView;
@property (retain, nonatomic) IBOutlet UIImageView *dancePic;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@end
