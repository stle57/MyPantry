
/*
     File: ItemCell.h

 
 */
#import "AddItemTableViewController.h"

@class HighlightingTextView;
@class Item;


@interface ItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *itemLabel;
@property (nonatomic, weak) IBOutlet UILabel *quantityLabel;
//@property (nonatomic, weak) IBOutlet HighlightingTextView *quotationTextView;

@property (nonatomic, strong) Item *item;

@end
