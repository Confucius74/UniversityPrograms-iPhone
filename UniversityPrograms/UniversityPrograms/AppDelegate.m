//
//  AppDelegate.m
//  UniversityPrograms
//
//  Created by Miles Crabbe on 5/29/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

#import "AppDelegate.h"
#import "UpcomingEventViewController.h"
#import "MyUPViewController.h"
#import "AboutUPViewController.h"
#import "UPNavigationViewController.h"
#import "Colours.h"
#import "UIColor+UPColors.h"
#import "ContactUPViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //load default values on first load
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLoad"]){
        
        [UIColor setThemeColor:[UIColor grassColor]];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"colorSelection"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    //create the tab bar and set it to be the main view controller
    [UIColor setThemeColor:[UIColor getThemeColor]];
    
    
    //create the view controllers
    UpcomingEventViewController *upcoming = [[UpcomingEventViewController alloc] init];
    AboutUPViewController *aboutUP = [[AboutUPViewController alloc] init];
    MyUPViewController *myUP = [[MyUPViewController alloc]init];
    ContactUPViewController *contactUP = [[ContactUPViewController alloc] init];
    
    //create navcontrollers
    UPNavigationViewController *upcomingNav = [[UPNavigationViewController alloc] initWithRootViewController:upcoming];
    UPNavigationViewController *aboutUPNav = [[UPNavigationViewController alloc] initWithRootViewController:aboutUP];
    UPNavigationViewController *myUPNav = [[UPNavigationViewController alloc] initWithRootViewController:myUP];
    UPNavigationViewController *contactUPNav = [[UPNavigationViewController alloc] initWithRootViewController:contactUP];
    
    //Init tab bar and appearance
    self.baseTabBarController = [[UPTabbarViewController alloc]init];
    self.baseTabBarController.tabBar.translucent = NO;
    self.baseTabBarController.tabBar.tintColor = [UIColor getThemeColor];
    
    
    //check for darkmode
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"darkMode"]){
        self.baseTabBarController.tabBar.barStyle = UIBarStyleBlackOpaque;
    }
    else{
        self.baseTabBarController.tabBar.barStyle = UIBarStyleDefault;
    }
    
    [self.baseTabBarController setViewControllers:@[upcomingNav, aboutUPNav, contactUPNav, myUPNav]];
    [self.window setRootViewController:self.baseTabBarController];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLoad"]){
        [self.baseTabBarController buildIntroView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLoad"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
