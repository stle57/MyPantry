//
//  SubCategoryTableViewController.m
//  MyPantry
//
//  Created by Stephanie Le on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubCategoryTableViewController.h"
#import "MyPantryAppDelegate.h"
#import "Model Classes/Item.h"
#import "Model Classes/SubCategory.h"
#import "ItemCell.h"
#import "HighlightingTextView.h"
#import "SubCategoryInfo.h"
#import "Constants.h"


@interface SubCategoryTableViewController ()

@property (nonatomic, strong) NSMutableArray *subCategoryInfoArray;
@property (nonatomic, strong) NSIndexPath *pinchedIndexPath;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, assign) CGFloat initialPinchHeight;

// User the uniformRowHeight property if the pinch gestures hould change
// all row heights simultaneously.
@property (nonatomic, assign) NSInteger uniformRowHeight;

-(void) updateForPinchScale:(CGFloat)scale atIndexPath:(NSIndexPath*)indexPath;

@end

#define DEFAULT_ROW_HEIGHT 78
#define HEADER_HEIGHT 45

@implementation SubCategoryTableViewController
@synthesize delegate;
@synthesize category;
//@synthesize addItemTableViewController;
@synthesize subCategories=subCategories_, subCategoryInfoArray=subCategoryInfoArray_, itemCell=newCells_, pinchedIndexPath=pinchedIndexPath_, uniformRowHeight=rowHeight_,openSectionIndex=openSectionIndex_, initialPinchHeight=initialPinchHeight_;


#pragma mark Initialization and configuration


