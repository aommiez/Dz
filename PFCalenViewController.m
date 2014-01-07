//
//  PFCalenViewController.m
//  DanceZone
//
//  Created by MRG on 11/6/2556 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFCalenViewController.h"

@interface PFCalenViewController ()

@end

@implementation PFCalenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Calendar"];
    [self.navigationItem setTitleView:myLabel];
    // Do any additional setup after loading the view from its nib.
    [self performSelector:@selector(CalenLoading) withObject:self afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)CalenLoading {
    PFCalendarViewController *calendarViewController = [[PFCalendarViewController alloc] initWithSunday:YES timeZone:[NSTimeZone timeZoneWithName:@"Asia/Bangkok"]];
    calendarViewController.delegate = self;
    [self.navigationController pushViewController:calendarViewController animated:NO];
}
- (void)PFCalendarViewControllerBack {
    //[self.navigationController popViewControllerAnimated:NO];
}
@end
