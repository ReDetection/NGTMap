//
//  Utility.m
//  ngtmap
//
//  Created by ReDetection on 3/2/13.
//

#import "Utility.h"

@implementation Utility


+ (UIImage *)resizableImageNamed: (NSString *)filename {
    UIImage *image = [UIImage imageNamed:filename];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(15, 5, 15, 5)];
    } else {
        image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:15];
    }
    return image;
}

+ (UIImage *)carWithAngle:(double)radians andColor:(UIColor *)fillColor {
    double peakX = 13 * cos(radians);
    double peakY = 13 * sin(radians);
    double tailLX = 18.62 * cos(radians + M_PI_2 + M_PI_4);
    double tailLY = 18.62 * sin(radians + M_PI_2 + M_PI_4);

    UIGraphicsBeginImageContext(CGSizeMake(40,40));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(ctx,YES);

    // arrow shape
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 20+peakX, 20+peakY);
    CGContextAddLineToPoint(ctx, 20+tailLX, 20+tailLY);
    CGContextAddLineToPoint(ctx, 20-0.5*peakX, 20-0.5*peakY);
    CGContextAddLineToPoint(ctx, 20-tailLY, 20+tailLX);
    CGContextClosePath(ctx);
    CGPathRef path = CGContextCopyPath(ctx);

    // fill shape
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextFillPath(ctx);

    // remind shape
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 20+peakX, 20-peakY);
    CGContextAddPath(ctx, path);
    CGContextClosePath(ctx);
    CGPathRelease(path);

    // draw border
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
    CGContextSetLineWidth(ctx,1.5);
    CGContextStrokePath(ctx);

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext(); //retain?
    UIGraphicsEndImageContext();
    return [[result retain] autorelease];
}

@end
