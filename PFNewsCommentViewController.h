//
//  PFNewsCommentViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/27/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNewsManager.h"
#import "PFNewsCommentCell.h"
#import "PFAccountViewController.h"
#import "HPGrowingTextView.h"
#import "PFDzApi.h"
@protocol PFNewsCommentViewControllerDelegate <NSObject>

- (void)PFNewsCommentViewControllerBackTapped:(id)sender;
- (void)PFNewsCommentViewControllerPhoto:(NSString *)link;
@end


@interface PFNewsCommentViewController : UIViewController<PFNewsCommentCellDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,PFAccountViewControllerDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSString *newsId;
@property (retain, nonatomic) NSDictionary *commentDict;
@property (retain, nonatomic) IBOutlet UIButton *commentDownTapped;
@property (retain, nonatomic) IBOutlet UIView *commentTextFieldView;
@property (retain, nonatomic) HPGrowingTextView *textView;
- (IBAction)commentTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *footTablewView;
- (IBAction)closeComment:(id)sender;
- (IBAction)postCommentTapped:(id)sender;
@property (assign, nonatomic) id<PFNewsCommentViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIView *textCommentView;
@property (retain, nonatomic) IBOutlet UITextView *textComment;
@property (retain, nonatomic) IBOutlet UILabel *loadLabel;
@property (retain, nonatomic) NSString *paging;
- (IBAction)bgTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *postBut;
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (retain, nonatomic) NSMutableArray *arrObj;
@end
