//
//  FavouritesTableViewController.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "FavouritesTableViewController.h"

@interface FavouritesTableViewController ()

@end

@implementation FavouritesTableViewController

- (void)updateData {
    self.routes = [FavoritesManager sharedManager].routes;
    [self.tableView reloadData];
}

- (void)routesTableViewCellFavouriteAction:(RoutesTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Route *route =  self.routes[indexPath.row];
    [[FavoritesManager sharedManager] removeRoute:route];
    self.routes = [FavoritesManager sharedManager].routes;
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
