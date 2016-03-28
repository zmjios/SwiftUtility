//
//  UIView+CTPHelper.m
//  CTPay
//
//  Created by zmjios on 16/3/1.
//  Copyright © 2016年 ctrip. All rights reserved.
//

#import "UIView+CTPHelper.h"


@implementation UIImage (CTPHelper)

- (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners
{
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}


- (UIImage*)imageWithShadow
{
    CGFloat shadowRadius = 12.0;
    
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, self.size.width, self.size.height, CGImageGetBitsPerComponent(self.CGImage), 0,
                                                       colourSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, CGSizeMake(10, 10), shadowRadius, [UIColor blackColor].CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

@end


@implementation UIView (CTPHelper)

- (UIImage *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)addCorners:(UIRectCorner)corners cornerRadius:(CGFloat)raduis
{
    UIImage *image = [self snapshot];
    image = [image imageWithRoundedCornersAndSize:self.bounds.size andCornerRadius:raduis byRoundingCorners:corners];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = self.bounds;
    [self insertSubview:imageView atIndex:0];
}





@end
