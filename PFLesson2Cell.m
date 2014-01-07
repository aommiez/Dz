//
//  PFLesson2Cell.m
//  DanceZone
//
//  Created by aOmMiez on 9/5/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFLesson2Cell.h"

@implementation PFLesson2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_videoDes release];
    [_nameLabel release];
    [_imgView release];
    [_downloadBut release];
    [_delFile release];
    [_progressView release];
    [_lockImg release];
    [super dealloc];
}

- (IBAction)downloadFile:(id)sender {
    NSString *videoId = [[NSString alloc] initWithFormat:@"http://61.19.147.72/api/video/%ld.mp4",(long)self.downloadBut.tag];
    NSURL *url = [NSURL URLWithString:videoId];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDownloadProgressDelegate:self];
    [request setCompletionBlock:^{
        self.downloadBut.alpha = 0;
        // Use when fetching binary data
        NSData *responseData = [request responseData];
        NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
        NSString *nameId = [[NSString alloc] initWithFormat:@"%ld.mp4",(long)self.downloadBut.tag];
        NSString *filePath = [resourceDocPath stringByAppendingPathComponent:nameId];
        [responseData writeToFile:filePath atomically:YES];
        self.downloadBut.alpha = 0;
        self.delFile.alpha = 1;
    }];
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [request startAsynchronous];
}
- (IBAction)delFileTapped:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    NSString *nameId = [[NSString alloc] initWithFormat:@"%ld.mp4",(long)self.downloadBut.tag];
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:nameId];
    [fileManager removeItemAtPath:filePath error:nil];
    self.downloadBut.alpha = 1;
    self.delFile.alpha = 0;
}
- (void)setProgress:(float)progress
{
    [self.progressView setProgress:progress];
}
@end
