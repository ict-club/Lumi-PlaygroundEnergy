//
//  AppDelegate.m
//  Lumi-iOS
//
//  Created by Martin Kuvandzhiev on 5/17/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

@import Firebase;
@import FirebaseAnalytics;

#import "AppDelegate.h"
#import "UIColor+Lumi.h"
#import "Firebase.h"
#import <Google/Analytics.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>



/** Google Analytics configuration constants **/
static NSString *const kGaPropertyId = @"UA-85432288-1"; // Placeholder property ID.
static NSString *const kTrackingPreferenceKey = @"allowTracking";




@interface AppDelegate ()
@property (strong, nonatomic) id<GAITracker> tracker;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor LumiPinkColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    
    [Fabric with:@[[Crashlytics class]]];
    [self setUpRechability];
    
    // Configure tracker from GoogleService-Info.plist.
    [FIRApp configure];
    
    return YES;
}

-(void) setUpRechability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if       (remoteHostStatus == NotReachable) {
        self.hasInternet=NO;
    }
    else if (remoteHostStatus == ReachableViaWiFi || remoteHostStatus == ReachableViaWWAN) {
        self.hasInternet=YES;
    }
    
    
    [self setInternetData];
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if      (remoteHostStatus == NotReachable) {
        self.hasInternet=NO;
    }
    else if (remoteHostStatus == ReachableViaWiFi || remoteHostStatus == ReachableViaWWAN) {
        self.hasInternet=YES;
    }
    
    [self setInternetData];
}

- (void) setInternetData {
    RDInternetData* internetData = [RDInternetData sharedInstance];
    internetData.hasInternet = self.hasInternet;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.ю[GAI sharedInstance].optOut =
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kTrackingPreferenceKey];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
