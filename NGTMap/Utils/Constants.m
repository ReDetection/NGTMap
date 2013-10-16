//
//  Constants.m
//  CouchCall
//
//  Created by Mac Developer on 15.08.13.
//  Copyright (c) 2013 Magora-Systems. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const kServerAddress = @"http://api.nskgortrans.ru";
NSString *const kServerApiVersion = @"0.3";
NSString *const kServerApiKey = @"1281ecb12bc158e445c20996f67ad8a0";
NSString *const kServerApiFormat = @"json";

NSString *const kCustomValueInPath = @":value";

NSString *const kRoutesPath = @"/route/list/all";
NSString *const kTransportUnitsByIdsPath = @"/marker/list/ids/:value";

@end
