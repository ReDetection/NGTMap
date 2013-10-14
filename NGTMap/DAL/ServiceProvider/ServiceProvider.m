//
//  ServiceProvider.m
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "ServiceProvider.h"

#import "Route.h"


#import <RestKit/RestKit.h>

static ServiceProvider *instance = nil;

@interface ServiceProvider()

@property (strong, nonatomic) NSDictionary *baseRequestParams;

@end

@implementation ServiceProvider

+ (ServiceProvider *)sharedProvider {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ServiceProvider alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.baseRequestParams = @{@"v": kServerApiVersion, @"key" : kServerApiKey, @"format" : kServerApiFormat};
    }
    
    return self;
}

- (void)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    [[RKObjectManager sharedManager] getObjectsAtPath:kRoutesPath parameters:_baseRequestParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *array = mappingResult.array;
        if (successHandler)
            successHandler(array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failHandler)
            failHandler(error);
    }];
}

#pragma mark - Mappings

- (void)configureMappings {
    NSURL *baseURL = [NSURL URLWithString:kServerAddress];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKObjectManager setSharedManager:objectManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"application/json"];
    
    [[RKObjectManager sharedManager] setRequestSerializationMIMEType:RKMIMETypeJSON];
    
    [self configureRoutes];
}

- (void)configureRoutes {
    
    NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    RKObjectMapping *routeMapping = [RKObjectMapping mappingForClass:[Route class]];
    [routeMapping addAttributeMappingsFromDictionary:@{
                                                       @"id": @"identifier",
                                                       @"type_transport": @"type",
                                                       @"title": @"title",
                                                       @"title_old": @"oldTitle",
                                                       @"stop_begin": @"stop_begin",
                                                       @"stop_end": @"stop_end"
                                                       }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:routeMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:kRoutesPath
                                                keyPath:@"data"
                                            statusCodes:successStatusCodes];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];

}

@end
