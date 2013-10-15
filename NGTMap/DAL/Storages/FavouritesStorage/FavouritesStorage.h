//
//  FavouritesStorage.h
//  NGTMap
//
//  Created by Bromot Alexey on 15.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavouritesStorage : NSObject

- (NSArray *)favouritesRoutes;
- (BOOL)isContainRouteID: (NSString *)routeID;
- (void)addRouteID: (NSString *)routeID;
- (void)removeRouteID: (NSString *)routeID;

@end
