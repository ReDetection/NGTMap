//
//  ServiceProvider.h
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AllRoutesSuccessBlock)(NSArray *routes);
typedef void (^AllRoutesSuccessBlock)(NSArray *routes);

@interface ServiceProvider : NSObject

+ (ServiceProvider *)sharedProvider;
- (void)configureMappings;

- (void)getAllRoutesSuccessHandler: (AllRoutesSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;

@end
