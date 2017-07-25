//
//  NSString+Additions.m
//  ECB
//
//  Created by Alex Zbirnik on 26.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)AZ_convertToLocalDateFormat {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *date = [formatter dateFromString:self];
    
    formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    formatter.dateStyle = kCFDateFormatterMediumStyle;
    
    NSString *localDate = [formatter stringFromDate:date];
    
    return localDate;
}

@end
