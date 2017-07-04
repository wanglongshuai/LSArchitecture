//
//  NSObject+LSNetWork.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "NSObject+LSNetWork.h"

@implementation NSObject (LSNetWork)

- (id)LS_defaultValue:(id)defaultData {
    
    if (![defaultData isKindOfClass:[self class]]) {
       
        return defaultData;
    }
    
    if ([self LS_isEmptyObject]) {
       
        return defaultData;
    }
    
    return self;
}

- (BOOL)LS_isEmptyObject {
    
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
