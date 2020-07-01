//
//  AppDelegate.m
//  Third_Party_LibraryTest
//
//  Created by zhang dekai on 2020/7/1.
//  Copyright © 2020 mr dk. All rights reserved.
//

#import "AppDelegate.h"
#import <MMKV.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    
    [self initMMKV];
    
    return YES;
}

- (void)initMMKV {
    
    /*
    call this in main thread, before calling any other MMKV methods
    parm rootDir the root dir of MMKV, passing nil defaults to {NSDocumentDirectory}/mmkv
    return root dir of MMKV
    */
    //初始化  单进程的MMKV
    NSString *rootDir = [MMKV initializeMMKV:nil logLevel:MMKVLogNone];//MMKVLogNone：无log的
    NSLog(@"MMKV root dir is :%@",rootDir);
    
    
    //If multi-process accessing is needed(between the App and extensions)，you need to set the group directory on MMKV initialization:
    
    /*
     多进程的 MMKV
    NSString *myGroupID = @"group.company.mmkv";
    
    // the group dir that can be accessed by App & extensions
    NSString *groupDir = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:myGroupID].path;
   
    [MMKV initializeMMKV:nil groupDir:groupDir logLevel:MMKVLogInfo];
    */
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
