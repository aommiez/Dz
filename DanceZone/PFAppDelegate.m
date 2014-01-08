//
//  PFAppDelegate.m
//  DanceZone
//
//  Created by aOmMiez on 8/22/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import "PFAppDelegate.h"
#import "iRate.h"
@implementation PFAppDelegate
+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iRate sharedInstance].applicationBundleID = @"com.DanceZone";
	[iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    //enable preview mode
    [iRate sharedInstance].previewMode = NO;
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SWIZZ_IT;
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    if (IS_WIDESCREEN) {
        self.viewController = [[PFIndexViewController alloc] initWithNibName:@"PFIndexViewController_Wide" bundle:nil] ;
    } else {
        self.viewController = [[PFIndexViewController alloc] initWithNibName:@"PFIndexViewController" bundle:nil] ;
    }
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    self.viewController.delegate = self;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [FBLoginView class];
    
    return YES;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceToken forKey:@"deviceToken"];
    [defaults synchronize];
    
    NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return (UIInterfaceOrientationMaskAll);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)PFIndexViewController:(id)sender loginSuccess:(NSDictionary *)res {
    if (IS_WIDESCREEN) {
        self.tabBarViewController = [[PFTabBarViewController alloc] initWithNibName:@"PFTabBarViewController_Wide" bundle:nil];
    } else {
        self.tabBarViewController = [[PFTabBarViewController alloc] initWithNibName:@"PFTabBarViewController" bundle:nil];
    }
    self.window.rootViewController = self.tabBarViewController;
}
- (void)logout {
    NSLog(@"logout");
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //NSLog(@"%@",userInfo);
    NSUserDefaults *nt = [NSUserDefaults standardUserDefaults];
    [nt setObject:@"1" forKey:@"objId"];
    [nt setObject:@"message" forKey:@"type"];
    [nt setObject:@"YES" forKey:@"ss"];
    [nt synchronize];
    PFNotificationViewController *notificationView = [[PFNotificationViewController alloc] init];
    [notificationView PFNotificationViewController:self obj:userInfo];
}
@end
