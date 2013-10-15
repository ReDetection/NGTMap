//
//  DataManager.h
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavouritesStorage.h"
#import "MapStorage.h"

@interface DataManager : NSObject

@property (strong, nonatomic) NSArray *routes;
@property (strong, nonatomic) FavouritesStorage *favouritesStorage;
@property (strong, nonatomic) MapStorage *mapStorage;

+ (DataManager *)sharedManager;

@end
