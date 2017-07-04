//
//  NSArray+LSNetWork.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "NSArray+LSNetWork.h"

@implementation NSArray (LSNetWork)

- (NSString *)LS_paramsString {

    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        if ([paramString length] == 0) {
           
            [paramString appendFormat:@"%@", obj];
        } else {
           
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}

- (NSString *)LS_jsonString {

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
