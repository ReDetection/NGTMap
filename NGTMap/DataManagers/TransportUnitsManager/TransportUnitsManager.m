//
//  TransportUnitsManager.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "TransportUnitsManager.h"
#import "TransportUnit.h"

#import <RestKit/RestKit.h>

static TransportUnitsManager *instance = nil;

@implementation TransportUnitsManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TransportUnitsManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKObjectMapping *trasportUnitMapping = [RKObjectMapping mappingForClass:[TransportUnit class]];
        [trasportUnitMapping addAttributeMappingsFromDictionary:@{
                                                                  @"id_alias": @"routeIdentifier",
                                                                  @"title": @"routeTitle",
                                                                  @"title_old": @"routeOldTitle",
                                                                  @"type_transport": @"routeType",
                                                                  @"direction": @"direction",
                                                                  @"lat": @"latitude",
                                                                  @"lng": @"longitude",
                                                                  @"azimuth": @"azimuth",
                                                                  @"time": @"time",
                                                                  @"speed": @"speed",
                                                                  @"offline": @"offlineStatus",
                                                                  @"schedule": @"schedule"
                                                                  }];
        
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:trasportUnitMapping
                                                                                                method:RKRequestMethodGET
                                                                                           pathPattern:kTransportUnitsByIdsPath
                                                                                               keyPath:@"data"
                                                                                           statusCodes:successStatusCodes];
        
        [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    }
    
    return self;
}

- (void)getTransportUnitsByRoutesIDsAndDirections: (NSArray *)routesWithDirections successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    
    NSString *routesWithDirectionsString = [self formattedStringFromArray:routesWithDirections];
    NSString *requestPath = [kTransportUnitsByIdsPath stringByReplacingOccurrencesOfString:kCustomValueInPath withString:routesWithDirectionsString];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:requestPath parameters:_baseRequestParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *array = mappingResult.array;
        if (successHandler)
            successHandler(array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failHandler)
            failHandler(error);
    }];
}

- (void)getTransportUnitsByRoutesIDs: (NSArray *)routes successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    
    NSMutableArray *resultArrayWithDirections = [NSMutableArray array];
    [routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *routeId = obj;
        NSArray *routesWithDirections = @[routeId, [NSString stringWithFormat:@"%d", BothDirectionType]];
        [resultArrayWithDirections addObject:routesWithDirections];
    }];
    
    [self getTransportUnitsByRoutesIDsAndDirections:resultArrayWithDirections successHandler:successHandler failHandler:failHandler];
}

- (void)cancelGetTransportUnits {
    [self cancelRequestForPath:kTransportUnitsByIdsPath];
}

@end
