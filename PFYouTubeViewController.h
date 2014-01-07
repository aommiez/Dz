//
//  PFYouTubeViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/2/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNewsCommentCell.h"
#import "PFDzApi.h"
#import "PFAccountViewController.h"
@protocol PFYouTubeViewControllerDelegate <NSObject>

- (void)PFYouTubeViewControllerBackTapped:(id)sender;
- (void)PFYouTubeViewControllerPhoto:(NSString *)link;
@end


@interface PFYouTubeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UITextViewDelegate,PFAccountViewControllerDelegate,PFNewsCommentCellDelegate>

@property (assign, nonatomic) id<PFYouTubeViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) NSString *youtubeId;
@property (retain, nonatomic) NSDictionary *youtubeObj;
@property (retain, nonatomic) IBOutlet UILabel *viewLabel;
@property (retain, nonatomic) IBOutlet UILabel *likeLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *desTextView;
@property (retain, nonatomic) IBOutlet UILabel *dateUploadLabel;
@property (retain, nonatomic) NSString *paging;
@property (retain, nonatomic) NSMutableArray *arrObj;
@property (retain, nonatomic) NSString *prevString;
@property (retain, nonatomic) IBOutlet UIView *textCommentView;
@property (retain, nonatomic) IBOutlet UITextView *textComment;
@property (retain, nonatomic) IBOutlet UIButton *postBut;
- (IBAction)postCommentTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *w;

@end
