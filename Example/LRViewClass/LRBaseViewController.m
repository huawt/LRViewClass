//
//  LRViewController.m
//  LRViewClass
//
//  Created by huawt on 07/03/2020.
//  Copyright (c) 2020 huawt. All rights reserved.
//

#import "LRBaseViewController.h"
#import <LRViewClass/LRViewClass.h>

@interface LRBaseViewController ()

@end

@implementation LRBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试模态" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.magentaColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testModal) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 100, 60);
    button.center = self.view.center;
    [self.view addSubview:button];
    
}

- (void)testModal
{
    LRViewController *view = [[LRViewController alloc] init];
    view.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
