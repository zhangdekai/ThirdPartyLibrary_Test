//
//  MMKVTestViewController.m
//  Test
//
//  Created by zhang dekai on 2020/7/1.
//  Copyright © 2020 张德凯. All rights reserved.
//

#import "MMKVTestViewController.h"

@interface MMKVTestViewController ()

@end

@implementation MMKVTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];


    [self testMMKV];

}

- (void)testMMKV {
    
    MMKV *mmkv = [MMKV defaultMMKV];//单例
    
    [mmkv setBool:YES forKey:@"isToken"];
//    [mmkv setData:[NSDate date] forKey:@"imagedata"];
    [mmkv setFloat:2.34 forKey:@"height"];
    [mmkv setInt32:34 forKey:@"age"];
    [mmkv setString:@"test01" forKey:@"test"];
    
//    [mmkv setObject:<#(nullable NSObject<NSCoding> *)#> forKey:@""]
    
    [mmkv setObject:@{@"key01":@"value_test"} forKey:@"object"];
   
    NSLog(@"bool is :%d",[mmkv getBoolForKey:@"isToken"]);
    NSLog(@"setFloat is :%f",[mmkv getFloatForKey:@"height"]);
    NSLog(@"setInt32 is :%d",[mmkv getInt32ForKey:@"age"]);
    NSLog(@"setString is :%@",[mmkv getStringForKey:@"test"]);
    NSLog(@"setObject is :%@",[mmkv getObjectOfClass:[NSDictionary class] forKey:@"object"]);
/*
 
  bool is :1
  setFloat is :2.340000
  setInt32 is :34
  setString is :test01
  setObject is :{
     key01 = "value_test";
 }
 */
    
}



@end
