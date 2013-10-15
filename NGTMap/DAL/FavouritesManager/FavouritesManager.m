//
//  FavouritesManager.m
//  NGTMap
//
//  Created by Bromot Alexey on 15.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "FavouritesManager.h"

static FavouritesManager *instance = nil;

#define FAVOURITES_PLIST_NAME @"favourites.plist"

@interface FavouritesManager()

@end

@implementation FavouritesManager

+ (FavouritesManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FavouritesManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.favouritesRoutes = [[NSMutableArray alloc] initWithContentsOfFile:[self favouritesPlistPath]];
        if (!_favouritesRoutes) {
            self.favouritesRoutes = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (void)addRouteID: (NSString *)routeID {
    [self.favouritesRoutes addObject:routeID];
    [self save];
}
- (void)removeRouteID: (NSString *)routeID {
    [self.favouritesRoutes removeObject:routeID];
    [self save];
}

- (BOOL)isContainRouteID: (NSString *)routeID {
    return [self.favouritesRoutes containsObject:routeID];
}


#pragma mark - Private methods

- (void)save {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.favouritesRoutes writeToFile:[self favouritesPlistPath] atomically:YES];
    });
}

- (NSString *)favouritesPlistPath {
    return [DOCUMENTS_FOLDER stringByAppendingPathComponent:FAVOURITES_PLIST_NAME];
}

@end
