//
//  ReferenceRates.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "ReferenceRates.h"
#import "NSString+Additions.h"

@implementation ReferenceRates

- (instancetype)initWithOwnerName:(NSString *)name andTime:(NSString *)time
{
    self = [super init];
    if (self) {
        
        self.ownerName = name;
        self.time = [time AZ_convertToLocalDateFormat];
        self.rates = [[NSArray alloc] init];
    }
    return self;
}

- (void)addRate:(Rate *)rate {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.rates];
    [array addObject:rate];
    self.rates = array;
}

@end
