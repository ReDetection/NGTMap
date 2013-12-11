//
//  TransportUnitsManager.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "BaseDataManager.h"

typedef void (^TransportUnitsByRouteAndDirectionsSuccessBlock)(NSArray *transportUnits);

@interface TransportUnitsManager : BaseDataManager

- (void)getTransportUnitsByRoutesIDsAndDirections: (NSArray *)routesWithDirections successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)getTransportUnitsByRoutesIDs: (NSArray *)routes successHandler: (TransportUnitsByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)cancelGetTransportUnits;

@end