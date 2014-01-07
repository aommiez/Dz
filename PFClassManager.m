//
//  PFClassManager.m
//  DanceZone
//
//  Created by aOmMiez on 9/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFClassManager.h"

@implementation PFClassManager
- (void)getClass{
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@class",API_URL]autorelease];
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFClassManager:self getClassResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFClassManager:self getClassErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getGroupByClassId:(NSString *)classId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@class/%@/group",API_URL,classId]autorelease];
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFClassManager:self getGroupByClassIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFClassManager:self getGroupByClassIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)registerClassId:(NSString *)classId groupId:(NSString *)groupId email:(NSString *)email phone:(NSString *)phone name:(NSString *)name {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@class/%@/group/%@/register",API_URL,classId,groupId]autorelease];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:email forKey:@"email"];
    [request setPostValue:phone forKey:@"phone_number"];
    [request setPostValue:name forKey:@"name"];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(registerClassIdFinished:)];
    [request setDidFailSelector:@selector(registerClassIdFailed:)];
    [request startAsynchronous];
}
- (void)registerClassIdFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    [self.delegate PFClassManager:self registerClassIdResponse:dict];
    return;
}
- (void)registerClassIdFailed:(ASIHTTPRequest *)request{
    [self.delegate PFClassManager:self registerClassIdErrorResponse:[[request error] localizedDescription]];
}
@end
