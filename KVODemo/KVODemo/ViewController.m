//
//  ViewController.m
//  KVODemo
//
//  Created by 周晓瑞 on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"

@interface ViewController ()
@property(nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self KVOTest];
}

- (void)KVOTest{
    Person * p = [[Person alloc]init];
    self.p = p;
    
    [p zz_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
//    [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change - %@",change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int tempAge = 10;
    tempAge += 2;
    self.p.age = tempAge;
}



#pragma mark - dealloc

- (void)dealloc{
    [self.p removeObserver:self forKeyPath:@"age"];
}




@end
