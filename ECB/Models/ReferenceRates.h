//
//  ReferenceRates.h
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rate.h"

@interface ReferenceRates : NSObject

@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSArray *rates;

- (instancetype)initWithOwnerName:(NSString *)name andTime:(NSString *)time;
- (void)addRate:(Rate *)rate;

@end
