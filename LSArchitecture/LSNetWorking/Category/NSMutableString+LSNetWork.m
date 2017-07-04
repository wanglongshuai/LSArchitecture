//
//  NSMutableString+LSNetWork.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "NSMutableString+LSNetWork.h"
#import "NSObject+LSNetWork.h"

@implementation NSMutableString (LSNetWork)

- (void)appendURLRequest:(NSURLRequest *)request {
    
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] LS_defaultValue:@"\t\t\t\tN/A"]];
}

@end
