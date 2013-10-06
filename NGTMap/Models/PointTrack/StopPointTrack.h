//
//  StopPointTrack.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "SimplePointTrack.h"

//Остановка

@interface StopPointTrack : SimplePointTrack

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *platformIdentifier;
@property (assign, nonatomic) CGFloat length;

@end
