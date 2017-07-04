//
//  LSCodeStandardDataTranslator.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardDataTranslator.h"
#import "LSCodeStandardAPIManager.h"

#import "LSCodeStandardCellViewModel.h"
#import "LSCodeStandardModel.h"

@implementation LSCodeStandardDataTranslator

- (id)manager:(LSAPIBaseManager *)manager translateData:(NSDictionary *)data {

    if ([manager isKindOfClass:[LSCodeStandardAPIManager class]]) {
        
        NSMutableArray *resArray = data[@"res"];
        
        return [[[resArray rac_sequence] map:^id(NSDictionary *value) {
            
            LSCodeStandardInfo *info = [[LSCodeStandardInfo alloc] initWithDict:value];
            LSCodeStandardItem *item = [[LSCodeStandardModel sharedInstance] getCodeStandardItemWithInfo:info];
            return [[LSCodeStandardCellViewModel alloc] initWithDataItem:item delegate:nil];
            
        }] array];

    }
    
    return nil;
}

@end
