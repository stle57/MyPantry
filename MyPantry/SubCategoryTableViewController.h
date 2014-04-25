//
//  SubCategoryTableViewController.h
//  MyPantry
//
//  Created by Stephanie Le on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AddItemTableViewController.h"
#import "SubCategory.h"
#import "SubCategoryHeaderView.h"

@class SubCategoryTableViewController;
@class ItemCell;

@protocol SubCategoryTableViewControllerDelegate <NSObject>
- (void)subCategoryTableViewControllerHome: (SubCategoryTableViewController *)controller;
- (void)subCategoryTableViewControllerAdd:(SubCategoryTableViewController *)controller;
@end


@interface SubCategoryTableViewController : UITableViewController <AddItemTableViewControlDelegate, SubCategoryHeaderViewDelegate>

@property (nonatomic, weak) id <SubCategoryTableViewControllerDelegate> delegate;
//@property (nonatomic, strong) AddItemTableViewController *addItemTableViewController;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSMutableArray *subCategories;
@property (nonatomic, weak) IBOutlet ItemCell *itemCell;

- (IBAction)home:(id)sender;
//- (IBAction)add:(id)sender;

- (void)loadSubCategoryFields;
- (NSMutableArray*)loadItemsBySubCategory:(sqlite3 *)localDb :(NSInteger)categoryID :(NSInteger)subID;

@end
