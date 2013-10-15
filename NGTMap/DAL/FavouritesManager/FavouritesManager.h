//
//  FavouritesManager.h
//  NGTMap
//
//  Created by Bromot Alexey on 15.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavouritesManager : NSObject

@property (strong, nonatomic) NSMutableArray *favouritesRoutes;

+ (FavouritesManager *)sharedManager;

- (BOOL)isContainRouteID: (NSString *)routeID;
- (void)addRouteID: (NSString *)routeID;
- (void)removeRouteID: (NSString *)routeID;

@end
