//
//  PFUpdateCell.m
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFUpdateCell.h"
#import "PFAppDelegate.h"

@implementation PFUpdateCell

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
    [_detailView release];
    [_newsImg release];
    [_newsTitle release];
    [_likeLabel release];
    [_commentLabel release];
    [_likeButton release];
    [_pubDate release];
    [_commentBut release];
    [_shareBut release];
    [_imgBut release];
    [_overlayView release];
    [super dealloc];
}
- (IBAction)commentTapped:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.commentBut.highlighted = YES;
    }];
    //[self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    NSString *newsId = [[NSString alloc] initWithFormat:@"%ld",(long)self.shareBut.tag];
    [self.delegate commentView:newsId];
}

- (IBAction)shareTapped:(id)sender {
    /*
    PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    newsManager.delegate = self;
    NSString *newsId = [[NSString alloc] initWithFormat:@"%ld",(long)self.shareBut.tag];
    [newsManager getNewsById:newsId];
     */
    [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    NSString *newsId = [[NSString alloc] initWithFormat:@"%ld",(long)self.shareBut.tag];
    PFDzApi *dzApi = [[PFDzApi alloc] init];
    dzApi.delegate = self;
    [dzApi DzApiObject:newsId];
}

- (IBAction)likeTapped:(id)sender {
    [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    /*
    NSLog(@"tappp %ld",(long)self.likeButton.tag);
    self.overlayView.alpha = 1;
    PFNewsManager *newsManager = [[PFNewsManager alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *newsIdStr =[[NSString alloc] initWithFormat:@"%ld",(long)self.likeButton.tag];
    NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@news/%@?fields=like,comment",API_URL,newsIdStr]autorelease];
    NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
    __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
    [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [requestLikeComment setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
        if ( [[[resJson objectForKey:@"like"] objectForKey:@"is_liked"] intValue] == 1 ) {
            [newsManager unLikeNewsId:[defaults objectForKey:@"token"] newsId:newsIdStr];
            [self.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonIp5"] forState:UIControlStateNormal];
            int likeCount = [[self.likeLabel.text substringToIndex:2]intValue]-1;
            self.likeLabel.text = [[NSString alloc]initWithFormat:@"%d Likes",likeCount];
        } else {
            [newsManager likeNewsId:[defaults objectForKey:@"token"] newsId:newsIdStr];
            [self.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5"] forState:UIControlStateNormal];
            int likeCount = [[self.likeLabel.text substringToIndex:2]intValue]+1;
            self.likeLabel.text = [[NSString alloc]initWithFormat:@"%d Likes",likeCount];
        }
        self.overlayView.alpha = 0;
    }];
    [requestLikeComment setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [requestLikeComment startAsynchronous];
     */

    self.overlayView.alpha = 1;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *newsIdStr =[[NSString alloc] initWithFormat:@"%ld",(long)self.likeButton.tag];
    NSString *urlStrLikeComment = [[[NSString alloc] initWithFormat:@"%@dz_object/%@/like",API_URL,newsIdStr]autorelease];
    NSLog(@"%@",urlStrLikeComment);
    NSURL *urlLikeComment = [NSURL URLWithString:urlStrLikeComment];
    __block ASIHTTPRequest *requestLikeComment = [ASIHTTPRequest requestWithURL:urlLikeComment];
    [requestLikeComment addRequestHeader:@"X-Auth-Token" value:[defaults objectForKey:@"token"]];
    [requestLikeComment setCompletionBlock:^{
        SBJSON *resultJson = [[[SBJSON alloc]init] autorelease];
        id resJson = [resultJson objectWithString:[requestLikeComment responseString]];
        NSLog(@"%@",resJson);
        PFDzApi *dzApi = [[PFDzApi alloc] init];
        if ( [[resJson objectForKey:@"is_liked"] intValue] == 1 ) {
            //[newsManager unLikeNewsId:[defaults objectForKey:@"token"] newsId:newsIdStr];
            [dzApi DzApiUnLikeObject:newsIdStr];
            [self.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonIp5"] forState:UIControlStateNormal];
            int likeCount = [[self.likeLabel.text substringToIndex:2]intValue]-1;
            self.likeLabel.text = [[NSString alloc]initWithFormat:@"%d Likes",likeCount];
        } else {
            //[newsManager likeNewsId:[defaults objectForKey:@"token"] newsId:newsIdStr];
            [dzApi DzApiLikeObject:newsIdStr];
            [self.likeButton setBackgroundImage:[UIImage imageNamed:@"LikeBottonOnIp5"] forState:UIControlStateNormal];
            int likeCount = [[self.likeLabel.text substringToIndex:2]intValue]+1;
            self.likeLabel.text = [[NSString alloc]initWithFormat:@"%d Likes",likeCount];
        }
        [sender setHighlighted:NO];
        self.overlayView.alpha = 0;
    }];
    [requestLikeComment setFailedBlock:^{
        //NSError *error = [request error];
    }];
    [requestLikeComment startAsynchronous];
}

- (IBAction)imgTapped:(id)sender {
    //NSString *newsIdStr =[[NSString alloc] initWithFormat:@"%ld",(long)self.imgBut.tag];
    //[self.delegate imgTapped:newsIdStr];
    
}
- (void)PFNewsManager:(id)sender getNewsByIdResponse:(NSDictionary *)response {
    [self.delegate shareFb:response];
}
- (void)PFNewsManager:(id)sender getNewsByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (void)PFDzApi:(id)sender DzApiObjectResponse:(NSDictionary *)response {
    self.shareBut.highlighted = NO;
    [self.delegate shareFb:response];
    NSLog(@"%@",response);
}
- (void)PFDzApi:(id)sender DzApiObjectErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}
- (void)doHighlight:(UIButton*)b {
    
    [b setHighlighted:YES];
}
@end
