//
//  ServiceProvider.h
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AllRoutesSuccessBlock)(NSArray *routes);
typedef void (^TransportUnitsByRouteAndDirectionsSuccessBlock)(NSArray *transportUnits);

@interface ServiceProvider : NSObject

+ (ServiceProvider *)sharedProvider;
- (void)configureMappings;

- (void)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

- (void)getTransportUnitsByRoutesAndDirections: (NSArray *)routesWithDirections successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)getTransportUnitsByRoutes: (NSArray *)routes successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

@end
