//
//  RoutesTableViewCell.m
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "RoutesTableViewCell.h"

@implementation RoutesTableViewCell

- (IBAction)favoriteAction:(id)sender {
    [_delegate routesTableViewCellFavouriteAction:self];
}

@end
