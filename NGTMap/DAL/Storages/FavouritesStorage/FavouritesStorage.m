//
//  FavouritesStorage.m
//  NGTMap
//
//  Created by Bromot Alexey on 15.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "FavouritesStorage.h"

#define FAVOURITES_PLIST_NAME @"favourites.plist"

@interface FavouritesStorage()

@property (strong, nonatomic) NSMutableArray *favouritesRoutes;

@end

@implementation FavouritesStorage

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

- (NSArray *)favouritesRoutes {
    return [NSArray arrayWithArray:_favouritesRoutes];
}

- (void)addRouteID: (NSString *)routeID {
    [_favouritesRoutes addObject:routeID];
    [self save];
}
- (void)removeRouteID: (NSString *)routeID {
    [_favouritesRoutes removeObject:routeID];
    [self save];
}

- (BOOL)isContainRouteID: (NSString *)routeID {
    return [_favouritesRoutes containsObject:routeID];
}


#pragma mark - Private methods

- (void)save {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_favouritesRoutes writeToFile:[self favouritesPlistPath] atomically:YES];
    });
}

- (NSString *)favouritesPlistPath {
    return [DOCUMENTS_FOLDER stringByAppendingPathComponent:FAVOURITES_PLIST_NAME];
}

@end
