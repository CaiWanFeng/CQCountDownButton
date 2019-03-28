//
//  ViewController.m
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 caiqiang. All rights reserved.
//

#import "ViewController.h"
#import "CQBlockViewController.h"
#import "CQDelegateViewController.h"
#import "CQQuickStartController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"contents";
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:button];
        button.frame = CGRectMake(0, 150+80*i, self.view.frame.size.width, 60);
        switch (i) {
            case 0:
            {
                [button setTitle:@"block版本" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(blockVersion) forControlEvents:UIControlEventTouchDown];
            }
                break;
                
            case 1:
            {
                [button setTitle:@"delegate版本" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(delegateVersion) forControlEvents:UIControlEventTouchDown];
            }
                break;
                
            case 2:
            {
                [button setTitle:@"直接开始倒计时" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(quickStart) forControlEvents:UIControlEventTouchDown];
            }
                break;
        }
    }
}

- (void)blockVersion {
    CQBlockViewController *blockVC = [[CQBlockViewController alloc] init];
    [self.navigationController pushViewController:blockVC animated:YES];
}

- (void)delegateVersion {
    CQDelegateViewController *delegateVC = [[CQDelegateViewController alloc] init];
    [self.navigationController pushViewController:delegateVC animated:YES];
}

- (void)quickStart {
    CQQuickStartController *quickStartVC = [[CQQuickStartController alloc] init];
    [self.navigationController pushViewController:quickStartVC animated:YES];
}

@end
