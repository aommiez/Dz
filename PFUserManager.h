//
//  PFUserManager.h
//  DanceZone
//
//  Created by aOmMiez on 9/20/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@protocol PFUserManagerDelegate <NSObject>
- (void)PFUserManager:(id)sender updateProfileResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender updateProfileErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender getProfileByIdResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender getProfileByIdErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender getProfileResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender getProfileErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender signupWithUsernameResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender signupWithUsernameErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender loginWithEmailResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender loginWithEmailErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender loginWithFacebookResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender loginWithFacebookErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender getSettingResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender getSettingErrorResponse:(NSString *)errorResponse;
- (void)PFUserManager:(id)sender getNotifiyResponse:(NSDictionary *)response;
- (void)PFUserManager:(id)sender getNotifiyErrorResponse:(NSString *)errorResponse;
@end

@interface PFUserManager : NSObject

@property (assign, nonatomic) id delegate;
- (void)updateProfile:(NSString *)uid token:(NSString *)token email:(NSString *)email phone:(NSString *)phone;
- (void)getProfile;
- (void)getProfileById:(NSString *)uid;
- (void)signupWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password gender:(NSString *)gender dateOfBirth:(NSString *)dateOfBirth;
- (void)loginWithEmail:(NSString *)email Password:(NSString *)password;
- (void)loginWithFacebook:(NSString *)email fbid:(NSString *)fbid firstName:(NSString *)firstName lastName:(NSString *)lastName username:(NSString *)username;
- (void)getSetting;
- (void)getNotifiy;
- (void)setPush:(NSString *)type onoff:(NSString *)onoff;

@end
