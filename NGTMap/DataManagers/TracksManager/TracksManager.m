//
//  TracksManager.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "TracksManager.h"
#import "Track.h"
#import "StopTrackPoint.h"

#import <RestKit/RestKit.h>

static TracksManager *instance = nil;

@interface TracksManager()

@end

@implementation TracksManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TracksManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKObjectMapping *trackMapping = [RKObjectMapping mappingForClass:[Track class]];
        [trackMapping addAttributeMappingsFromDictionary:@{
                                                           @"id_route": @"routeIdentifier",
                                                           @"title": @"routeTitle",
                                                           @"direction": @"direction"
                                                           }];
        
        RKObjectMapping *stopTrackPointMapping = [RKObjectMapping mappingForClass:[StopTrackPoint class]];
        [stopTrackPointMapping addAttributeMappingsFromDictionary:@{
                                                                    @"order": @"order",
                                                                    @"lat": @"latitude",
                                                                    @"lng": @"longitude",
                                                                    @"id_stop": @"identifier",
                                                                    @"name_stop": @"name",
                                                                    @"id_platform": @"platformIdentifier",
                                                                    @"len": @"length"
                                                                    }];
        
        [trackMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"trassa" toKeyPath:@"trackPoints" withMapping:stopTrackPointMapping]];
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:trackMapping
                                                                                                method:RKRequestMethodGET
                                                                                           pathPattern:kTracksByIdsPath
                                                                                               keyPath:@"data"
                                                                                           statusCodes:successStatusCodes];
        
        [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    }
    
    return self;
}

- (void)getTracksByRoutesAndDirections: (NSArray *)routesWithDirections successHandler: (TracksByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    NSString *routesWithDirectionsString = [self formattedStringFromArray:routesWithDirections];
    NSString *requestPath = [kTracksByIdsPath stringByReplacingOccurrencesOfString:kCustomValueInPath withString:routesWithDirectionsString];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:requestPath parameters:_baseRequestParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *array = mappingResult.array;
        if (successHandler)
            successHandler(array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failHandler)
            failHandler(error);
    }];
}

- (void)getTracksByRoutes: (NSArray *)routes successHandler: (TracksByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    
    NSMutableArray *resultArrayWithDirections = [NSMutableArray array];
    [routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *routeId = obj;
        NSArray *routesWithDirections = @[routeId, [NSString stringWithFormat:@"%d", BothDirectionType]];
        [resultArrayWithDirections addObject:routesWithDirections];
    }];
    
    [self getTracksByRoutesAndDirections:resultArrayWithDirections successHandler:successHandler failHandler:failHandler];
}

- (void)cancelGetTracks {
    [self cancelRequestForPath:kTracksByIdsPath];
}

@end
