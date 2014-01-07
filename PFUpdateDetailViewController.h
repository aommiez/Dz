//
//  PFUpdateDetailViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/25/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNewsManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PFNewsCommentCell.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "HPGrowingTextView.h"
#import "PFAccountViewController.h"
#import <Social/Social.h>
#import "AsyncImageView.h"
#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PFDzApi.h"

@protocol PFUpdateDetailViewControllerDelegate <NSObject>

- (void)PFUpdateDetailViewControllerBackTapped:(id)sender;
- (void)PFUpdateDetailViewControllerPhoto:(NSString *)link;
@end
@interface PFUpdateDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PFNewsCommentCellDelegate,UIScrollViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,PFAccountViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;
@property (retain, nonatomic) NSString *newsId;
@property (retain, nonatomic) IBOutlet UILabel *likeLabel;
@property (retain, nonatomic) NSDictionary *newsObj;
@property (nonatomic, retain) IBOutlet AsyncImageView *myImageView;
@property (retain, nonatomic) IBOutlet UIImageView *newsImg;
@property (retain, nonatomic) IBOutlet UILabel *msgLabel;
@property (retain, nonatomic) IBOutlet UIView *likeCommentShareView;
@property (retain, nonatomic) IBOutlet UIButton *playVideoButton;
@property (retain, nonatomic)  MPMoviePlayerController *moviePlayerController;
- (IBAction)playVideo:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *pubDate;
@property (retain, nonatomic) IBOutlet UITextField *commentTextView;
@property (retain, nonatomic) NSDictionary *commentDict;
- (IBAction)commentTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *commentTextFieldView;
@property (retain, nonatomic) IBOutlet UIButton *commentBut;
@property (retain, nonatomic) IBOutlet UIButton *likeBut;
@property (retain, nonatomic) UIImage *saveImg;
- (IBAction)postCommentTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *realCommentBut;

@property (retain, nonatomic) IBOutlet UIButton *realLikeBut;
@property (retain, nonatomic) IBOutlet UIButton *shareBut;
@property (retain, nonatomic) IBOutlet UIButton *realShareBut;
@property (retain, nonatomic) HPGrowingTextView *textView;
- (IBAction)likeTapped:(id)sender;
- (IBAction)shareTapped:(id)sender;
- (IBAction)closeComment:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *footTablewView;
@property (retain, nonatomic) IBOutlet UIButton *commentDownTapped;
@property (assign, nonatomic) id<PFUpdateDetailViewControllerDelegate> delegate;
@property (retain, nonatomic) AsyncImageView *fullPhotoView;
@property (retain, nonatomic) UIImageView *fullPhoto;
- (IBAction)imgTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *textCommentView;
@property (retain, nonatomic) IBOutlet UITextView *textComment;

@property (retain, nonatomic) IBOutlet UIButton *myImageBut;

@property (retain, nonatomic) IBOutlet UIView *overlayView;

- (IBAction)bgTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *postBut;
@property (retain, nonatomic) UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (atomic, strong) ALAssetsLibrary *assetLibrary;
@property (atomic, strong) NSMutableArray *assets;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) NSString *paging;
@property (retain, nonatomic) NSMutableArray *arrObj;
@property (retain, nonatomic) NSString *prevString;
@end

