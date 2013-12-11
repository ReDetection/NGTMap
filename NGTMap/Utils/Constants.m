//
//  Constants.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const kServerAddress = @"https://api.nskgortrans.ru";
NSString *const kServerApiVersion = @"0.3";
NSString *const kServerApiKey = @"1281ecb12bc158e445c20996f67ad8a0";
NSString *const kServerApiFormat = @"json";

NSString *const kCustomValueInPath = @":value";

NSString *const kRoutesPath = @"/route/list/all";
NSString *const kTransportUnitsByIdsPath = @"/marker/list/ids/:value";
NSString *const kTracksByIdsPath = @"/trassa/list/ids/:value";

NSString *const kGoogleApiKey = @"AIzaSyA6FO8Wsh7PvX2aEQD--xehZQhHSq2fp1k";
NSInteger const kMaxRoutesOnMap = 7;

@end
