//
//  NSObject+KVO.m
//  KVODemo
//
//  Created by 周晓瑞 on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>

const NSString * observeKey = @"observeKey";
const NSString * observeKeyPathKey = @"observeKeyPathKey";

@implementation NSObject (KVO)

- (void)setZz_keyPath:(NSString *)zz_keyPath{
    objc_setAssociatedObject(self, (__bridge const void *)(observeKeyPathKey), zz_keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)zz_keyPath{
    return  objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(observeKeyPathKey));
}
- (void)setZz_observer:(NSObject *)zz_observer{
    objc_setAssociatedObject(self, (__bridge const void *)(observeKey), zz_observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSObject *)zz_observer{
    return  objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(observeKey));
}


- (void)zz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    self.zz_observer = observer;
    self.zz_keyPath = keyPath;
    
    NSString * className = [NSString stringWithFormat:@"ZZKVONotifying_%@",NSStringFromClass(self.class)];
    const  char *cla = className.UTF8String;
    Class subP =  objc_allocateClassPair([self class], cla, 0);
    class_addMethod(subP, @selector(setAge:), (IMP)setAge, "v@:@");
    objc_registerClassPair(subP);
    object_setClass(self, subP);
}

void setAge(id self , SEL _cmd,NSUInteger  age){
   
    NSString *keyPath =  objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(observeKeyPathKey));
    NSObject *obj =  objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(observeKey));
    [self willChangeValueForKey:keyPath];
    
    /*这里还应该调用父亲的[super setAge:age]方法*/  
    
    [self didChangeValueForKey:keyPath];
    
    [obj  observeValueForKeyPath:keyPath ofObject:self change:@{@"new":[NSNumber numberWithInteger:age]} context:nil];
}

@end
