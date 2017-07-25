//
//  UITableView+Additions.m
//  ECB
//
//  Created by Alex Zbirnik on 25.07.17.
//  Copyright © 2017 Alex Zbirnik. All rights reserved.
//

#import "UITableView+Additions.h"

@implementation UITableView (Additions)

-(void)AZ_registerNibWithName:(NSString *)nibName {
    
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:nibName];
}

@end
