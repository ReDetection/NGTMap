//
//  SimpleTrackPoint.h
//  NGTMap
//
//  Created by Bromot Alexey on 17.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"

#import <CoreLocation/CoreLocation.h>

//Точка изгиба/поворота на трассе

@interface SimpleTrackPoint : DataObject

@property (assign, nonatomic) NSInteger order;
@property (assign, nonatomic) CLLocationDegrees latitude;
@property (assign, nonatomic) CLLocationDegrees longitude;

@end
