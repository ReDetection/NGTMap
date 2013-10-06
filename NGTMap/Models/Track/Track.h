//
//  Track.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"

//Трасса маршрута

@interface Track : DataObject

@property (strong, nonatomic) NSString *routeIdentifier;
@property (assign, nonatomic) NSInteger direction;
@property (strong, nonatomic) NSArray *trackPoints;

@end
