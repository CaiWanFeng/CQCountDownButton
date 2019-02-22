//
//  ViewController.m
//  CQCountDownButton
//
//  Created by 蔡强 on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CQXibViewController.h"
#import <SVProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // HUD提示设置为1秒
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    
    self.title = @"第一页";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 150, self.view.frame.size.width, 40);
    [button setTitle:@"纯代码测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoSecondVC) forControlEvents:UIControlEventTouchDown];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button2];
    button2.frame = CGRectMake(0, 200, self.view.frame.size.width, 40);
    [button2 setTitle:@"xib测试" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(gotoXibVC) forControlEvents:UIControlEventTouchDown];
}

- (void)gotoSecondVC {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)gotoXibVC {
    CQXibViewController *xibVC = [[CQXibViewController alloc] init];
    [self.navigationController pushViewController:xibVC animated:YES];
}

@end
