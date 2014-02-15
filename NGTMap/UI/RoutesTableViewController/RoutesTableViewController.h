//
//  RoutesTableViewController.h
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoutesTableViewCell.h"
#import "RouteDetailViewController.h"
#import "Route.h"
#import "RoutesManager.h"
#import "FavoritesManager.h"

@interface RoutesTableViewController : UITableViewController <RoutesTableViewCellDelegate>

@property (strong, nonatomic) NSArray *routes;

- (void)routesTableViewCellFavouriteAction: (RoutesTableViewCell *)cell;
- (void)updateData;

@end
