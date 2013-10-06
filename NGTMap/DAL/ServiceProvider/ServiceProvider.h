//
//  ServiceProvider.h
//  NGTMap
//
//  Created by Alexey Bromot on 04.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceProvider : NSObject

+ (ServiceProvider *)sharedProvider;

- (void)configureMappings;

@end
