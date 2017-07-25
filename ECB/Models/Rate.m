//
//  Rate.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "Rate.h"

@implementation Rate

- (instancetype)initWithCurrency:(NSString *)currency andRate:(NSString *)rate
{
    self = [super init];
    if (self) {
        
        self.currency = currency;
        self.rate = rate;
    }
    return self;
}

@end
