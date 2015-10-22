//
//  AppDelegate.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 15/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "AppDelegate.h"
#import "HotmobManager.h"

@interface AppDelegate () <HotmobManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     start the debug mode
     **This must be inplement bacause this function is start the hotmob SDK service right now.
     */
    [HotmobManager setDebug:NO];
    
    /*
     create the pop when launch the application
     adCode "launch"                                , the identifier let hotmob  know the banner position
     identifier "hotmob_uat_iphone_launch_popup"    , the identifier let hotmob sdk to reuse banner object
     showWhenResume                                 , set the popup when auto reload when resume app from background
     */
    [HotmobManager getPopup:nil delegate:self identifier:@"launch" adCode:@"hotmob_uat_iphone_launch_popup" showWhenResume:YES autoRefresh:YES];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - HotmobManagerDelegate

- (void)didLoadBanner:(id)obj
{
    NSLog(@"AppDelegate didLoadBanner: %@", obj);
}

- (void)willShowBanner:(id)obj
{
    NSLog(@"AppDelegate willShowBanner: %@", obj);
}

- (void)didShowBanner:(id)obj
{
    NSLog(@"AppDelegate didShowBanner: %@", obj);
}

- (void)willHideBanner:(id)obj
{
    NSLog(@"AppDelegate willHideBanner: %@", obj);
}

- (void)didHideBanner:(id)obj
{
    NSLog(@"AppDelegate didHideBanner: %@", obj);
}

- (void)didLoadFailed:(id)obj
{
    NSLog(@"AppDelegate didLoadFailed: %@", obj);
}

- (void)didClick:(id)obj
{
    NSLog(@"AppDelegate didClick: %@", obj);
}

- (void)openNoAdCallback:(id)obj
{
    NSLog(@"AppDelegate openNoAdCallback: %@", obj);
}

- (void)openInternalCallback:(id)obj
{
    NSLog(@"AppDelegate openInternalCallback: %@", obj);
}

- (void)willShowInAppBrowser:(id)obj
{
    NSLog(@"AppDelegate willShowInAppBrowser: %@", obj);
}

- (void)didShowInAppBrowser:(id)obj
{
    NSLog(@"AppDelegate didShowInAppBrowser: %@", obj);
}

- (void)willCloseInAppBrowser:(id)obj
{
    NSLog(@"AppDelegate willCloseInAppBrowser: %@", obj);
}

- (void)didCloseInAppBrowser:(id)obj
{
    NSLog(@"AppDelegate didCloseInAppBrowser: %@", obj);
}

@end
