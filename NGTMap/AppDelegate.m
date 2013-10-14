//
//  AppDelegate.m
//  NGTMap
//
//  Created by Alexey Bromot on 03.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[ServiceProvider sharedProvider] configureMappings];
    
    return YES;
}
							

@end