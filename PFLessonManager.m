//
//  PFLessonManager.m
//  DanceZone
//
//  Created by aOmMiez on 9/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLessonManager.h"

@implementation PFLessonManager

- (void)getLesson {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@lesson",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFLessonManager:self getLessonResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFLessonManager:self getLessonErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getChapterlistByLessonId:(NSString *)lessonId {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@lesson/%@/chapter",API_URL,lessonId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFLessonManager:self getChapterlistByLessonIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFLessonManager:self getChapterlistByLessonIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}

- (void)getVideolistByChapterId:(NSString *)chapterId lessonId:(NSString *)lessonId{
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@lesson/%@/chapter/%@/video",API_URL,lessonId,chapterId]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setRequestMethod:@"GET"];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(getVideolistByChapterIdFinished:)];
    [request setDidFailSelector:@selector(getVideolistByChapterIdFailed:)];
    [request startAsynchronous];
    /*
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFLessonManager:self getVideolistByChapterIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFLessonManager:self getVideolistByChapterIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];*/
}

- (void)getVideolistByChapterIdFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    NSLog(@"%@",dict);
    [self.delegate PFLessonManager:self getVideolistByChapterIdResponse:dict];
    
    return;
}
- (void)getVideolistByChapterIdFailed:(ASIHTTPRequest *)request{
    [self.delegate PFLessonManager:self getVideolistByChapterIdErrorResponse:[[request error] localizedDescription]];
}


- (void)registerLesson:(NSString *)email phone:(NSString *)phone name:(NSString *)name {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@register_upgrade",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
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
    [request setDidFinishSelector:@selector(registerLessonFinished:)];
    [request setDidFailSelector:@selector(registerLessonFailed:)];
    [request startAsynchronous];
}
- (void)registerLessonFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    [self.delegate PFLessonManager:self registerLessonResponse:dict];
    return;
}
- (void)registerLessonFailed:(ASIHTTPRequest *)request{
    [self.delegate PFLessonManager:self registerLessonErrorResponse:[[request error] localizedDescription]];
}
@end

