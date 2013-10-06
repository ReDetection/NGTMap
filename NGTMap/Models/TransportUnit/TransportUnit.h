//
//  TransportUnit.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"

//Транспортная единица (автобус, троллейбус и т.д)

@interface TransportUnit : DataObject

@property (strong, nonatomic) NSString *routeIdentifier;
@property (assign, nonatomic) NSInteger direction;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;
@property (assign, nonatomic) CGFloat azimuth;
@property (strong, nonatomic) NSDate *time;
@property (assign, nonatomic) CGFloat speed;

@end
