//
//  ViewController.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/2.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {

    NSLog(@"先进来啊！！！");

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear 进来了！！！");
}


@end
