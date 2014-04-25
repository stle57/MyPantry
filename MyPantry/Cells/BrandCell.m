//
//  BrandCell.m
//  MyPantry
//
//  Created by Stephanie Le on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandCell.h"

@implementation BrandCell

@synthesize brandText;
@synthesize brand;

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

- (void)setItem:(NSString *)newValue {
    NSLog(@"Inside setItem");
    //[newItem printItem];
    
    if (brand != newValue) {
        brand = newValue;
        NSLog(@"brand=%@", brand);
    }
}

@end
