//
//  NetworkManager.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager () <NSURLSessionDelegate>

@end

@implementation NetworkManager

+ (instancetype)sharedManager {
    
    static id sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (void)downloadReferenceRatesWithURLString:(NSString *)urlString andSuccessHandler:(void(^)(NSURL *fileUrl))success failureHandler:(void(^)(NSError *error))failure {
    
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    
    NSURL* downloadTaskURL = [NSURL URLWithString:urlString];
    
    [[session downloadTaskWithURL: downloadTaskURL
                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                    
                    if (error && failure) {
                        
                        failure(error);
                        
                    } else {
                        
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        
                        NSArray *urls = [fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
                        NSURL *documentsDirectory = [urls objectAtIndex:0];
                        
                        NSURL *originalUrl = [NSURL URLWithString:[downloadTaskURL lastPathComponent]];
                        NSURL *destinationUrl = [documentsDirectory URLByAppendingPathComponent:[originalUrl lastPathComponent]];
                        NSError *fileManagerError;
                        
                        [fileManager removeItemAtURL:destinationUrl error:NULL];
                        [fileManager copyItemAtURL:location toURL:destinationUrl error:&fileManagerError];
                        
                        if (fileManagerError && failure) {
                            
                            failure(fileManagerError);
                            
                        } else {
                            
                            if (success) {
                                
                                success(destinationUrl);
                            }
                        }
                    }
                    
                }] resume];

}

@end
