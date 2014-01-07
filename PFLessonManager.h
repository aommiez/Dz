//
//  PFLessonManager.h
//  DanceZone
//
//  Created by aOmMiez on 9/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@protocol PFLessonManagerDelegate <NSObject>
- (void)PFLessonManager:(id)sender getChapterlistByLessonIdResponse:(NSDictionary *)response;
- (void)PFLessonManager:(id)sender getChapterlistByLessonIdErrorResponse:(NSString *)errorResponse;
- (void)PFLessonManager:(id)sender getLessonResponse:(NSDictionary *)response;
- (void)PFLessonManager:(id)sender getLessonErrorResponse:(NSString *)errorResponse;
- (void)PFLessonManager:(id)sender getVideolistByChapterIdResponse:(NSDictionary *)response;
- (void)PFLessonManager:(id)sender getVideolistByChapterIdErrorResponse:(NSString *)errorResponse;
- (void)PFLessonManager:(id)sender registerLessonResponse:(NSDictionary *)response;
- (void)PFLessonManager:(id)sender registerLessonErrorResponse:(NSString *)errorResponse;
@end

@interface PFLessonManager : NSObject
@property (assign, nonatomic) id delegate;
- (void)getLesson;
- (void)getChapterlistByLessonId:(NSString *)lessonId;
- (void)getVideolistByChapterId:(NSString *)chapterId lessonId:(NSString *)lessonId;
- (void)registerLesson:(NSString *)email phone:(NSString *)phone name:(NSString *)name;
@end
