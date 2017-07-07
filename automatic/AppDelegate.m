//
//  AppDelegate.m
//  automatic
//
//  Created by shiki on 2017/6/27.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "AppDelegate.h"
#import "CalendarViewController.h"
#import "ModelViewController.h"
#import "AutoViewController.h"
#import "tempViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];

    // 取得沙盒目录
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"ManualMode.txt"];
    NSString *filePath1 = [localPath  stringByAppendingPathComponent:@"Automode.txt"];

    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        CalendarViewController *ca = [[CalendarViewController alloc]init];
        self.window.rootViewController = ca;

    }
    
    if ([fileManager fileExistsAtPath:filePath1]) {
        tempViewController *tp = [[tempViewController alloc]init];
        self.window.rootViewController =  tp;
    }
    
    if (![fileManager fileExistsAtPath:filePath1] && ![fileManager fileExistsAtPath:filePath1]) {
        ModelViewController *mode = [[ModelViewController alloc]init];
        self.window.rootViewController = mode;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
