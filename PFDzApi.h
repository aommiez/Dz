//
//  PFDzApi.h
//  DanceZone
//
//  Created by MRG on 11/4/2556 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"


@protocol PFDzApiDelegate <NSObject>
- (void)PFDzApi:(id)sender DzApiLikeObjectResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzApiLikeObjectErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzApiUnLikeObjectResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzApiUnLikeObjectErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzApiCommentObjectResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzApiCommentObjectErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzAPiFeedResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzAPiFeedErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzApiObjectResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzApiObjectErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzApiCommentObjectIdResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzApiCommentObjectIdErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzApiGetCalerdarResponse:(NSDictionary *)response sDate:(NSDate*)sDate eDate:(NSDate*)eDate;
- (void)PFDzApi:(id)sender DzApiGetCalerdarErrorResponse:(NSString *)errorResponse;
- (void)PFDzApi:(id)sender DzApiReadNotifyResponse:(NSDictionary *)response;
- (void)PFDzApi:(id)sender DzApiReadNotifyErrorResponse:(NSString *)errorResponse;

@end


@interface PFDzApi : NSObject
@property (assign, nonatomic) id delegate;
- (void)DzApiLikeObject:(NSString *)objectId;
- (void)DzApiUnLikeObject:(NSString *)objectId;
- (void)DzApiCommentObject:(NSString *)objectId msg:(NSString *)msg;
- (void)DzApiFeed:(NSString *)limit link:(NSString *)link;
- (void)DzApiObject:(NSString *)objectId;
- (void)DzApiCommentObjectId:(NSString *)objectId limit:(NSString *)limit next:(NSString *)next;
- (void)DzApiGetCalerdar:(NSString *)startDate endDate:(NSString *)endDate sDate:(NSDate*)sDate eDate:(NSDate*)eDate;
- (void)DzApiReadNotify:(NSString *)notifyId;
@end
