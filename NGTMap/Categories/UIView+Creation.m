//
//  UIView+Creation.m
//  Recording Application
//
//  Created by Bromot Aleksey on 28.06.13.
//  Copyright (c) 2013 Magora-Systems. All rights reserved.
//

#import "UIView+Creation.h"
#import "NSObject-ClassName.h"

#define isIPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0)

@implementation UIView (Creation)

+ (id) createView {
    
    NSString *nibName = [self className];
    
    return [self createViewWithNibname:nibName];
}

+ (id) createViewWithNibname: (NSString *)nibName {
    if (isIPhone5) {
        NSString *fileNameWithoutExt = [self className];
        NSString *xibName = [NSString stringWithFormat:@"%@~568h", fileNameWithoutExt];
        if ([[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"])
            nibName = xibName;
    }
    
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:0];
}

@end
