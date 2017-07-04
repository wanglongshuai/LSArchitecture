//
//  NSDictionary+LSNetWork.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "NSDictionary+LSNetWork.h"
#import "NSArray+LSNetWork.h"

@implementation NSDictionary (LSNetWork)

- (NSString *)LS_paramsStringWithEncode:(BOOL)isEncode {

    NSArray *sortedArray = [self LS_transformedParamsArrayEncode:isEncode];
    
    return [sortedArray LS_paramsString];
}

- (NSString *)LS_jsonString {

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSArray *)LS_transformedParamsArrayEncode:(BOOL)isEncode {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
       
        if (![obj isKindOfClass:[NSString class]]) {
            
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        
        if (!isEncode) {
            
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        
        if ([obj length] > 0) {
            
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
   
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedResult;
}

@end
