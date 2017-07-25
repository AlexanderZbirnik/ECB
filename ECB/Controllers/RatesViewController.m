//
//  RatesViewController.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "RatesViewController.h"
#import "RateCell.h"
#import "Palette.h"

#import "NetworkManager.h"
#import "ReferenceRatesParser.h"
#import "Reachability.h"

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

@property (nonatomic) Reachability *internetReachability;

@end

@implementation RatesViewController

#pragma mark - Lifetime cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    [self.tableView AZ_registerNibWithName:[RateCell AZ_className]];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark - Private methods

- (void)getReferenceRates {
    
    [self.activityIndicator startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[NetworkManager sharedManager] downloadReferenceRatesWithURLString:ReferenceListUrl andSuccessHandler:^(NSURL *fileUrl) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        self.parser = [[ReferenceRatesParser alloc] init];
        self.parser.delegate = self;
        
        [self.parser startWithUrl:fileUrl];
        
    } failureHandler:^(NSError *error) {
        
        [self.activityIndicator stopAnimating];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    
    if (reachability == self.internetReachability) {
        
        NetworkStatus networkStatus = [reachability currentReachabilityStatus];
        
        if (networkStatus == NotReachable) {
            
            self.dateLabel.backgroundColor = [Palette grayColor];
            self.dateLabel.textColor = [Palette redColor];
            
            [self openAlertWithTitle:@"Attention!" andMessage:@"Check your internet connection"];
            
        } else {
            
            self.dateLabel.backgroundColor = [Palette blueColor];
            self.dateLabel.textColor = [Palette yellowColor];
            [self getReferenceRates];
        }
    }
}

- (void)openAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController.view setTintColor:[Palette blueColor]];
    
    UIAlertAction *okAction =
    [UIAlertAction actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                           handler:nil];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:^{
        
        [alertController.view setTintColor:[Palette blueColor]];
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
    
    cell.currencyLabel.text = rate.currency;
    cell.rateLabel.text = rate.rate;
    
    return cell;
}

#pragma mark - Actions

- (IBAction)refreshButtonAction:(UIBarButtonItem *)sender {
    
    [self updateInterfaceWithReachability:self.internetReachability];
}

#pragma mark - Notification

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void) reachabilityChanged:(NSNotification *)notification {
    
    Reachability* currentReachibility = notification.object;
    [self updateInterfaceWithReachability:currentReachibility];
}


@end
