//
//  ServiceProvider.m
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "ServiceProvider.h"


#import <RestKit/RestKit.h>

static ServiceProvider *instance = nil;

@implementation ServiceProvider

+ (ServiceProvider *)sharedProvider {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ServiceProvider alloc] init];
    });
    
    return instance;
}

- (void)configureMappings {
    NSURL *baseURL = [NSURL URLWithString:kServerAddress];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKObjectManager setSharedManager:objectManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/json"];
    
    [[RKObjectManager sharedManager] setRequestSerializationMIMEType:RKMIMETypeJSON];
}

@end
