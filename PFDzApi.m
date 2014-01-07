//
//  PFDzApi.m
//  DanceZone
//
//  Created by MRG on 11/4/2556 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFDzApi.h"

@implementation PFDzApi
- (void)DzApiLikeObject:(NSString *)objectId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/like",API_URL,objectId]autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"POST"];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFDzApi:self DzApiLikeObjectResponse:dict];
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",[[request error] localizedDescription]);
        [self.delegate PFDzApi:self DzApiLikeObjectErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)DzApiUnLikeObject:(NSString *)objectId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/like",API_URL,objectId]autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"DELETE"];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFDzApi:self DzApiUnLikeObjectResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFDzApi:self DzApiUnLikeObjectErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)DzApiCommentObject:(NSString *)objectId msg:(NSString *)msg{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/comment",API_URL,objectId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:msg forKey:@"message"];
    [request setUploadProgressDelegate:self];
    [request setDelegate:self];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(DzApiCommentObjectFinished:)];
    [request setDidFailSelector:@selector(DzApiCommentObjectFailed:)];
    [request startAsynchronous];
}
- (void)DzApiCommentObjectFinished:(ASIHTTPRequest *)request
{
    SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [resultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    [self.delegate PFDzApi:self DzApiCommentObjectResponse:dict];
    return;
}
- (void)DzApiCommentObjectFailed:(ASIHTTPRequest *)request{
    [self.delegate PFDzApi:self DzApiCommentObjectErrorResponse:[[request error] localizedDescription]];
}
- (void)DzApiFeed:(NSString *)limit link:(NSString *)link {
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[NSString alloc] init];
    if ([limit isEqualToString:@"NO"] && [link isEqualToString:@"NO"] ) {
        urlStr = [[NSString alloc] initWithFormat:@"%@feed",API_URL];
    } else if (![limit isEqualToString:@"NO"] && [link isEqualToString:@"NO"] ) {
        urlStr = [[NSString alloc] initWithFormat:@"%@feed?limit=%@",API_URL,limit];
    } else if (![link isEqualToString:@"NO"]) {
        urlStr = [[NSString alloc] initWithFormat:@"%@",link];
    }
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFDzApi:self DzAPiFeedResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFDzApi:self DzAPiFeedErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)DzApiObject:(NSString *)objectId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@",API_URL,objectId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFDzApi:self DzApiObjectResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFDzApi:self DzApiObjectErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}

- (void)DzApiCommentObjectId:(NSString *)objectId limit:(NSString *)limit next:(NSString *)next {
    NSString *urlStr = [[NSString alloc] init];
    if (![limit isEqualToString:@"NO"] && [next isEqualToString:@"NO"]) {
        urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/comment?limit=%@",API_URL,objectId,limit]autorelease];
    } else if ([limit isEqualToString:@"NO"] && [next isEqualToString:@"NO"]) {
        urlStr = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/comment",API_URL,objectId]autorelease];
    } else if (![next isEqualToString:@"NO"]) {
        urlStr = [[NSString alloc] initWithFormat:@"%@",next];
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFDzApi:self DzApiCommentObjectIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFDzApi:self DzApiCommentObjectIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)DzApiGetCalerdar:(NSString *)startDate endDate:(NSString *)endDate sDate:(NSDate*)sDate eDate:(NSDate*)eDate {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity?list_mode=day&start_date=%@&end_date=%@",API_URL,startDate,endDate]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFDzApi:self DzApiGetCalerdarResponse:dict sDate:sDate eDate:eDate];
    }];
    [request setFailedBlock:^{
        [self.delegate PFDzApi:self DzApiGetCalerdarErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}

- (void)DzApiReadNotify:(NSString *)notifyId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@notification/read/%@",API_URL,notifyId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];

    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        //SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        //id resJson = [resultJson objectWithString:[request responseString]];
        //NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        //[self.delegate PFDzApi:self DzApiReadNotifyResponse:dict];
        NSLog(@"read update ok");
    }];
    [request setFailedBlock:^{
        //[self.delegate PFDzApi:self DzApiReadNotifyErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
@end
