//
//  RoutesManager.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "BaseDataManager.h"

typedef void (^AllRoutesSuccessBlock)(NSArray *routes);

@interface RoutesManager : BaseDataManager

- (void)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

@end
