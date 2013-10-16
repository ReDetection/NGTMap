//
//  RoutesTableViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "RoutesTableViewController.h"
#import "RoutesTableViewCell.h"
#import "RouteDetailViewController.h"
#import "Route.h"

#define ROUTES_TABLEVIEW_CELL_IDENTIFIER @"RoutesCellIdentifier"

#define ROUTE_DETAIL_SEQUE_IDENTIFIER @"showRouteDetailIdentifier"

@interface RoutesTableViewController ()

@property (strong, nonatomic) NSDictionary *routeTypeImageNames;
@property (strong, nonatomic) NSArray *routes;

- (IBAction)addToFavouriteAction:(id)sender;
- (IBAction)removeFromFavouritesAction:(id)sender;

@end

@implementation RoutesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.routeTypeImageNames = @{[NSNumber numberWithInteger:BusRouteType]: @"routes_bus_icon.png", [NSNumber numberWithInteger:TrolleyBusRouteType]: @"routes_trolleybus_icon.png", [NSNumber numberWithInteger:TramRouteType]: @"routes_trambus_icon.png", [NSNumber numberWithInteger:MicroBusRouteType]: @"routes_microbus_icon.png"};
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateData];
}

- (void)updateData {
    self.routes = [DataManager sharedManager].routes;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoutesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ROUTES_TABLEVIEW_CELL_IDENTIFIER forIndexPath:indexPath];
    cell.addToFavouritesButton.tag = indexPath.row;
    cell.removeFromFavouritesButton.tag = indexPath.row;
    
    Route *route = _routes[indexPath.row];
    cell.routeTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",route.title, route.oldTitle];
    cell.routeStopBeginLabel.text = route.stopBegin;
    cell.routeStopEndLabel.text = route.stopEnd;
    
    NSString *imageTypeName = [_routeTypeImageNames objectForKey:route.type];
    cell.routeTypeImageView.image = [UIImage imageNamed:imageTypeName];
    
    [self updateFavouiritesButtonsForCell:cell withRoute:route];
    
    return cell;
}

#pragma mark - Cell Actions

- (IBAction)addToFavouriteAction:(id)sender {
    NSInteger tag = ((UIButton *)sender).tag;
    
    Route *route = _routes[tag];
    [[DataManager sharedManager].favouritesStorage addRouteID:route.identifier];
    
    RoutesTableViewCell *cell = (RoutesTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0]];
    [self updateFavouiritesButtonsForCell:cell withRoute:route];
}

- (IBAction)removeFromFavouritesAction:(id)sender {
    NSInteger tag = ((UIButton *)sender).tag;
    
    Route *route = _routes[tag];
    [[DataManager sharedManager].favouritesStorage removeRouteID:route.identifier];
    
    RoutesTableViewCell *cell = (RoutesTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0]];
    [self updateFavouiritesButtonsForCell:cell withRoute:route];
}


#pragma mark - Private methods

- (void)updateFavouiritesButtonsForCell: (RoutesTableViewCell *)cell withRoute: (Route *)route{
    if ([[DataManager sharedManager].favouritesStorage isContainRouteID:route.identifier]) {
        cell.addToFavouritesButton.hidden = YES;
        cell.removeFromFavouritesButton.hidden = NO;
    } else {
        cell.addToFavouritesButton.hidden = NO;
        cell.removeFromFavouritesButton.hidden = YES;
    }
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ROUTE_DETAIL_SEQUE_IDENTIFIER]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RouteDetailViewController *routeDetailVC =  [segue destinationViewController];
        routeDetailVC.route = _routes[indexPath.row];
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
