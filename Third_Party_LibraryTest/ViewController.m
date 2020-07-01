//
//  ViewController.m
//  Third_Party_LibraryTest
//
//  Created by zhang dekai on 2020/7/1.
//  Copyright © 2020 mr dk. All rights reserved.
//

#import "ViewController.h"
#import "MMKVTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)jumpToMMKV:(UIButton *)sender {
    
    MMKVTestViewController *vc = [[MMKVTestViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
}


@end
