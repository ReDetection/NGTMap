//
//  GroupRoutes.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.12.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"

@interface GroupRoutes : DataObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *routesIDs;

@end
