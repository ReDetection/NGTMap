//
//  RoutesManager.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "RoutesManager.h"
#import "Route.h"

#import <RestKit/RestKit.h>

static RoutesManager *instance = nil;

@interface RoutesManager()

@property (strong, nonatomic) NSArray *routes;

@end

@implementation RoutesManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RoutesManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKObjectMapping *routeMapping = [RKObjectMapping mappingForClass:[Route class]];
        [routeMapping addAttributeMappingsFromDictionary:@{
                                                           @"id": @"identifier",
                                                           @"type_transport": @"type",
                                                           @"title": @"title",
                                                           @"title_old": @"oldTitle",
                                                           @"name_begin": @"stopBegin",
                                                           @"name_end": @"stopEnd"
                                                           }];
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:routeMapping
                                                                                                method:RKRequestMethodGET
                                                                                           pathPattern:kRoutesPath
                                                                                               keyPath:@"data"
                                                                                           statusCodes:successStatusCodes];
        
        [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    }
    
    return self;
}

- (void)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    if (_routes) {
        if (successHandler)
            successHandler(_routes);
    } else {
        [[RKObjectManager sharedManager] getObjectsAtPath:kRoutesPath parameters:_baseRequestParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            self.routes = mappingResult.array;
            if (successHandler)
                successHandler(_routes);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            if (failHandler)
                failHandler(error);
        }];
    }
}

@end
