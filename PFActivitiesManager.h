//
//  PFActivitiesManager.h
//  DanceZone
//
//  Created by aOmMiez on 9/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@protocol PFActivitiesManagerDelegate <NSObject>

- (void)PFActivitiesManager:(id)sender unjoinActivitiesIdResponse:(NSDictionary *)response;
- (void)PFActivitiesManager:(id)sender unjoinActivitiesIdErrorResponse:(NSString *)errorResponse;

- (void)PFActivitiesManager:(id)sender joinActivitiesIdResponse:(NSDictionary *)response;
- (void)PFActivitiesManager:(id)sender joinActivitiesIdErrorResponse:(NSString *)errorResponse;

- (void)PFActivitiesManager:(id)sender getActivitiesByMResponse:(NSDictionary *)response;
- (void)PFActivitiesManager:(id)sender getActivitiesByMErrorResponse:(NSString *)errorResponse;

- (void)PFActivitiesManager:(id)sender getActivitiesByIdResponse:(NSDictionary *)response;
- (void)PFActivitiesManager:(id)sender getActivitiesByIdErrorResponse:(NSString *)errorResponse;

- (void)PFActivitiesManager:(id)sender getactivitiCalerdarResponse:(NSDictionary *)response sDate:(NSDate*)sDate eDate:(NSDate*)eDate;;
- (void)PFActivitiesManager:(id)sender getactivitiCalerdarErrorResponse:(NSString *)errorResponse;

@end

@interface PFActivitiesManager : NSObject
@property (assign, nonatomic) id delegate;

- (void)getActivitiesByM:(NSString *)m year:(NSString *)year;
- (void)joinActivitiesId:(NSString *)actId;
- (void)unjoinActivitiesId:(NSString *)actId;
- (void)getActivitiesById:(NSString *)actId;
- (void)getactivitiCalerdar:(NSString *)startDate endDate:(NSString *)endDate sDate:(NSDate*)sDate eDate:(NSDate*)eDate;
@end
