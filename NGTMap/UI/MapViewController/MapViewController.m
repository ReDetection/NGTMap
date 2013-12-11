//
//  MapViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "MapViewController.h"
#import "Track.h"
#import "Route.h"
#import "StopTrackPoint.h"
#import "TransportUnit.h"
#import "TracksManager.h"
#import "TransportUnitsManager.h"
#import "UIImage+Extensions.h"

#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mapContentView;

@property (strong, nonatomic) GMSMapView *mapView;

@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSArray *transportUnits;

@property (strong, nonatomic) NSArray *routesColors;

@end

@implementation MapViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if (IS_IOS7)
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    //Map configuration
    GMSCameraPosition *cameraPosition =  [GMSCameraPosition cameraWithTarget:NOVOSIBIRSK_CLLocationCoordinate2D zoom:11];
    self.mapView = [GMSMapView mapWithFrame:_mapContentView.bounds camera:cameraPosition];
    _mapView.delegate = self;
    _mapView.myLocationEnabled = YES;
    [self.mapContentView addSubview:_mapView];
    
    self.routesColors = @[[UIColor purpleColor], [UIColor greenColor], [UIColor blueColor], [UIColor redColor],[UIColor brownColor], [UIColor magentaColor], [UIColor lightGrayColor]];
    
    [self updateTracks];
    [self updateTransportUnits];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isMovingFromParentViewController]) {
        [[TracksManager sharedManager] cancelGetTracks];
        [[TransportUnitsManager sharedManager] cancelGetTransportUnits];
    }
}

- (void)updateTracks {
    
    NSMutableArray *routeIDs = [NSMutableArray arrayWithCapacity:_routes.count];
    [_routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Route *route = obj;
        [routeIDs addObject:route.identifier];
    }];
    
    [[TracksManager sharedManager] getTracksByRoutesIDs:routeIDs successHandler:^(NSArray *tracks) {
        _tracks = tracks;
        
        [_tracks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Track *track = obj;
            
            GMSMutablePath *path = [GMSMutablePath path];
            [track.trackPoints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                StopTrackPoint *stopTrackPoint = obj;
                [path addLatitude:stopTrackPoint.latitude longitude:stopTrackPoint.longitude];
            }];
            
            GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeColor = _routesColors[idx];
            polyline.strokeWidth = 3.0f;
            polyline.map = _mapView;
        }];
        
    } failHandler:^(NSError *error) {
        
    }];
}

- (void)updateTransportUnits {
    NSMutableArray *routeIDs = [NSMutableArray arrayWithCapacity:_routes.count];
    [_routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Route *route = obj;
        [routeIDs addObject:route.identifier];
    }];
    
    [[TransportUnitsManager sharedManager] getTransportUnitsByRoutesIDs:routeIDs successHandler:^(NSArray *transportUnits) {
        _transportUnits = transportUnits;
        
        [_transportUnits enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TransportUnit *transportUnit = obj;
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(transportUnit.latitude, transportUnit.longitude);
            marker.icon = [[UIImage imageNamed:@"arrow"] imageRotatedByDegrees:transportUnit.azimuth];
            marker.map = _mapView;
        }];
    } failHandler:^(NSError *error) {
        
    }];
}

#pragma mark - GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {

    
    return NO;
}


@end
