//
//  RatesViewController.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "RatesViewController.h"
#import "RateCell.h"

#import "NetworkManager.h"
#import "ReferenceRatesParser.h"

#import "NSObject+Additions.h"
#import "UITableView+Additions.h"

#import "ReferenceRates.h"
#import "Rate.h"

static NSString * const ReferenceListUrl = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@interface RatesViewController () <ReferenceRatesParserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) ReferenceRatesParser *parser;
@property (strong, nonatomic) ReferenceRates *referenceRates;

@end

@implementation RatesViewController

#pragma mark - Lifetime cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView AZ_registerNibWithName:[RateCell AZ_className]];
    [self getReferenceRates];
}

#pragma mark - Private methods

- (void)getReferenceRates {
    
    [self.activityIndicator startAnimating];
    
    [[NetworkManager sharedManager] downloadReferenceRatesWithURLString:ReferenceListUrl andSuccessHandler:^(NSURL *fileUrl) {
        
        self.parser = [[ReferenceRatesParser alloc] init];
        self.parser.delegate = self;
        [self.parser startWithUrl:fileUrl];
        
    } failureHandler:^(NSError *error) {
        
        [self.activityIndicator stopAnimating];
    }];
}

#pragma mark - ReferenceRatesParserDelegate

- (void)referenceRatesParser:(ReferenceRatesParser *)referenceRatesParser referenceRatesOwnerName:(NSString *)name time:(NSString *)time currency:(NSString *)currency andRate:(NSString *)rate {
    
    if (self.referenceRates) {
        
        Rate *rateObject = [[Rate alloc] initWithCurrency:currency andRate:rate];
        [self.referenceRates addRate:rateObject];
        
    } else {
        
        self.referenceRates = [[ReferenceRates alloc] initWithOwnerName:name andTime:time];
        
        Rate *rateObject = [[Rate alloc] initWithCurrency:currency andRate:rate];
        [self.referenceRates addRate:rateObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.title = self.referenceRates.ownerName;
            self.dateLabel.text = self.referenceRates.time;
        });
    }
}

- (void)stoppedReferenceRatesParser:(ReferenceRatesParser *)referenceRatesParser {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.activityIndicator stopAnimating];
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.referenceRates.rates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RateCell *cell =[tableView dequeueReusableCellWithIdentifier:[RateCell AZ_className]];
    
    if(!cell){
        
        cell = [[RateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[RateCell AZ_className]];
    }
    
    Rate *rate = [self.referenceRates.rates objectAtIndex:indexPath.row];
    
    cell.textLabel.text = rate.currency;
    cell.detailTextLabel.text = rate.rate;
    
    return cell;
}

#pragma mark - Actions

- (IBAction)refreshButtonAction:(UIBarButtonItem *)sender {
    
    [self getReferenceRates];
}

@end
