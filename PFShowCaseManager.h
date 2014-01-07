//
//  PFShowCaseManager.h
//  DanceZone
//
//  Created by aOmMiez on 9/24/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@protocol PFShowCaseManagerDelegate <NSObject>
- (void)PFShowCaseManager:(id)sender getShowCaseIdResponse:(NSDictionary *)response;
- (void)PFShowCaseManager:(id)sender getShowCaseIdErrorResponse:(NSString *)errorResponse;
- (void)PFShowCaseManager:(id)sender getShowCaseResponse:(NSDictionary *)response;
- (void)PFShowCaseManager:(id)sender getShowCaseErrorResponse:(NSString *)errorResponse;

@end

@interface PFShowCaseManager : NSObject

@property (assign, nonatomic) id delegate;
- (void)getShowCase;
- (void)getShowCaseId:(NSString *)objectid;
@end
