//
//  RoutesManager.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "BaseDataManager.h"
#import "Route.h"

typedef void (^AllRoutesSuccessBlock)(NSArray *routes);

@interface RoutesManager : BaseDataManager

- (NSArray *)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

- (Route *)routeWithID: (NSString *)identifier;

@end
