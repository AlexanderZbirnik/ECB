//
//  NetworkManager.h
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;
- (void)downloadReferenceRatesWithURLString:(NSString *)urlString andSuccessHandler:(void(^)(NSURL *fileUrl))success failureHandler:(void(^)(NSError *error))failure;

@end
