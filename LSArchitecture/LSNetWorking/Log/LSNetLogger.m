//
//  LSNetLogger.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSNetLogger.h"
#import "NSObject+LSNetWork.h"
#import "NSMutableString+LSNetWork.h"

@implementation LSNetLogger

+ (instancetype)sharedInstance {

    static dispatch_once_t onceToken;
    static LSNetLogger *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSNetLogger alloc] init];
    });
    return sharedInstance;
}

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(LSNetService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod {

    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", [apiName LS_defaultValue:@"N/A"]];
    [logString appendFormat:@"Method:\t\t\t%@\n", [httpMethod LS_defaultValue:@"N/A"]];
    [logString appendFormat:@"Service:\t\t%@\n", [service class]];
    [logString appendFormat:@"Params:\n%@", requestParams];
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    NSLog(@"%@", logString);
}

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error {

    BOOL shouldLogError = error ? YES : NO;
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", (long)response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];
    [logString appendFormat:@"Content:\n\t%@\n\n", responseString];
    if (shouldLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }
    
    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    
    NSLog(@"%@", logString);
}

+ (void)logDebugInfoWithCachedResponse:(LSURLResponse *)response path:(NSString *)path serviceIdentifier:(LSNetService *)service {

    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Cached Response                       =\n==============================================================\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", [path LS_defaultValue:@"N/A"]];
    [logString appendFormat:@"Service:\t\t%@\n", [service class]];
    [logString appendFormat:@"Method Name:\t%@\n", path];
    [logString appendFormat:@"Params:\n%@\n\n", response.requestParams];
    [logString appendFormat:@"Content:\n\t%@\n\n", response.contentString];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@", logString);
}

@end
