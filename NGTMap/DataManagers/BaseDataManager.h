//
//  BaseDataManager.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDataManager : NSObject {
    NSDictionary *_baseRequestParams;
}

+ (instancetype)sharedManager;
- (void)cancelRequestForPath: (NSString *)path;

- (NSString *)formattedStringFromArray: (NSArray *)array;

@end
