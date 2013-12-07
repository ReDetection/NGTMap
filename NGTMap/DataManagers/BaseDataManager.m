//
//  BaseDataManager.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "BaseDataManager.h"
#import <RestKit/RestKit.h>

@implementation BaseDataManager

+ (instancetype)sharedManager {
    methodNotImplemented();
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        _baseRequestParams = @{@"v": kServerApiVersion, @"key" : kServerApiKey, @"format" : kServerApiFormat};
    }
    
    return self;
}

- (void)cancelRequestForPath: (NSString *)path {
    [[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:path];
}

// array (33,21) -> [33, 21]
- (NSString *)formattedStringFromArray: (NSArray *)array {
    NSString *formattedString = [array.description stringByReplacingOccurrencesOfString:@"(" withString:@"["];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@")" withString:@"]"];
    formattedString =[formattedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    formattedString =[formattedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return formattedString;
}


@end
