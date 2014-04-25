//
//  AddItemTableViewController.h
//  MyPantry
//
//  Created by Stephanie Le on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;
@class AddItemTableViewController;
@protocol AddItemTableViewControlDelegate <NSObject>

- (void)addItemTableViewControllerCancel:(AddItemTableViewController *)controller;
- (void)addItemTableViewControllerSave:(AddItemTableViewController *)controller;
@end

@interface AddItemTableViewController : UITableViewController

@property (nonatomic, weak) id <AddItemTableViewControlDelegate> delegate;
@property (nonatomic, strong) Item * item;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
