//
//  PFAccountSettingViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/17/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "PFUserManager.h"
#import <FacebookSDK/FacebookSDK.h>
#import "GKImagePicker.h"

@protocol PFAccountSettingViewControllerDelegate <NSObject>
- (void)PFAccountSettingViewControllerBackTapped:(id)sender;
- (void)PFAccountSettingViewControllerPhoto:(NSString *)link;
@end

@interface PFAccountSettingViewController : UIViewController <GKImagePickerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *formSetting;
- (IBAction)backTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *navBg;
@property (retain, nonatomic) IBOutlet UILabel *DownloadSize;
@property (retain, nonatomic) IBOutlet UILabel *ReceiveBytes;
@property (retain, nonatomic) IBOutlet UIImageView *profileImg;
@property (nonatomic) CGFloat currentLength;
- (IBAction)uploadPicProfileTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIProgressView *progressView;
@property (retain, nonatomic) IBOutlet UITextField *facebookTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;
- (IBAction)bgTappe:(id)sender;
//- (IBAction)updateProfileTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *navTitle;
@property (retain, nonatomic) IBOutlet UIView *waitView;
- (IBAction)logoutTapped:(id)sender;
@property (assign, nonatomic) id<PFAccountSettingViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UISwitch *pushNews;
@property (retain, nonatomic) IBOutlet UISwitch *pushShowcase;
@property (retain, nonatomic) IBOutlet UISwitch *pushLesson;
@property (retain, nonatomic) IBOutlet UISwitch *pushDancezone;

- (IBAction)newsChanged:(id)sender;
- (IBAction)showcaseChanged:(id)sender;
- (IBAction)dancezoneChanged:(id)sender;

- (IBAction)lessonChanged:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *wv;

- (IBAction)editTapped:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *editBut;
@property (retain, nonatomic) NSString *imgLink;
@property (nonatomic, strong) GKImagePicker *imagePicker;

@property (nonatomic, strong) UIImagePickerController *ctr;

- (IBAction)clearCacheTapped:(id)sender;



@end
