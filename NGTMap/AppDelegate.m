//
//  AppDelegate.m
//  NGTMap
//
//  Created by Alexey Bromot on 03.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "AppDelegate.h"
#import "FavoritesManager.h"

#import <RestKit/RestKit.h>
#import <GoogleMaps/GoogleMaps.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRestKit];
    [self setupMap];
    [self setupGUI];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FavoritesManager sharedManager] load];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[FavoritesManager sharedManager] save];
}

- (void)setupGUI {
}

- (void)setupMap {
    [GMSServices provideAPIKey:kGoogleApiKey];
}

- (void)setupRestKit {
    NSURL *baseURL = [NSURL URLWithString:kServerAddress];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    client.allowsInvalidSSLCertificate = YES;
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKObjectManager setSharedManager:objectManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [[RKObjectManager sharedManager] setRequestSerializationMIMEType:RKMIMETypeJSON];
}

@end
