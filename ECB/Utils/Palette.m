//
//  Palette.m
//  ECB
//
//  Created by Alex Zbirnik on 26.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "Palette.h"

@implementation Palette

+ (UIColor *)whiteColor {
    
    return [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
}

+ (UIColor *)grayColor {
    
    return [UIColor lightGrayColor];
}

+ (UIColor *)redColor {
    
    return [UIColor redColor];
}

+ (UIColor *)blueColor {
    
    return [UIColor colorWithRed:0.02 green:0.20 blue:0.58 alpha:1.00];
}

+ (UIColor *)yellowColor {
    
    return [UIColor colorWithRed:1.00 green:0.95 blue:0.32 alpha:1.00];
}

@end