-(BOOL)canBecomeFirstResponder {
    
    return YES;
}


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated]; 
	
    /*
     Check whether the section info array has been created, and if so whether the section count still matches the current section count. In general, you need to keep the section info synchronized with the rows and section. If you support editing in the table view, you need to appropriately update the section info during editing operations.
     */
	if ((self.subCategoryInfoArray == nil) || ([self.subCategoryInfoArray count] != [self numberOfSectionsInTableView:self.tableView])) {
		
        // For each play, set up a corresponding SectionInfo object to contain the default height for each row.
		NSMutableArray *infoArray = [[NSMutableArray alloc] init];
		
		for (SubCategory *subCategory in self.subCategories) {
			
			SubCategoryInfo *subCategoryInfo = [[SubCategoryInfo alloc] init];			
			subCategoryInfo.subCategory = subCategory;
			subCategoryInfo.open = NO;
			
            NSNumber *defaultRowHeight = [NSNumber numberWithInteger:DEFAULT_ROW_HEIGHT];
			NSInteger countOfItems = [[subCategoryInfo.subCategory items] count];
			for (NSInteger i = 0; i < countOfItems; i++) {
				[subCategoryInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
			}
			
			[infoArray addObject:subCategoryInfo];
		}
		
		self.subCategoryInfoArray = infoArray;
	}
	
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    // To reduce memory pressure, reset the section info array if the view is unloaded.
	self.subCategoryInfoArray = nil;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"Inside SubCategetoryTableViewController::initWithStyle");
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Inside SubCategoryTableViewController::viewDidLoad");
    [super viewDidLoad];

    NSLog(@"category sent from main was %@", category);
    
    //- Initializae AddItemViewController
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Add a pinch gesture recognizer to the table view.
	UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
	[self.tableView addGestureRecognizer:pinchRecognizer];
    
    // Set up default values.
    self.tableView.sectionHeaderHeight = HEADER_HEIGHT;
	/*
     The section info array is thrown away in viewWillUnload, so it's OK to set the default values here. If you keep the section information etc. then set the default values in the designated initializer.
     */
    rowHeight_ = DEFAULT_ROW_HEIGHT;
    openSectionIndex_ = NSNotFound;
    
    //- Load the correct sub category from the button that was pressed
    [self loadSubCategoryFields];
    
    //- Now create the subcategory sections and set the sliders
    
    //- Create the items underneath the sections
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.subCategories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    SubCategoryInfo *subCategoryInfo = [self.subCategoryInfoArray objectAtIndex:section];
    NSInteger numSubCategoriesInSection = [[subCategoryInfo.subCategory items] count];
    
    return subCategoryInfo.open ? numSubCategoriesInSection : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Inside cellForRowAtIndexPath");
    static NSString *ItemCellIdentifier = @"ItemCellIdentifier";
    ItemCell *cell = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:ItemCellIdentifier];
    
    // Configure the cell...
    if(!cell) {
        NSLog(@"cell is null");
        UINib *itemCellNib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
        [itemCellNib instantiateWithOwner:self options:nil];
        cell = self.itemCell;
        self.itemCell = nil;

    }

    //- Assign the item to the cell
    SubCategory *subCategory  = (SubCategory*)[[self.subCategoryInfoArray objectAtIndex:indexPath.section] subCategory];
    NSLog(@"row=%d", indexPath.row);
    
    cell.item = [subCategory.items objectAtIndex:indexPath.row];
    [cell.item printItem];
    
    return cell;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    /*
     Create the sub category header views lazily.
     */
	SubCategoryInfo *subCategoryInfo = [self.subCategoryInfoArray objectAtIndex:section];
    if (!subCategoryInfo.headerView) {
        NSLog(@"creating SubCategoryHeaderView");
		NSString *subCategoryName = subCategoryInfo.subCategory.subCategoryName;
        subCategoryInfo.headerView = [[SubCategoryHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, HEADER_HEIGHT) title:subCategoryName section:section delegate:self];
    }
    
    return subCategoryInfo.headerView;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
	SubCategoryInfo *sectionInfo = [self.subCategoryInfoArray objectAtIndex:indexPath.section];
    return [[sectionInfo objectInRowHeightsAtIndex:indexPath.row] floatValue];
    // Alternatively, return rowHeight.
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"didSelectRowAtIndexPath was called");
    ItemCell *cell = (ItemCell*)[tableView cellForRowAtIndexPath:indexPath];
    if(cell)
    {
        NSLog(@"We got it!");
    }
    else {
        NSLog(@"We did not get a cell at indexPath=%d", indexPath.row);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Section header delegate
-(void)SubCategoryHeaderView:(SubCategoryHeaderView*)SubCategoryHeaderView sectionOpened:(NSInteger)sectionOpened {
	NSLog(@"inside sectionOpened");
    
	SubCategoryInfo *subCategoryInfo = [self.subCategoryInfoArray objectAtIndex:sectionOpened];
	
	subCategoryInfo.open = YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [subCategoryInfo.subCategory.items count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
		SubCategoryInfo *previousOpenSection = [self.subCategoryInfoArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.subCategory.items count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    self.openSectionIndex = sectionOpened;
    
}

-(void)SubCategoryHeaderView:(SubCategoryHeaderView*)SubCategoryHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SubCategoryInfo *subCategoryInfo = [self.subCategoryInfoArray objectAtIndex:sectionClosed];
	
    subCategoryInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

#pragma mark Handling pinches


-(void)handlePinch:(UIPinchGestureRecognizer*)pinchRecognizer {
    
    /*
     There are different actions to take for the different states of the gesture recognizer.
     * In the Began state, use the pinch location to find the index path of the row with which the pinch is associated, and keep a reference to that in pinchedIndexPath. Then get the current height of that row, and store as the initial pinch height. Finally, update the scale for the pinched row.
     * In the Changed state, update the scale for the pinched row (identified by pinchedIndexPath).
     * In the Ended or Canceled state, set the pinchedIndexPath property to nil.
     */
    
    if (pinchRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint pinchLocation = [pinchRecognizer locationInView:self.tableView];
        NSIndexPath *newPinchedIndexPath = [self.tableView indexPathForRowAtPoint:pinchLocation];
		self.pinchedIndexPath = newPinchedIndexPath;
        
		SubCategoryInfo *subCategoryInfo = [self.subCategoryInfoArray objectAtIndex:newPinchedIndexPath.section];
        self.initialPinchHeight = [[subCategoryInfo objectInRowHeightsAtIndex:newPinchedIndexPath.row] floatValue];
        // Alternatively, set initialPinchHeight = uniformRowHeight.
        
        [self updateForPinchScale:pinchRecognizer.scale atIndexPath:newPinchedIndexPath];
    }
    else {
        if (pinchRecognizer.state == UIGestureRecognizerStateChanged) {
            [self updateForPinchScale:pinchRecognizer.scale atIndexPath:self.pinchedIndexPath];
        }
        else if ((pinchRecognizer.state == UIGestureRecognizerStateCancelled) || (pinchRecognizer.state == UIGestureRecognizerStateEnded)) {
            self.pinchedIndexPath = nil;
        }
    }
}

-(void)updateForPinchScale:(CGFloat)scale atIndexPath:(NSIndexPath*)indexPath {
    
    if (indexPath && (indexPath.section != NSNotFound) && (indexPath.row != NSNotFound)) {
        
		CGFloat newHeight = round(MAX(self.initialPinchHeight * scale, DEFAULT_ROW_HEIGHT));
        
		SubCategoryInfo *subCategoryInfo = [self.subCategoryInfoArray objectAtIndex:indexPath.section];
        [subCategoryInfo replaceObjectInRowHeightsAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:newHeight]];
        // Alternatively, set uniformRowHeight = newHeight.
        
        /*
         Switch off animations during the row height resize, otherwise there is a lag before the user's action is seen.
         */
        BOOL animationsEnabled = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        [UIView setAnimationsEnabled:animationsEnabled];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


- (IBAction)home:(id)sender {
    NSLog(@"Button was hit");
    [self.delegate subCategoryTableViewControllerHome:self];
}

//- Retrieves the items for the specified sub category
- (NSMutableArray*)loadItemsBySubCategory:(sqlite3*)localDb: (NSInteger)categoryID :(NSInteger)subID {
    NSLog (@"Inside loadItemsBySubCategory");
    //MyPantryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSLog(@"categoryID = %d",categoryID);
    NSLog(@"subID = %d", subID);
    
    NSString *itemSql = [NSString stringWithFormat:@"select categoryID, subID, itemName, weight, brand, expirationDate from Item where subID = %d and categoryID=%d", subID, categoryID];
   // NSString *itemSql = [NSString stringWithFormat:@"SELECT subID, categoryID, subName FROM SubCategory"];
    
    NSLog(@"itemsql =%@", itemSql);
    
    sqlite3_stmt *compiled_sql;
    
    int err = sqlite3_prepare_v2(localDb, [itemSql UTF8String], -1, &compiled_sql, NULL);
    if(err == SQLITE_OK)
    {
        NSLog(@"Done preparing select statement");
        int numData = sqlite3_data_count(compiled_sql);
        NSLog(@"number of data = %d", numData);
        while (sqlite3_step(compiled_sql) == SQLITE_ROW)
        {
            
            NSLog(@"Inside while");
            int categoryid = sqlite3_column_int(compiled_sql, CAT_ID);
            NSLog(@"categoryid=%d", categoryid);
            int subid = sqlite3_column_int(compiled_sql, SUBCAT_ID);
            NSLog(@"subid=%d", subid);
            NSString *itemName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(compiled_sql, NAME)];
            NSLog(@"itemName=%@", itemName);
            int weight = sqlite3_column_int(compiled_sql, WEIGHT);
            NSLog(@"weight = %d", weight);
            NSString *brand = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(compiled_sql, BRAND_NAME)];
            NSLog(@"brand=%@", brand);
            NSDate *expiration = [NSDate dateWithTimeIntervalSince1970:(sqlite3_column_int(compiled_sql, EXPIRATION_DATE))];
            
            [items addObject:[Item initializeItem:itemName weight:[NSNumber numberWithInt:( weight)] brandName:brand expirationDate:expiration categoryID:[NSNumber numberWithInt:(categoryid)] subID:[NSNumber numberWithInt:(subid)]]];
        }
    }
    else
    {
        NSLog(@"could not select, err=%d", err);
        printf("could not prepare statement: %s\n", sqlite3_errmsg(localDb));
    }

    //- Release the rows
    NSLog(@"Finalizing second statement");
    sqlite3_finalize(compiled_sql);
    
    NSLog(@"items count=%d", items.count);
    NSLog(@"Leaving function");
    return items;
}

//-- Function which goes to the database and loads all the sub categories and their items
- (void)loadSubCategoryFields {
    NSLog(@"Inside SubCategoryTableViewController::loadSubCategoryFields");
    
    NSLog(@"Load data from database");
    //- Do test to see if categories are there
    MyPantryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    sqlite3 *localPantryDb = appDelegate.myPantryDB;
    subCategories_ = [[NSMutableArray alloc] init];
    
    if (sqlite3_open([appDelegate.databasePath UTF8String], &localPantryDb) == SQLITE_OK )
    {
        NSLog(@"Open db successful");
        
        //- Sql statement retrieves sub categories based on the category that was chosen on
        //- the main screen
        NSString *sqlStmt = [NSString stringWithFormat:@"SELECT subID, categoryID, subName FROM Category, SubCategory where Category.name = \"%@\" and Category.id = SubCategory.categoryID", category];
        //NSString *sqlStmt = [stmt stringByAppendingFormat:category];
        
        NSLog(@"sqlStmt=%@", sqlStmt);
        
        sqlite3_stmt *compiled_sql;
        
        int err = sqlite3_prepare_v2(localPantryDb, [sqlStmt UTF8String], -1, &compiled_sql, NULL);
        if(err == SQLITE_OK)
        {
            NSLog(@"Done preparing select statement");

            while (sqlite3_step(compiled_sql) == SQLITE_ROW)
            {
                NSLog(@"Inside while");
                int subid = sqlite3_column_int(compiled_sql, SUB_ID);
                NSLog(@"subid from db=%d", subid);
                int categoryid = sqlite3_column_int(compiled_sql, CATEGORY_ID);
                NSLog(@"categoryid = %d", categoryid);
                NSString * subname = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(compiled_sql, SUB_NAME)];
                NSLog(@"subname = %@", subname);

                //- load the items by subcategory
                NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
                itemsArray = [self loadItemsBySubCategory:localPantryDb :categoryid :subid];
                if(itemsArray.count == 0)
                {
                    NSLog(@"itemArray is 0!");
                }
                else {
                    NSLog(@"itemArray = %d", itemsArray.count);
                }
                
                NSLog(@"creating and adding sub category");
                
                //- Add to subcategory list
                [subCategories_ addObject:[SubCategory initSubCategory:[NSNumber numberWithInt:subid] categoryID:[NSNumber numberWithInt:(categoryid)] subCategoryName:subname items:itemsArray]];
                NSLog(@"subCategories.count = %d", subCategories_.count);
            }
        }
        else
        {
            NSLog(@"could not select, err=%d", err);
            printf("could not prepare statement: %s\n", sqlite3_errmsg(localPantryDb));
        }
        //- Release the rows
        NSLog(@"finalizing first statemet");
        sqlite3_finalize(compiled_sql);
    }
    else {
        NSLog(@"No DB!");
    }
    //- Close the database
    sqlite3_close(localPantryDb);   
    
}
#pragma mark - AddItemTableViewControllerDelegate
- (void)addItemTableViewControllerCancel:(AddItemTableViewController *)controller {
    NSLog(@"Close additem screen!");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addItemTableViewControllerSave:(AddItemTableViewController *)controller {
    NSLog(@"Save additem, then close screen!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Inside prepareForSegue to AddItemsViewController with segue id=%@", segue.identifier);
    if([segue.identifier isEqualToString:@"ViewItemDetails"])
    {
        NSLog(@"Creating additemtableviewcontroller");
        AddItemTableViewController* addItemTableViewController = segue.destinationViewController;
        addItemTableViewController.delegate = self;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        ItemCell *cell = (ItemCell*)[self.tableView cellForRowAtIndexPath:path];
        if(cell)
        {
            NSLog(@"Setting the cell item inside addItemTableViewController");
            addItemTableViewController.item = cell.item;
        }
    }
}
@end
