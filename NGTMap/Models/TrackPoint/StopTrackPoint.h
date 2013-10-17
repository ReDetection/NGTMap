//
//  StopTrackPoint.h
//  NGTMap
//
//  Created by Bromot Alexey on 17.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "SimpleTrackPoint.h"

//Остановка

@interface StopTrackPoint : SimpleTrackPoint

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *platformIdentifier;
@property (assign, nonatomic) CGFloat length;

@end
