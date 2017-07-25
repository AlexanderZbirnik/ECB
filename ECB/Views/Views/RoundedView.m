//
//  RoundedView.m
//  ECB
//
//  Created by Alex Zbirnik on 26.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat radius = CGRectGetWidth(self.bounds) / 2;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

@end
