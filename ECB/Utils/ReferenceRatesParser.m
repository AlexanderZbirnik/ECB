//
//  ReferenceRatesParser.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "ReferenceRatesParser.h"

static NSString * const ReferenceRatesElementNameGesmesName = @"gesmes:name";
static NSString * const ReferenceRatesElementNameCube = @"Cube";
static NSString * const ReferenceRatesElementNameTime = @"time";
static NSString * const ReferenceRatesElementNameCurrency = @"currency";
static NSString * const ReferenceRatesElementNameRate = @"rate";

static NSString * const ReferenceRatesParserEmptyString = @"";

@interface ReferenceRatesParser() <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser *xmlParser;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *currency;
@property (strong, nonatomic) NSString *rate;
@property (assign, nonatomic) BOOL isName;

@end

@implementation ReferenceRatesParser

- (void)startWithUrl:(NSURL *)url {
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    self.xmlParser = [[NSXMLParser alloc] initWithData:data];
    self.xmlParser.delegate = self;
    self.xmlParser.shouldResolveExternalEntities = NO;
    
    [self.xmlParser parse];
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    self.name = ReferenceRatesParserEmptyString;
    self.date = ReferenceRatesParserEmptyString;
    self.currency = ReferenceRatesParserEmptyString;
    self.rate = ReferenceRatesParserEmptyString;
    self.isName = NO;
    
    [self.delegate startedReferenceRatesParser:self];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:ReferenceRatesElementNameGesmesName]) {
        
        self.isName = YES;
        
    } else if ([elementName isEqualToString:ReferenceRatesElementNameCube]) {
        
        if ([attributeDict objectForKey: ReferenceRatesElementNameTime]) {
            
            self.date = [attributeDict objectForKey:ReferenceRatesElementNameTime];
            
        } else if ([attributeDict objectForKey:ReferenceRatesElementNameCurrency]) {
            
            self.currency = [attributeDict objectForKey:ReferenceRatesElementNameCurrency];
            self.rate = [attributeDict objectForKey:ReferenceRatesElementNameRate];
        }
    }
    
    BOOL nameNotEmpty = ![self.name isEqualToString:ReferenceRatesParserEmptyString];
    BOOL dateNotEmpty = ![self.date isEqualToString:ReferenceRatesParserEmptyString];
    BOOL currencyNotEmpty = ![self.currency isEqualToString:ReferenceRatesParserEmptyString];
    BOOL rateNotEmpty = ![self.rate isEqualToString:ReferenceRatesParserEmptyString];
    
    if (nameNotEmpty && dateNotEmpty && currencyNotEmpty && rateNotEmpty) {
        
        [self.delegate referenceRatesParser:self referenceRatesOwnerName:self.name date:self.date currency:self.currency andRate:self.rate];
        self.currency = ReferenceRatesParserEmptyString;
        self.rate = ReferenceRatesParserEmptyString;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (self.isName) {
        
        self.name = [NSString stringWithFormat:@"%@%@", self.name, string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:ReferenceRatesElementNameGesmesName]) {
        
        self.isName = NO;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.delegate stoppedReferenceRatesParser:self];
    
}

@end
