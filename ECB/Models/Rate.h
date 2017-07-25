//
//  Rate.h
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rate : NSObject

@property (strong, nonatomic) NSString *currency;
@property (strong, nonatomic) NSString *rate;

- (instancetype)initWithCurrency:(NSString *)currency andRate:(NSString *)rate;

@end
