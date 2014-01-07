//
//  PFCalendarViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/4/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//
#import "TapkuLibrary.h"
#import "TKCalendarMonthTableViewController.h"
#import "monthCell.h"
#import "PFActivitiesManager.h"
#import "AMBlurView.h"
#import "NSDate+Helper.h"
#import "PFActivitiesDetailViewController.h"
#import "PFClassDetailViewController.h"
@protocol PFCalendarViewControllerDelegate <NSObject>

- (void)PFCalendarViewControllerBack;

@end


@interface PFCalendarViewController : TKCalendarMonthTableViewController
@property (assign, nonatomic) id<PFCalendarViewControllerDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *dataArray1;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *actArray;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
@property (nonatomic,strong) NSMutableDictionary *stuDictionary;
@property (nonatomic,strong) NSMutableDictionary *actDictionary;
@property (nonatomic, retain) NSDictionary *obj;
@property (nonatomic, retain) NSDate *dateStart;
@property (nonatomic, retain) NSDate *dateEnd;
@property (nonatomic, retain) NSMutableArray *allDataArray;
- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;
@end
