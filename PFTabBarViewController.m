//
//  PFTabBarViewController.m
//  DanceZone
//
//  Created by aOmMiez on 8/26/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFTabBarViewController.h"

@interface PFTabBarViewController ()
- (void)initTabBarViewController;
@end

@implementation PFTabBarViewController

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

    [self initTabBarViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [_tabBarViewController release];

    [super dealloc];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - private
- (void)initTabBarViewController{
    
    if(IS_WIDESCREEN){
        self.pfUpdateViewController = [[[PFUpdateViewController alloc] initWithNibName:@"PFUpdateViewController_Wide" bundle:nil] autorelease];
        self.pfShowCaseViewController = [[[PFShowCaseViewController alloc] initWithNibName:@"PFShowCaseViewController_Wide" bundle:nil] autorelease];
        self.pfLessonViewController = [[[PFLessonViewController alloc] initWithNibName:@"PFLessonViewController_Wide" bundle:nil] autorelease];
        self.pfJoisUsViewController = [[[PFJoisUsViewController alloc] initWithNibName:@"PFJoisUsViewController_Wide" bundle:nil] autorelease];
        //self.pfJoinViewController = [[PFJoinViewController alloc] initWithNibName:@"PFJoinViewController_Wide" bundle:nil];
    }else{
        self.pfUpdateViewController = [[[PFUpdateViewController alloc] initWithNibName:@"PFUpdateViewController" bundle:nil] autorelease];
        self.pfShowCaseViewController = [[[PFShowCaseViewController alloc] initWithNibName:@"PFShowCaseViewController" bundle:nil] autorelease];
        self.pfLessonViewController = [[[PFLessonViewController alloc] initWithNibName:@"PFLessonViewController" bundle:nil] autorelease];
        self.pfJoisUsViewController = [[[PFJoisUsViewController alloc] initWithNibName:@"PFJoisUsViewController" bundle:nil] autorelease];
    }
    //PFtestPhotoViewController *test =[[PFtestPhotoViewController alloc] init];
    // 2) init TabBarViewController

      self.tabBarViewController = [[[EFTabBarViewController alloc] initWithBackgroundImage:nil viewControllers:self.pfUpdateViewController,self.pfShowCaseViewController,self.pfLessonViewController,self.pfJoisUsViewController,nil] autorelease];
    
    
    self.pfUpdateViewController.tabbarViewController = self;
    self.pfJoisUsViewController.tabbarViewController = self;
    self.pfShowCaseViewController.tabbarViewController = self;
    
    // 3) set images for barItemButton
    if (IS_WIDESCREEN) {
        EFTabBarItemButton *item0 = [self.tabBarViewController.itemButtons objectAtIndex:0];
        [item0 setHighlightedImage:[UIImage imageNamed:@"UpdateBottonOnIp4"]];
        [item0 setStanbyImage:[UIImage imageNamed:@"UpdateBottonIp4"]];
        
        
        EFTabBarItemButton *item1 = [self.tabBarViewController.itemButtons objectAtIndex:1];
        [item1 setHighlightedImage:[UIImage imageNamed:@"ShowCaseBottonOnIp5"]];
        [item1 setStanbyImage:[UIImage imageNamed:@"ShowCaseBottonIp4"]];
        
        
        EFTabBarItemButton *item2 = [self.tabBarViewController.itemButtons objectAtIndex:2];
        [item2 setHighlightedImage:[UIImage imageNamed:@"LessonBottonOnIp4"]];
        [item2 setStanbyImage:[UIImage imageNamed:@"LessonBottonIp4"]];
        
        
        
        EFTabBarItemButton *item3 = [self.tabBarViewController.itemButtons objectAtIndex:3];
        [item3 setHighlightedImage:[UIImage imageNamed:@"JoinUsBottonOnIp4"]];
        [item3 setStanbyImage:[UIImage imageNamed:@"JoinUsBottonIp4"]];
    } else {
        EFTabBarItemButton *item0 = [self.tabBarViewController.itemButtons objectAtIndex:0];
        [item0 setHighlightedImage:[UIImage imageNamed:@"UpdateBottonOnIp4"]];
        [item0 setStanbyImage:[UIImage imageNamed:@"UpdateBottonIp4"]];
        
        
        EFTabBarItemButton *item1 = [self.tabBarViewController.itemButtons objectAtIndex:1];
        [item1 setHighlightedImage:[UIImage imageNamed:@"ShowCaseBottonOnIp5"]];
        [item1 setStanbyImage:[UIImage imageNamed:@"ShowCaseBottonIp5.png"]];
        
        
        EFTabBarItemButton *item2 = [self.tabBarViewController.itemButtons objectAtIndex:2];
        [item2 setHighlightedImage:[UIImage imageNamed:@"LessonBottonOnIp5.png"]];
        [item2 setStanbyImage:[UIImage imageNamed:@"LessonBottonIp5.png"]];
        
        
        
        EFTabBarItemButton *item3 = [self.tabBarViewController.itemButtons objectAtIndex:3];
        [item3 setHighlightedImage:[UIImage imageNamed:@"JoinUsBottonOnIp5.png"]];
        [item3 setStanbyImage:[UIImage imageNamed:@"JoinUsBottonIp5.png"]];
        
      
    }
    

    
    // 4) define the default selected index
    [self.tabBarViewController setSelectedIndex:0];
    
    [self.view addSubview:_tabBarViewController.view];
    //[self.tabBarViewController hideTabBarWithAnimation:NO];
    //[self presentViewController:self.tabBarViewController animated:YES completion:nil];

}
- (void)hideTabBar {
    [self.tabBarViewController hideTabBarWithAnimation:YES];
}
- (void)showTabBar {
    [self.tabBarViewController showTabBarWithAnimation:YES];
}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %i", index);
}
- (IBAction)tapped:(id)sender {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.zoomPhotosToFill = YES;
    [browser setCurrentPhotoIndex:0];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:nc animated:YES];
}
- (void)showPhoto:(NSString *)link {
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:link]]];

    self.photos = photos;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.zoomPhotosToFill = YES;
    [browser setCurrentPhotoIndex:0];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:nc animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}
@end
