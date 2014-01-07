//
//  PFNewsManager.h
//  DanceZone
//
//  Created by aOmMiez on 9/25/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"


@protocol PFNewsManagerDelegate <NSObject>
- (void)PFNewsManager:(id)sender getCommentNewsIdResponse:(NSDictionary *)response;
- (void)PFNewsManager:(id)sender getCommentNewsIdErrorResponse:(NSString *)errorResponse;
- (void)PFNewsManager:(id)sender getNewsByIdResponse:(NSDictionary *)response;
- (void)PFNewsManager:(id)sender getNewsByIdErrorResponse:(NSString *)errorResponse;
- (void)PFNewsManager:(id)sender getNewsResponse:(NSDictionary *)response;
- (void)PFNewsManager:(id)sender getNewsErrorResponse:(NSString *)errorResponse;
- (void)PFNewsManager:(id)sender commentNewsByIdResponse:(NSDictionary *)response;
- (void)PFNewsManager:(id)sender commentNewsByIdErrorResponse:(NSString *)errorResponse;
@end


@interface PFNewsManager : NSObject
@property (assign, nonatomic) id delegate;

- (void)getCommentNewsId:(NSString *)newsId limit:(int)limit linkUrl:(NSString *)linkUrl;
- (void)getNews;
- (void)getNewsById:(NSString *)newsId;
- (void)unLikeNewsId:(NSString *)token newsId:(NSString *)newsId;
- (void)likeNewsId:(NSString *)token newsId:(NSString *)newsId;
- (void)commentNewsById:(NSString *)newsId message:(NSString *)message token:(NSString *)token;
@end
