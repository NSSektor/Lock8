//
//  AppDelegate.m
//  Lock8
//
//  Created by Angel Rivas on 4/14/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import "AppDelegate.h"

#import "Login.h"

@interface AppDelegate ()


@end


NSString* dispositivo;
NSString* url_web_service;
NSString* documentsDirectory;

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    url_web_service = @"http://201.131.96.37/wbs_tracking5.php?wsdl";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    
    NSString* ViewName = @"Login";
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    dispositivo = @"iPhone";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height == 568.0f) {
            ViewName = [ViewName stringByAppendingString:@"_iPhone5"];
            dispositivo = @"iPhone5";
        }
        if (screenSize.height == 667.0f) {
            ViewName = [ViewName stringByAppendingString:@"_iPhone6"];
            dispositivo = @"iPhone6";
        }
        if (screenSize.height == 736.0f) {
            ViewName = [ViewName stringByAppendingString:@"_iPhone6plus"];
            dispositivo = @"iPhone6plus";
        }
    } else {
        //Do iPad stuff here.
        ViewName = [ViewName stringByAppendingString:@"_iPad"];
        
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    Login*  viewController = [[Login alloc] initWithNibName:ViewName bundle:nil];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
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

@end
