//
//  MMKVTestViewController.m
//  Test
//
//  Created by zhang dekai on 2020/7/1.
//  Copyright © 2020 张德凯. All rights reserved.
//

/*
 
 MMKV用法：https://github.com/Tencent/MMKV/wiki/iOS_tutorial
 MMKV 有一些高级设置：https://github.com/Tencent/MMKV/wiki/iOS_advance_cn
 MMKV 原理：https://github.com/Tencent/MMKV/wiki/design
 other：https://www.jianshu.com/p/92bcb77f8eca

 通过mmap内存映射文件，提供一段可供随时写入的内存块，App只管往里面写数据，由操作系统负责将内存回写到文件，不必担心 crash 导致数据丢失。
 
 数据序列化方面我们选用protobuf协议，pb在性能和空间占用上都有不错的表现。
 将value通过protobuf协议序列化成统一的内存块（buffer），然后就可以将这些 KV 对象序列化到内存中。
 
 
 
 支持的 类型

 C/C++ Primitive Types：
 bool, int32, int64, uint32, uint64, float, double
 
 Objective-C Class：
 NSString, NSData, NSDate
 
 Any Class that implements <NSCoding> protocol.
 
 
 */

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
    
    // setter
    [mmkv setBool:YES forKey:@"isToken"];
    [mmkv setFloat:2.34 forKey:@"height"];
    [mmkv setInt32:34 forKey:@"age"];
    [mmkv setString:@"test01" forKey:@"test"];
    
    
    NSData *data = [@"hello test nsdata" dataUsingEncoding:NSUTF8StringEncoding];
    [mmkv setData:data forKey:@"data"];
    
//    [mmkv setObject:<#(nullable NSObject<NSCoding> *)#> forKey:@""]
    [mmkv setObject:@{@"key01":@"value_test",@"key2" : @(2)} forKey:@"object"];
   
    // getter
    NSLog(@"bool is :%d",[mmkv getBoolForKey:@"isToken"]);
    NSLog(@"setFloat is :%f",[mmkv getFloatForKey:@"height"]);
    NSLog(@"setInt32 is :%d",[mmkv getInt32ForKey:@"age"]);
    NSLog(@"setString is :%@",[mmkv getStringForKey:@"test"]);
    NSLog(@"setObject is :%@",[mmkv getObjectOfClass:[NSDictionary class] forKey:@"object"]);
    
    NSData *dataValue = [mmkv getDataForKey:@"data"];
    
    NSString *dataString = [[NSString alloc]initWithData:dataValue encoding:NSUTF8StringEncoding];
    
    NSLog(@"setData is :%@",dataString);

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
//删除 Deleting, Querying & Enumerating:
- (void)removeMMKV {
    MMKV *mmkv = [MMKV defaultMMKV];
    
    [mmkv removeValueForKey:@""];
    [mmkv removeValuesForKeys:@[@"data",@"age"]];
    
    [mmkv enumerateKeys:^(NSString * _Nonnull key, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"data"]) {
            NSString *value = [mmkv getStringForKey:key];
            NSLog(@"%@ = %@", key, value);
            *stop = YES;
        }
    }];
    
    [mmkv clearAll];
    [mmkv clearMemoryCache];
}

/*
 If different modules/logics need isolated storage, you can also create your own MMKV instance separately:
 */
//分模块存储
- (void)testmMmapID {
    //if you want a per-user mmkv, you could merge user-id within mmapID
    MMKV *mmkv = [MMKV mmkvWithID:@"MyID"];
    [mmkv setBool:YES forKey:@"bool"];
}

/*
 If multi-process accessing is needed(between the App and extensions)，you need to set the group directory on MMKV initialization as written before. Then you can get one by passing MMKVMultiProcess:
 */
//多进程？存储
- (void)testMultiID {
    MMKV *mmkv = [MMKV mmkvWithID:@"MyMultiID" mode:MMKVMultiProcess];
    [mmkv setBool:YES forKey:@"bool"];
}

//MMKV provides -[MMKV migrateFromUserDefaults:]，you can migrate from NSUserDefaults with one line of code.

// 迁移 NSUserDefaults 到 MMKV
- (void)migrateDataFromUserDefaults {
    
    NSUserDefaults *userDafault = [[NSUserDefaults alloc]initWithSuiteName:@"myDefault"];
    MMKV *mmkv = [MMKV mmkvWithID:@"testImportNSUserDefaults" mode:MMKVSingleProcess];
    [mmkv migrateFromUserDefaults:userDafault];
    
    // delete keys & values from userDefault when you're done
    // 迁移完成后，删除 userDefault 里的就可以了
}



@end
