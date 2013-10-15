//
//  DataManager.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataManager.h"

static DataManager *instance = nil;

@implementation DataManager

+ (DataManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.favouritesStorage = [[FavouritesStorage alloc] init];
        self.mapStorage = [[MapStorage alloc] init];
    }
    
    return self;
}

@end
