//
//  TracksManager.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "BaseDataManager.h"


typedef void (^TracksByRouteAndDirectionsSuccessBlock)(NSArray *tracks);

@interface TracksManager : BaseDataManager

- (void)getTracksByRoutesIDsAndDirections: (NSArray *)routesWithDirections successHandler: (TracksByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)getTracksByRoutesIDs: (NSArray *)routes successHandler: (TracksByRouteAndDirectionsSuccessBlock)successHandler failHandler: (SimpleFailBlock)failHandler;
- (void)cancelGetTracks;

@end
