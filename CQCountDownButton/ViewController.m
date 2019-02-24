//
//  ViewController.m
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 caiqiang. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD.h>
#import "CQBlockViewController.h"
#import "CQDelegateViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    
    self.title = @"contents";
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:button];
        button.frame = CGRectMake(0, 100+60*i, self.view.frame.size.width, 50);
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

@end
