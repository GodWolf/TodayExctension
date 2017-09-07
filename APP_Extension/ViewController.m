//
//  ViewController.m
//  APP_Extension
//
//  Created by 孙兴祥 on 2017/9/7.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //添加共享数据
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.sun.appextension"];
    [userDefault setValue:@"123" forKey:@"shareData"];
    [userDefault synchronize];
    NSLog(@"%@",[userDefault objectForKey:@"shareData"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
