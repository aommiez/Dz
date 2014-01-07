//
//  PFClassManager.h
//  DanceZone
//
//  Created by aOmMiez on 9/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@protocol PFClassManagerDelegate <NSObject>
- (void)PFClassManager:(id)sender getGroupByClassIdResponse:(NSDictionary *)response;
- (void)PFClassManager:(id)sender getGroupByClassIdErrorResponse:(NSString *)errorResponse;

- (void)PFClassManager:(id)sender getClassResponse:(NSDictionary *)response;
- (void)PFClassManager:(id)sender getClassErrorResponse:(NSString *)errorResponse;

- (void)PFClassManager:(id)sender registerClassIdResponse:(NSDictionary *)response;
- (void)PFClassManager:(id)sender registerClassIdErrorResponse:(NSString *)errorResponse;


@end

@interface PFClassManager : NSObject
@property (assign, nonatomic) id delegate;
- (void)getClass;
- (void)getGroupByClassId:(NSString *)classId;
- (void)registerClassId:(NSString *)classId groupId:(NSString *)groupId email:(NSString *)email phone:(NSString *)phone name:(NSString *)name;

@end
