//
//  AppDelegate.m
//  Sales App
//
//  Created by Infinitum on 06/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import <AFNetworking.h>
#import "Reachability.h"
#import <OneSignal/OneSignal.h>

@interface AppDelegate ()

@end
@implementation AppDelegate
@synthesize navController,window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:@"d0587aee-6238-4001-8d0d-4aeb7b4c6fda"
            handleNotificationAction:nil
                            settings:@{kOSSettingsKeyAutoPrompt: @false}];
    OneSignal.inFocusDisplayType = OSNotificationDisplayTypeNotification;
    
    // Recommend moving the below line to prompt for push after informing the user about
    //   how your app will use them.
    [OneSignal promptForPushNotificationsWithUserResponse:^(BOOL accepted) {
        NSLog(@"User accepted notifications: %d", accepted);
    }];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"http://13.126.129.245/xrbia/mobilecrm/sales/" forKey:@"Link"];
    [prefs setObject:@"http://13.126.129.245/xrbia/" forKey:@"url"];

    self.leadsarr=[[NSMutableArray alloc]init];
    self.syncleadarr=[[NSMutableArray alloc]init];
    self.projectarr=[[NSMutableArray alloc]init];

    //
//    [prefs setObject:@"http://49.248.43.178/xrbia/mobilecrm/sales/" forKey:@"Link"];
//     [prefs setObject:@"http://49.248.43.178/xrbia" forKey:@"url"];

        [self checkversion];
    // Override point for customization after application launch.
    return YES;
}
-(void)checkversion
{    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([self connected])
    {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"ios" forKey:@"deviceType"];
    [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getMobileAppVersion.php?",[prefs objectForKey:@"Link"]];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
       if([[userDict objectForKey:@"app_version"]isEqualToString:@"2.5"])
       {
           
         //  LoginViewController *viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
           LoginViewController * viewController=[[LoginViewController alloc]init];
           self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
           navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
           self.window.rootViewController=navController;
           [self.window makeKeyAndVisible];
       }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"New update avaible."delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Update App", nil];
            alert.delegate=self;
            [alert show];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self checkversion];
        
    }];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No internet connectino avaible"delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Retry", nil];
        alert.tag=10;
        alert.delegate=self;
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10) {
        [self checkversion];
    }
    else{
    if (buttonIndex == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/xrbia-distribution-app/id1390993019?mt=8"]];
    }
    }
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
