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
@required

- (void)referenceRatesParser:(ReferenceRatesParser *)referenceRatesParser referenceRatesOwnerName:(NSString *)name date:(NSString *)date currency:(NSString *)currency andRate:(NSString *)rate;

@optional

- (void)startedReferenceRatesParser:(ReferenceRatesParser *)referenceRatesParser;
- (void)stoppedReferenceRatesParser:(ReferenceRatesParser *)referenceRatesParser;

@end
