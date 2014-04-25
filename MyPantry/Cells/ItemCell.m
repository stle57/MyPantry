
/*
     File: ItemCell.m
  */

#import "ItemCell.h"
#import "Item.h"
#import "HighlightingTextView.h"

@implementation ItemCell

@synthesize itemLabel, quantityLabel, item;


- (void)setItem:(Item *)newItem {
    NSLog(@"Inside setItem");
    [newItem printItem];
    
    if (item != newItem) {
        item = newItem;
        NSLog(@"item.name=%@", item.name);
        itemLabel.text = item.name;
        quantityLabel.text = @"(3)";
        //quotationTextView.text = quotation.quotation;
    }
}
@end
