//
//  RouteDetailViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 16.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "RouteDetailViewController.h"
#import "Track.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RouteDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *routeTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *routeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeStopBeginLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeStopEndLabel;
@property (weak, nonatomic) IBOutlet UIButton *addToFavouritesButton;
@property (weak, nonatomic) IBOutlet UIButton *removeFromFavouritesButton;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRoutesLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSDictionary *routeTypeImageNames;

@property (strong, nonatomic) NSArray *transportUnits;
@property (strong, nonatomic) Track *track;

- (IBAction)addToFavouritesAction:(id)sender;
- (IBAction)removeFromFavouritesAction:(id)sender;
- (IBAction)showMapAction:(id)sender;


@end

@implementation RouteDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.routeTypeImageNames = @{[NSNumber numberWithInteger:BusRouteType]: @"routes_bus_icon.png", [NSNumber numberWithInteger:TrolleyBusRouteType]: @"routes_trolleybus_icon.png", [NSNumber numberWithInteger:TramRouteType]: @"routes_trambus_icon.png", [NSNumber numberWithInteger:MicroBusRouteType]: @"routes_microbus_icon.png"};
    
    NSArray *routesArray = @[_route.identifier];
    [[ServiceProvider sharedProvider] getTransportUnitsByRoutes:routesArray successHandler:^(NSArray *transportUnits) {
        NSPredicate *filterOnlinePredictate = [NSPredicate predicateWithFormat:@"offlineStatus == %d", OnlineTransportUnitWorkStatus];
        _transportUnits = [transportUnits filteredArrayUsingPredicate:filterOnlinePredictate];
        _numberOfRoutesLabel.text = [NSString stringWithFormat:@"%d", _transportUnits.count];
    } failHandler:^(NSError *error) {
        
    }];
    
    [[ServiceProvider sharedProvider] getTracksByRoutes:routesArray successHandler:^(NSArray *tracks) {
        _track = routesArray[0];
    } failHandler:^(NSError *error) {

    }];
    
    [self.mapView setRegion:NOVOSIBIRSK_COORDINATES_REGION];
    
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.title = @"Title";
    annot.coordinate = CLLocationCoordinate2DMake(55.033333, 82.916667);
    [self.mapView addAnnotation:annot];
	
    [self updateData];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self isMovingFromParentViewController]) {
        [[ServiceProvider sharedProvider] cancelRequestForPath:kTransportUnitsByIdsPath];
        [[ServiceProvider sharedProvider] cancelRequestForPath:kTracksByIdsPath];
    }
}

- (void)updateData {
    NSString *imageTypeName = [_routeTypeImageNames objectForKey:_route.type];
    self.routeTypeImageView.image = [UIImage imageNamed:imageTypeName];
    
    self.routeTitleLabel.text = _route.title;
    self.routeStopBeginLabel.text = _route.stopBegin;
    self.routeStopEndLabel.text = _route.stopEnd;
    
    [self updateFavouiritesButtons];
}

#pragma mark - Actions

- (IBAction)addToFavouritesAction:(id)sender {
    [[DataManager sharedManager].favouritesStorage addRouteID:_route.identifier];
    [self updateFavouiritesButtons];
}

- (IBAction)removeFromFavouritesAction:(id)sender {
    [[DataManager sharedManager].favouritesStorage removeRouteID:_route.identifier];
    [self updateFavouiritesButtons];
}

- (IBAction)showMapAction:(id)sender {
}


#pragma mark - Private methods

- (void)updateFavouiritesButtons {
    if ([[DataManager sharedManager].favouritesStorage isContainRouteID:_route.identifier]) {
        self.addToFavouritesButton.hidden = YES;
        self.removeFromFavouritesButton.hidden = NO;
    } else {
        self.addToFavouritesButton.hidden = NO;
        self.removeFromFavouritesButton.hidden = YES;
    }
}

@end
