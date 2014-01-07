//
//  PFAboutWebViewController.h
//  DanceZone
//
//  Created by aOmMiez on 9/25/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PFAboutWebViewController : UIViewController<UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *webUrl;
@property (retain, nonatomic) NSString *navTitleText;
@property (retain, nonatomic) IBOutlet UILabel *navTitle;

@property (retain, nonatomic) IBOutlet UIView *loadingView;

@end
