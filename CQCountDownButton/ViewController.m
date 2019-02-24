//
//  ViewController.m
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CQXibViewController.h"
#import "DelegateButtonViewController.h"
#import <SVProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // HUD提示设置为1秒
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    
    self.title = @"contents";
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:button];
        button.frame = CGRectMake(0, 100+60*i, self.view.frame.size.width, 50);
        switch (i) {
            case 0:
            {
                [button setTitle:@"纯代码block版本" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(gotoSecondVC) forControlEvents:UIControlEventTouchDown];
            }
                break;
                
            case 1:
            {
                [button setTitle:@"纯代码delegate版本" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(gotoDelegateVC) forControlEvents:UIControlEventTouchDown];
            }
                break;
                
            case 2:
            {
                [button setTitle:@"xib版本" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(gotoXibVC) forControlEvents:UIControlEventTouchDown];
            }
                break;
        }
    }
}

// block版本
- (void)gotoSecondVC {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

// delegate版本
- (void)gotoDelegateVC {
    DelegateButtonViewController *vc = [[DelegateButtonViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// xib版本
- (void)gotoXibVC {
    CQXibViewController *xibVC = [[CQXibViewController alloc] init];
    [self.navigationController pushViewController:xibVC animated:YES];
}

@end
