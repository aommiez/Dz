//
//  PFShowCaseManager.m
//  DanceZone
//
//  Created by aOmMiez on 9/24/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFShowCaseManager.h"

@implementation PFShowCaseManager

- (void)getShowCase {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@showcase",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFShowCaseManager:self getShowCaseResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFShowCaseManager:self getShowCaseErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getShowCaseId:(NSString *)objectid {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@showcase/%@",API_URL,objectid]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFShowCaseManager:self getShowCaseIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFShowCaseManager:self getShowCaseIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
@end
