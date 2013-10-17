//
//  ServiceProvider.m
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "ServiceProvider.h"

#import "Route.h"
#import "TransportUnit.h"
#import "Track.h"
#import "SimpleTrackPoint.h"
#import "StopTrackPoint.h"


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

- (void)cancelRequestForPath: (NSString *)path {
    [[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:path];
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

- (void)getTransportUnitsByRoutesAndDirections: (NSArray *)routesWithDirections successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    
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

- (void)getTransportUnitsByRoutes: (NSArray *)routes successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler {
    
    NSMutableArray *resultArrayWithDirections = [NSMutableArray array];
    [routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *routeId = obj;
        NSArray *routesWithDirections = @[routeId, [NSString stringWithFormat:@"%d", BothDirectionType]];
        [resultArrayWithDirections addObject:routesWithDirections];
    }];
    
    [self getTransportUnitsByRoutesAndDirections:resultArrayWithDirections successHandler:successHandler failHandler:failHandler];
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

#pragma mark - Mappings

- (void)configureMappings {
    NSURL *baseURL = [NSURL URLWithString:kServerAddress];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKObjectManager setSharedManager:objectManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [RKObjectMapping addDefaultDateFormatter:dateFormatter];
    
    [[RKObjectManager sharedManager] setRequestSerializationMIMEType:RKMIMETypeJSON];
    
    [self configureRoutes];
    [self configureTransportUnits];
    [self configureTracks];
}

- (void)configureTracks {
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

- (void)configureTransportUnits {
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

- (void)configureRoutes {
    
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

#pragma mark - PrivateMethods

- (NSString *)formattedStringFromArray: (NSArray *)array {
    NSString *formattedString = [array.description stringByReplacingOccurrencesOfString:@"(" withString:@"["];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@")" withString:@"]"];
    formattedString =[formattedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    formattedString =[formattedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return formattedString;
}

@end
