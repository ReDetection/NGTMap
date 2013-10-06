//
//  SimplePointTrack.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"

//Точка изгиба/поворота на трассе

@interface SimplePointTrack : DataObject

@property (assign, nonatomic) NSInteger order;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;

@end
