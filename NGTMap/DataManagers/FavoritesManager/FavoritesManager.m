//
//  FavoritesManager.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "FavoritesManager.h"
#import "RoutesManager.h"

static FavoritesManager *instance = nil;

NSString *const kFavoritesPlist = @"favourites.plist";
NSString *const kRoutesKey = @"Routes";
NSString *const kGroupRoutesKey = @"GroupRoutes";

@interface FavoritesManager() {
    NSMutableArray *_routesIDs;
    NSMutableArray *_groupRoutes;
}

@end

@implementation FavoritesManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FavoritesManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    if (self = [super init] ) {
        [self load];
    }
    return self;
}

- (void)save {
    NSDictionary *favorites = @{ kRoutesKey: _routesIDs,
                                 kGroupRoutesKey: _groupRoutes};
    [favorites writeToFile:[self fullFavouritesPlistPath] atomically:YES];
}

- (void)load {
    NSDictionary *favorites = [NSDictionary dictionaryWithContentsOfFile:[self fullFavouritesPlistPath]];
    _routesIDs = [[favorites objectForKey:kRoutesKey] mutableCopy];
    _groupRoutes = [[favorites objectForKey:kGroupRoutesKey] mutableCopy];
    
    if (!_routesIDs) {
        _routesIDs = [[NSMutableArray alloc] init];
    }
    
    if (!_groupRoutes) {
        _groupRoutes = [[NSMutableArray alloc] init];
    }
}

- (void)addRoute: (Route *)route {
    if (![self isFavoriteRoute:route]) {
        [_routesIDs addObject:route.identifier];
    }
}

- (void)removeRoute: (Route *)route {
    [_routesIDs removeObject:route.identifier];
}

- (void)addGroupRoutes: (GroupRoutes *)group {
    
}

- (void)removeGroupRoutes: (GroupRoutes *)group {
    
}

- (BOOL)isFavoriteRoute: (Route *)route {
    return [_routesIDs containsObject:route.identifier];
}

- (NSArray *)routes {
    NSMutableArray *routes = [[NSMutableArray alloc] initWithCapacity:[_routesIDs count]];
    for (NSString *routeID in _routesIDs) {
        Route *route = [[RoutesManager sharedManager] routeWithID:routeID];
        if (route) {
            [routes addObject:route];
        }
    }
    
    return routes;
}

- (NSArray *)groupsRoutes {
    return nil;
}

#pragma mark - Private methods

- (NSString *)fullFavouritesPlistPath {
    return [DOCUMENTS_FOLDER stringByAppendingPathComponent:kFavoritesPlist];
}

@end
