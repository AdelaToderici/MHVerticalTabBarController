//
//  MHAppDelegate.m
//  MHVerticalTabBarController
//
//  Created by Marshall Huss on 4/4/13.
//  Copyright (c) 2013 Marshall Huss. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MHAppDelegate.h"
#import "MHVerticalTabBarController.h"

@implementation MHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.tabBarItem.image = [UIImage imageNamed:@"tb-01"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tb-01"];

    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.tabBarItem.title = @"Starred";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tb-02"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tb-02"];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor purpleColor];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favorites"
                                                   image:[UIImage imageNamed:@"tb-03"]
                                                     tag:0];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tb-03"];

    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor blueColor];
    vc4.title = @"Settings";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tb-04"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tb-04"];

    self.tabBarController = [[MHVerticalTabBarController alloc] init];
    self.tabBarController.viewControllers = @[vc1, vc2, vc3, vc4];
    
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
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
//    UIView *selectedBackgroundView = self.tabBarController.tabBar.selectedBackgroundView;
//    selectedBackgroundView.backgroundColor = [UIColor clearColor];
//    CGRect rect =
//    CGRectMake(10,
//               10,
//               10,
//               10);
//    UIView *roundedView = [[UIView alloc] initWithFrame:selectedBackgroundView.bounds];
//    roundedView.frame = CGRectInset(roundedView.frame, 10, 10);
//    roundedView.backgroundColor = [UIColor redColor];
//    roundedView.layer.cornerRadius = 4.0;
//    [selectedBackgroundView addSubview:roundedView];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
