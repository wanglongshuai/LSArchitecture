//
//  LSRequestGenerator.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams path:(NSString *)path method:(NSString *)method;

@end
