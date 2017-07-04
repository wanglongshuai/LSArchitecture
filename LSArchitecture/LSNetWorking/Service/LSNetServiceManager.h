//
//  LSNetServiceManager.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSNetService.h"

@interface LSNetServiceManager : NSObject

+ (instancetype)sharedInstance;

- (LSNetService <LSNetServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
