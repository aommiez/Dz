
//
//  PFNewsManager.m
//  DanceZone
//
//  Created by aOmMiez on 9/25/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFNewsManager.h"

@implementation PFNewsManager

- (void)getNews {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@news",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFNewsManager:self getNewsResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFNewsManager:self getNewsErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getNewsById:(NSString *)newsId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@news/%@",API_URL,newsId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFNewsManager:self getNewsByIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFNewsManager:self getNewsByIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getCommentNewsId:(NSString *)newsId limit:(int)limit linkUrl:(NSString *)linkUrl {
    NSString *urlStr = [[NSString alloc] init];
    NSURL *url = [[NSURL alloc] init];

    if (limit == 0 ) {
        urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/comment",API_URL,newsId]autorelease];
    } else if ( limit > 0) {
        urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/comment?limit=%d",API_URL,newsId,limit]autorelease];
    } else if (linkUrl != nil) {
        urlStr = [[[NSString alloc] initWithFormat:@"%@",linkUrl]autorelease];
    }
    
    url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFNewsManager:self getCommentNewsIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFNewsManager:self getCommentNewsIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)likeNewsId:(NSString *)token newsId:(NSString *)newsId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/like",API_URL,newsId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:token];
    [request setRequestMethod:@"POST"];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(likeNewsIdFinished:)];
    [request setDidFailSelector:@selector(likeNewsIdFailed:)];
    [request startAsynchronous];
}
- (void)likeNewsIdFinished:(ASIHTTPRequest *)request
{
    SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [resultJson objectWithString:[request responseString]];
    NSLog(@"%@",resJson);
    return;
}
- (void)likeNewsIdFailed:(ASIHTTPRequest *)request{
    NSLog(@"%@",[request error]);
}
- (void)commentNewsById:(NSString *)newsId message:(NSString *)message token:(NSString *)token {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/comment",API_URL,newsId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:token];
    [request setRequestMethod:@"POST"];
    [request setPostValue:message forKey:@"message"];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(commentNewsByIdFinished:)];
    [request setDidFailSelector:@selector(commentNewsByIdFailed:)];
    [request startAsynchronous];
}
- (void)commentNewsByIdFinished:(ASIHTTPRequest *)request
{
    SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [resultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    [self.delegate PFNewsManager:self commentNewsByIdResponse:dict];
    return;
}
- (void)commentNewsByIdFailed:(ASIHTTPRequest *)request{
    [self.delegate PFNewsManager:self commentNewsByIdErrorResponse:[[request error] localizedDescription]];
}
- (void)unLikeNewsId:(NSString *)token newsId:(NSString *)newsId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/like",API_URL,newsId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:token];
    [request setRequestMethod:@"DELETE"];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(unLikeNewsIdFinished:)];
    [request setDidFailSelector:@selector(unLikeNewsIdFailed:)];
    [request startAsynchronous];
    
}
- (void)unLikeNewsIdFinished:(ASIHTTPRequest *)request
{
    SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [resultJson objectWithString:[request responseString]];
    NSLog(@"%@",resJson);
    return;
}
- (void)unLikeNewsIdFailed:(ASIHTTPRequest *)request{
    NSLog(@"%@",[request error]);
}
@end
