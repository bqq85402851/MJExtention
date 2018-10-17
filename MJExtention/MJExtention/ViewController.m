//
//  ViewController.m
//  MJExtention
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 毕小强. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "MJExtentiom+NSObject/MJExtention.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p = [[Person alloc] init];
    p.arrayKeyWithValue = @{
                            @"mans":@"Student"
                            };
    [p mj_objectWithValue:@{@"student":@{@"age":@"12"},
                            @"numValue":@(12),
                            @"mans":@[@{@"age":@"13"},@{@"age":@"14"},@{@"age":@"15"}]
                            }];
    NSLog(@"%@",p);
}


@end
