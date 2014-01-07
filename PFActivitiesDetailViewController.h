//
//  PFActivitiesDetailViewController.h
//  DanceZone
//
//  Created by aOmMiez on 8/31/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "PFActivitiesManager.h"
#import "AsyncImageView.h"
#import "PFNewsCommentCell.h"
#import "PFDzApi.h"
#import "PFAccountViewController.h"
@protocol PFActivitiesDetailViewControllerDelegate <NSObject>
- (void)PFActivitiesDetailViewControllerPhoto:(NSString *)link;
- (void)PFActivitiesDetailViewControllerBack;
@end

@interface PFActivitiesDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,PFAccountViewControllerDelegate,PFNewsCommentCellDelegate>
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) NSString *viewValue;
@property (retain, nonatomic) IBOutlet UIView *footTableView;
@property (retain, nonatomic) NSDictionary *obj;
@property (assign, nonatomic) id<PFActivitiesDetailViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIImageView *actImg;
@property (retain, nonatomic) IBOutlet UILabel *actName;

@property (retain, nonatomic) IBOutlet UITextView *actMessage;

@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@property (retain, nonatomic) IBOutlet UIButton *joinBut;

- (IBAction)joinTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *w;
@property (retain, nonatomic) IBOutlet AsyncImageView *cImg;
@property (retain, nonatomic) NSString *paging;
@property (retain, nonatomic) NSMutableArray *arrObj;
@property (retain, nonatomic) NSString *prevString;
@property (retain, nonatomic) IBOutlet UIView *textCommentView;
@property (retain, nonatomic) IBOutlet UITextView *textComment;
@property (retain, nonatomic) IBOutlet UIButton *postBut;
- (IBAction)postCommentTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *footContentView;

@end
