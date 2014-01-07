//
//  PFActivitiesManager.m
//  DanceZone
//
//  Created by aOmMiez on 9/28/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFActivitiesManager.h"


@implementation PFActivitiesManager


- (void)getActivitiesByM:(NSString *)m year:(NSString *)year{
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity?month=%@&year=%@",API_URL,m,year]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request addRequestHeader:@"test" value:@"1111"];
    [request setRequestMethod:@"GET"];
    [request setUploadProgressDelegate:self];
    [request setDelegate:self];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(getActivitiesByMFinished:)];
    [request setDidFailSelector:@selector(getActivitiesByMFailed:)];
    [request startAsynchronous];
    
}
- (void)getActivitiesByMFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    //NSLog(@"%@",dict);
    [self.delegate PFActivitiesManager:self getActivitiesByMResponse:dict];
    return;
}
- (void)getActivitiesByMFailed:(ASIHTTPRequest *)request{
    [self.delegate PFActivitiesManager:self getActivitiesByMErrorResponse:[[request error] localizedDescription]];
}
- (void)joinActivitiesId:(NSString *)actId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity/%@/user",API_URL,actId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"POST"];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFActivitiesManager:self joinActivitiesIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFActivitiesManager:self joinActivitiesIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
-  (void)unjoinActivitiesId:(NSString *)actId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity/%@/user",API_URL,actId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"DELETE"];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFActivitiesManager:self unjoinActivitiesIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFActivitiesManager:self unjoinActivitiesIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getActivitiesById:(NSString *)actId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity/%@",API_URL,actId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFActivitiesManager:self getActivitiesByIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFActivitiesManager:self getActivitiesByIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getactivitiCalerdar:(NSString *)startDate endDate:(NSString *)endDate sDate:(NSDate*)sDate eDate:(NSDate*)eDate;{
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@activity?list_mode=day&start_date=%@&end_date=%@",API_URL,startDate,endDate]autorelease];
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFActivitiesManager:self getactivitiCalerdarResponse:dict sDate:sDate eDate:eDate];
    }];
    [request setFailedBlock:^{
        [self.delegate PFActivitiesManager:self getactivitiCalerdarErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}

@end
