//
//  PFJoinViewController.m
//  DanceZone
//
//  Created by aOmMiez on 10/5/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFJoinViewController.h"

@interface PFJoinViewController ()

@end

@implementation PFJoinViewController

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
    // Do any additional setup after loading the view from its nib.
    AMBlurView *backgroundView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navController.navigationBar.frame), 64)];
    [backgroundView setBlurTintColor:[UIColor colorWithRed:255/255.0 green:168/255.0 blue:0/255.0 alpha:1]];
    
    [self.navController.view insertSubview:backgroundView belowSubview:self.navController.navigationBar];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    [myLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [myLabel setTextColor:[UIColor whiteColor]];
    [myLabel setText:@"Join Us"];
    [self.NavItem setTitleView:myLabel];
    //self.navController.navigationBar.translucent = NO;
    self.tableView.tableHeaderView = self.detailView;
    [self.view addSubview:self.navController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)activitiesTapped:(id)sender {
    if (IS_WIDESCREEN) {
        PFActivitiesViewController *activitiesViewController = [[PFActivitiesViewController alloc] initWithNibName:@"PFActivitiesViewController_Wide" bundle:nil];
        [self.navController pushViewController:activitiesViewController animated:YES];
    } else {
        PFActivitiesViewController *activitiesViewController = [[PFActivitiesViewController alloc] initWithNibName:@"PFActivitiesViewController" bundle:nil];
        [self.navController pushViewController:activitiesViewController animated:YES];
    }
}
@end
