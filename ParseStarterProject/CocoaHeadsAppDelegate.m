//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#define NAVEGACAO_TEMPO_ANIMACAO 0.5f

#import <Parse/Parse.h>
#import "BEPaciente.h"

// If you are using Facebook, uncomment this line
// #import <ParseFacebookUtils/PFFacebookUtils.h>

#import "CocoaHeadsAppDelegate.h"

@implementation CocoaHeadsAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"JtiLcgLv4yJj0ixlGCXqxRcugJ8KMQgtU4JmieBJ" clientKey:@"oMp9mKiOVxty39J1qCZ4CGkcCMn3hHCGhoQEeSOy"];

    [BEPaciente registerSubclass];
    
    self.pacienteViewController  = [[CHPacienteViewController alloc] initWithNibName:@"CHPacienteViewController" bundle:nil];
    [self.window addSubview:self.pacienteViewController.view];
    
    //if (![PFUser currentUser])
    //{
        self.loginViewController = [[CHLoginViewController alloc] initWithNibName:@"CHLoginViewController" bundle:nil];
        [self loadChildViewController:self.loginViewController];
    //}
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)loadChildViewController:(UIViewController*)viewController
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    [viewController.view setFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:NAVEGACAO_TEMPO_ANIMACAO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [viewController.view setFrame:frame];
    [UIView commitAnimations];
    
    [self.window addSubview:viewController.view];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];

    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

///////////////////////////////////////////////////////////
// Uncomment this method if you want to use Push Notifications with Background App Refresh
///////////////////////////////////////////////////////////
/*
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}
 */

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state.
     This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
     or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates.
     Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state
     information to restore your application to its current state in case it is terminated later.
     If your application supports background execution,
     this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}

@end
