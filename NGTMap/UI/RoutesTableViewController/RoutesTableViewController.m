//
//  RoutesTableViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "RoutesTableViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>

NSString *const kRouteDetailViewControllerIdentifier = @"showRouteDetailIdentifier";

@interface RoutesTableViewController ()

@end

@implementation RoutesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    //TODO вынести в отдельное место
    self.routeTypeImageNames = @{[NSNumber numberWithInteger:BusRouteType]: @"routes_bus_icon.png", [NSNumber numberWithInteger:TrolleyBusRouteType]: @"routes_trolleybus_icon.png", [NSNumber numberWithInteger:TramRouteType]: @"routes_trambus_icon.png", [NSNumber numberWithInteger:MicroBusRouteType]: @"routes_microbus_icon.png"};
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateData];
    
}

- (void)updateData {
    self.routes = [[RoutesManager sharedManager] getAllRoutesSuccessHandler:^(NSArray *routes) {
        [SVProgressHUD dismiss];
        self.routes = routes;
        [self.tableView reloadData];
    } failHandler:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    if (_routes) {
        [self.tableView reloadData];
    } else {
        [SVProgressHUD showWithStatus:@"Загрузка..." maskType:SVProgressHUDMaskTypeGradient];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kRouteDetailViewControllerIdentifier]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RouteDetailViewController *routeDetailVC =  [segue destinationViewController];
        routeDetailVC.route = _routes[indexPath.row];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoutesTableViewCell *cell = [RoutesTableViewCell createTableViewCellForTable:tableView];
    cell.delegate = self;
    Route *route = _routes[indexPath.row];
    cell.routeTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",route.title, route.oldTitle];
    cell.routeStopBeginLabel.text = route.stopBegin;
    cell.routeStopEndLabel.text = route.stopEnd;
    
    NSString *imageTypeName = [_routeTypeImageNames objectForKey:route.type];
    cell.routeTypeImageView.image = [UIImage imageNamed:imageTypeName];
    
    [self updateFavouiritesButtonsForCell:cell withRoute:route];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kRouteDetailViewControllerIdentifier sender:nil];
}

#pragma mark - RoutesTableViewCellDelegate

- (void)routesTableViewCellFavouriteAction:(RoutesTableViewCell *)cell {
    
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    
    Route *route = _routes[index];
    if ([[FavoritesManager sharedManager] isFavoriteRoute:route]) {
        [[FavoritesManager sharedManager] removeRoute:route];
    } else {
        [[FavoritesManager sharedManager] addRoute:route];
    }

    [self updateFavouiritesButtonsForCell:cell withRoute:route];
}

#pragma mark - Private methods

- (void)updateFavouiritesButtonsForCell: (RoutesTableViewCell *)cell withRoute: (Route *)route{
    NSString *favoriteButtonTitle = [[FavoritesManager sharedManager] isFavoriteRoute:route] ? @"Удалить" : @"Добавить";
    [cell.favoriteButton setTitle:favoriteButtonTitle forState:UIControlStateNormal];
}


@end
