//
//  RatesViewController.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "RatesViewController.h"

@interface RatesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RatesViewController

#pragma mark - Lifetime cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Actions

- (IBAction)refreshButtonAction:(UIBarButtonItem *)sender {
}

@end
