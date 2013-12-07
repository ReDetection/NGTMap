//
//  FavoritesManager.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupRoutes.h"
#import "Route.h"

@interface FavoritesManager : NSObject

+ (instancetype)sharedManager;

- (void)save;
- (void)load;

- (void)addRoute: (Route *)route;
- (void)removeRoute: (Route *)route;

- (void)addGroupRoutes: (GroupRoutes *)group;
- (void)removeGroupRoutes: (GroupRoutes *)group;

- (NSArray *)routes;
- (NSArray *)groupsRoutes;

@end
