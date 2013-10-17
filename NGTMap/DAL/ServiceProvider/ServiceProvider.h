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
typedef void (^TracksByRouteAndDirectionsSuccessBlock)(NSArray *tracks);

@interface ServiceProvider : NSObject

+ (ServiceProvider *)sharedProvider;
- (void)configureMappings;

//Отменить запрос
- (void)cancelRequestForPath: (NSString *)path;

//Все маршруты
- (void)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

//Положения транспорта на карте
- (void)getTransportUnitsByRoutesAndDirections: (NSArray *)routesWithDirections successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)getTransportUnitsByRoutes: (NSArray *)routes successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

//Трасса маршрута
- (void)getTracksByRoutesAndDirections: (NSArray *)routesWithDirections successHandler: (TracksByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)getTracksByRoutes: (NSArray *)routes successHandler: (TracksByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

@end
