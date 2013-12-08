//
//  RoutesTableViewCell.h
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoutesTableViewCell;

@protocol RoutesTableViewCellDelegate <NSObject>

@required
- (void)routesTableViewCellFavouriteAction: (RoutesTableViewCell *)cell;

@end

@interface RoutesTableViewCell : UITableViewCell

@property (weak, nonatomic) id <RoutesTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *routeTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *routeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeStopBeginLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeStopEndLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;



@end
