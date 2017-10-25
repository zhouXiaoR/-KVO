//
//  NSObject+KVO.h
//  KVODemo
//
//  Created by 周晓瑞 on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

@property(nonatomic,strong)NSString * zz_keyPath;
@property(nonatomic,strong)NSObject *zz_observer;
- (void)zz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
