//
//  FavoritesManager.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "FavoritesManager.h"

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

}

- (void)load {

}

- (void)addRoute: (Route *)route {
    
}

- (void)removeRoute: (Route *)route {
    
}

- (void)addGroupRoutes: (GroupRoutes *)group {
    
}

- (void)removeGroupRoutes: (GroupRoutes *)group {
    
}

- (NSArray *)routes {
    
}

- (NSArray *)groupsRoutes {
    
}

#pragma mark - Private methods

- (NSString *)fullFavouritesPlistPath {
    return [DOCUMENTS_FOLDER stringByAppendingPathComponent:kFavoritesPlist];
}

@end
