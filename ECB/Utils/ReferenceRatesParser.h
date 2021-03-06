//
//  ReferenceRatesParser.h
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReferenceRatesParserDelegate;

@interface ReferenceRatesParser : NSObject

- (void)startWithUrl:(NSURL *)url;

@property (weak, nonatomic) id <ReferenceRatesParserDelegate> delegate;

@end

@protocol ReferenceRatesParserDelegate

@optional

- (void)stoppedReferenceRatesParser:(ReferenceRatesParser *)referenceRatesParser;

@required

- (void)referenceRatesParser:(ReferenceRatesParser *)referenceRatesParser referenceRatesOwnerName:(NSString *)name time:(NSString *)time currency:(NSString *)currency andRate:(NSString *)rate;



@end
