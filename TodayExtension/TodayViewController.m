//
//  TodayViewController.m
//  TodayExtension
//
//  Created by 孙兴祥 on 2017/9/7.
//  Copyright © 2017年 sunxiangxiang. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>


@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    NSExtensionPrincipalClass  NSExtensionMainStoryboard
    
    if([[UIDevice currentDevice].systemVersion floatValue] > 10.0){
        //最小为110的高度，这个如果低于110则不改变
        //设置NCWidgetDisplayModeExpanded可以展开折叠
        //设置NCWidgetDisplayModeCompact只有一种大小
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }else{//iOS8 iOS9可以自己设置大小，不建议太大
        self.preferredContentSize = CGSizeMake(0, 50);
    }
    
    UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    openBtn.center = CGPointMake(self.view.bounds.size.width/2.0, 20);
    [openBtn setTitle:@"打开应用程序" forState:(UIControlStateNormal)];
    [openBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [openBtn addTarget:self action:@selector(openApp) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:openBtn];
    
    //读取共享数据
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.sun.appextension"];
    NSLog(@"%@",[userDefault objectForKey:@"shareData"]);
}

- (void)openApp {
    
    NSLog(@"打开app");
    [self.extensionContext openURL:[NSURL URLWithString:@"suntodayextension://"] completionHandler:^(BOOL success) {
        if(success){
            NSLog(@"成功");
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"appear");
    //建议在这里请求数据
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"disapear");
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

//iOS10以后才能调用该方法
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {//展开模式
        self.preferredContentSize = CGSizeMake(0, 300);
    } else if (activeDisplayMode == NCWidgetDisplayModeCompact) {//折叠模式
        self.preferredContentSize = maxSize;
    }
}

//iOS10以后左边不会有空白，该方法也就失去了作用
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsZero;
}

@end
