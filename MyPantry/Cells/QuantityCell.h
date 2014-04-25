//
//  QuantityCell.h
//  MyPantry
//
//  Created by Stephanie Le on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuantityCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextField *quantityText;
@property (nonatomic, strong) NSNumber * quantity;

@end
