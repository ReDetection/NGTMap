//
//  RoutesTableViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "RoutesTableViewController.h"
#import "MapViewController.h"
#import "NSObject-ClassName.h"
#import <SVProgressHUD/SVProgressHUD.h>

NSString *const kShowMapViewControllerIdentifier = @"showMapViewControllerIdentifier";

@interface RoutesTableViewController ()

@end

@implementation RoutesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    [self.tableView registerNib:[UINib nibWithNibName:[RoutesTableViewCell className] bundle:nil] forCellReuseIdentifier:[RoutesTableViewCell className]];
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
    if ([segue.identifier isEqualToString:kShowMapViewControllerIdentifier]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MapViewController *mapVC =  [segue destinationViewController];
        mapVC.routes = @[_routes[indexPath.row]];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoutesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RoutesTableViewCell className] forIndexPath:indexPath];
    cell.delegate = self;
    Route *route = _routes[indexPath.row];
    cell.routeTitleLabel.text = [NSString stringWithFormat:@"%@%@",route.title, route.oldTitle == nil ? @"" : [NSString stringWithFormat:@" (%@)",route.oldTitle]];
    cell.routeStopBeginLabel.text = route.stopBegin;
    cell.routeStopEndLabel.text = route.stopEnd;
    
    NSString *imageTypeName = ROUTE_TYPE_IMAGE_NAMES[route.type];
    cell.routeTypeImageView.image = [UIImage imageNamed:imageTypeName];
    
    [self updateFavouiritesButtonsForCell:cell withRoute:route];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kShowMapViewControllerIdentifier sender:nil];
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
