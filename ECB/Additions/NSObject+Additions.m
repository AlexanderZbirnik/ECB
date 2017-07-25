//
//  NSObject+Additions.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

+ (NSString *)AZ_className {
  
  return NSStringFromClass([self class]);
}

@end
