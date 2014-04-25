//
//  WeightCell.m
//  MyPantry
//
//  Created by Stephanie Le on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeightCell.h"

@implementation WeightCell
@synthesize weightText;
@synthesize weight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setItem:(NSDecimal *)newValue {
    NSLog(@"Inside setItem");
    //[newItem printItem];
    
    if (weight != newValue) {
        weight = newValue;
        NSLog(@"weight=%@d", weight);
    }
}

@end
