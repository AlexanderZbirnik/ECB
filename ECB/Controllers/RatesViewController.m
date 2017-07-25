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

static NSString * const ReferenceListUrl = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@interface RatesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RatesViewController

#pragma mark - Lifetime cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView AZ_registerNibWithName:[RateCell AZ_className]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    RateCell *cell =[tableView dequeueReusableCellWithIdentifier:[RateCell AZ_className]];
    
    if(!cell){
        
        cell = [[RateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[RateCell AZ_className]];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"#%zd", indexPath.row];
    
    return cell;
}

#pragma mark - Actions

- (IBAction)refreshButtonAction:(UIBarButtonItem *)sender {
}

@end
