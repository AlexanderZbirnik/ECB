//
//  RateCell.h
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;


@end
