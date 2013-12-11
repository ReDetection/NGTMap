//
//  TransportUnit.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"
#import <CoreLocation/CoreLocation.h>

//Транспортная единица (автобус, троллейбус и т.д)

@interface TransportUnit : DataObject

@property (strong, nonatomic) NSString *routeIdentifier;
@property (strong, nonatomic) NSString *routeTitle;
@property (strong, nonatomic) NSString *routeOldTitle;
@property (strong, nonatomic) NSNumber *routeType;
@property (assign, nonatomic) NSInteger direction;
@property (assign, nonatomic) CLLocationDegrees latitude;
@property (assign, nonatomic) CLLocationDegrees longitude;
@property (assign, nonatomic) CGFloat azimuth;
@property (strong, nonatomic) NSDate *time;
@property (assign, nonatomic) CGFloat speed;
@property (assign, nonatomic) NSInteger offlineStatus;
@property (strong, nonatomic) NSArray *schedule;

@end
