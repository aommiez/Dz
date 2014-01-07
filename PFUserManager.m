//
//  PFUserManager.m
//  DanceZone
//
//  Created by aOmMiez on 9/20/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFUserManager.h"

@implementation PFUserManager

#pragma mark - login with email
- (void)loginWithEmail:(NSString *)email Password:(NSString *)password {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@auth",API_URL];
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:email forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setPostValue:[defaults objectForKey:@"deviceToken"] forKey:@"deviceToken"];
    [request setDelegate:self];
    [request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(loginWithEmailFinished:)];
    [request setDidFailSelector:@selector(loginWithEmailFailed:)];
    [request startAsynchronous];
}
- (void)loginWithEmailFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *err = [[[NSDictionary alloc] initWithDictionary:[resJson objectForKey:@"error"]] autorelease];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];

    if ( [[err objectForKey:@"code"] intValue] == 0 ) {
        [self.delegate PFUserManager:self loginWithEmailResponse:dict];
    } else {
        [self.delegate PFUserManager:self loginWithEmailErrorResponse:[err objectForKey:@"message"]];
    }
    return;
}

- (void)loginWithEmailFailed:(ASIHTTPRequest *)request{
    [self.delegate PFUserManager:self loginWithEmailErrorResponse:[[request error] localizedDescription]];
}
#pragma - login with facebook 
- (void)loginWithFacebook:(NSString *)email fbid:(NSString *)fbid firstName:(NSString *)firstName lastName:(NSString *)lastName username:(NSString *)username{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@facebook/login",API_URL];
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:email forKey:@"email"];
    [request setPostValue:fbid forKey:@"facebook_id"];
    [request setPostValue:firstName forKey:@"first_name"];
    [request setPostValue:lastName forKey:@"last_name"];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:[defaults objectForKey:@"deviceToken"] forKey:@"deviceToken"];
    [request setDelegate:self];
    [request setTimeOutSeconds:10.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(loginWithFacebookFinished:)];
    [request setDidFailSelector:@selector(loginWithFacebookFailed:)];
    [request startAsynchronous];
}
- (void)loginWithFacebookFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *err = [[[NSDictionary alloc] initWithDictionary:[resJson objectForKey:@"error"]] autorelease];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];

    if ( [[err objectForKey:@"code"] intValue] == 0 ) {
        [self.delegate PFUserManager:self loginWithFacebookResponse:dict];
    } else {
        [self.delegate PFUserManager:self loginWithFacebookErrorResponse:[err objectForKey:@"message"]];
    }
    return;
}
- (void)loginWithFacebookFailed:(ASIHTTPRequest *)request{
    [self.delegate PFUserManager:self loginWithFacebookErrorResponse:[[request error] localizedDescription]];
}
#pragma mark - signup with username
- (void)signupWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password gender:(NSString *)gender dateOfBirth:(NSString *)dateOfBirth {
    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@register",API_URL];
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:email forKey:@"email"];
    [request setPostValue:password forKey:@"password"];
    [request setPostValue:dateOfBirth forKey:@"birth_date"];
    [request setPostValue:gender forKey:@"gender"];
    [request setDelegate:self];
    [request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(signupWithUsernameFinished:)];
    [request setDidFailSelector:@selector(signupWithUsernameFailed:)];
    [request startAsynchronous];
}
- (void)signupWithUsernameFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *err = [[[NSDictionary alloc] initWithDictionary:[resJson objectForKey:@"error"]] autorelease];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    if ( [[err objectForKey:@"code"] intValue] == 0 ) {
        if ([[err objectForKey:@"message"] isEqualToString:@"username duplicate"]) {
            [self.delegate PFUserManager:self signupWithUsernameErrorResponse:[err objectForKey:@"message"]];
        }  else if ([[err objectForKey:@"message"] isEqualToString:@"email duplicate"]) {
            [self.delegate PFUserManager:self signupWithUsernameErrorResponse:[err objectForKey:@"message"]];
        } else {
            [self.delegate PFUserManager:self signupWithUsernameResponse:dict];
        }
    } else {
        [self.delegate PFUserManager:self signupWithUsernameErrorResponse:[err objectForKey:@"message"]];
    }
    return;
}
- (void)signupWithUsernameFailed:(ASIHTTPRequest *)request{
    [self.delegate PFUserManager:self signupWithUsernameErrorResponse:[[request error] localizedDescription]];
}

- (void)getProfile {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFUserManager:self getProfileResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFUserManager:self getProfileErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getProfileById:(NSString *)uid {
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@",API_URL,uid]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFUserManager:self getProfileByIdResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFUserManager:self getProfileByIdErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)updateProfile:(NSString *)uid token:(NSString *)token email:(NSString *)email phone:(NSString *)phone {
    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@user/%@",API_URL,uid];
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:token];
    [request setRequestMethod:@"PUT"];
    [request setPostValue:email forKey:@"email_show"];
    [request setPostValue:phone forKey:@"phone_show"];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(updateProfileFinished:)];
    [request setDidFailSelector:@selector(updateProfileFailed:)];
    [request startAsynchronous];
}
- (void)updateProfileFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    [self.delegate PFUserManager:self updateProfileResponse:dict];
    return;
}
- (void)updateProfileFailed:(ASIHTTPRequest *)request{
    [self.delegate PFUserManager:self updateProfileErrorResponse:[[request error] localizedDescription]];
}
- (void)getSetting {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@/setting",API_URL,[defaults objectForKey:@"id"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFUserManager:self getSettingResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFUserManager:self getSettingErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)getNotifiy {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@notification",API_URL]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",url);
    NSLog(@"%@",[defaults objectForKey:@"token"]);
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[request responseString]];
        NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
        [self.delegate PFUserManager:self getNotifiyResponse:dict];
    }];
    [request setFailedBlock:^{
        [self.delegate PFUserManager:self getNotifiyErrorResponse:[[request error] localizedDescription]];
    }];
    [request startAsynchronous];
}
- (void)setPush:(NSString *)type onoff:(NSString *)onoff {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [[[NSString alloc] initWithFormat:@"%@user/%@/setting",API_URL,[defaults objectForKey:@"id"]]autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",[defaults objectForKey:@"token"]);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [request addRequestHeader:@"Content-type" value:@"application/x-www-form-urlencoded"];
    [request setRequestMethod:@"PUT"];
    [request setPostValue:onoff forKey:type];
    [request setUploadProgressDelegate:self];
    //[request appendPostData:body];
    //[request setPostBody:[NSMutableData dataWithData:requestData]];
    [request setDelegate:self];
    //[request setTimeOutSeconds:3.0];
    request.shouldAttemptPersistentConnection = NO;
    [request setDidFinishSelector:@selector(setPushFinished:)];
    [request setDidFailSelector:@selector(setPushFailed:)];
    [request startAsynchronous];
    
}
- (void)setPushFinished:(ASIHTTPRequest *)request
{
    SBJSON *loginResultJson = [[[SBJSON alloc]init] autorelease];
    id resJson = [loginResultJson objectWithString:[request responseString]];
    NSDictionary *dict = [[[NSDictionary alloc] initWithDictionary:resJson] autorelease];
    NSLog(@"%@",dict);
    return;
}
- (void)setPushFailed:(ASIHTTPRequest *)request{
    NSLog(@"%@",[[request error] localizedDescription]);
    //[self.delegate PFUserManager:self updateProfileErrorResponse:[[request error] localizedDescription]];
}
@end
