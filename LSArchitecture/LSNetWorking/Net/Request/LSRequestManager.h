//
//  LSRequestManager.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSURLResponse.h"

typedef void(^LSCallBack)(LSURLResponse *response);

@interface LSRequestManager : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callWithMethod:(NSString *)method
                        params:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                          path:(NSString *)path
                       success:(LSCallBack)success
                          fail:(LSCallBack)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
