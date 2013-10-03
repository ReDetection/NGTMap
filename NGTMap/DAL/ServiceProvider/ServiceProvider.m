//
//  ServiceProvider.m
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "ServiceProvider.h"

static ServiceProvider *instance = nil;

@implementation ServiceProvider

+ (ServiceProvider *)sharedProvider {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ServiceProvider alloc] init];
    });
    
    return instance;
}

- (void)configureMapping {
    
}

@end
