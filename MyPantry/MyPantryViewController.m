//
//  ViewController.m
//  MyPantry
//
//  Created by Stephanie Le on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyPantryViewController.h"
#import "Model Classes/Constants.h"


@implementation MyPantryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)ibaMeatsButton:(id)sender {
    NSLog(@"Meat button hit");
}

/*- (void)SubCategoryTableViewControllerAdd:(SubCategoryTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}*/
- (void)subCategoryTableViewControllerHome:(SubCategoryTableViewController *)controller {
    NSLog(@"Inside MyPantryViewController::subCategoryTableViewControllerHome");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    NSLog(@"Inside prepareForSeque: id=%@", segue.identifier);
    UINavigationController *navigationController = 
    segue.destinationViewController;
    SubCategoryTableViewController *subCategoryTableViewController = 
    [[navigationController viewControllers]objectAtIndex:0];
    subCategoryTableViewController.delegate = self;
    
    if([segue.identifier isEqualToString:@"ViewMeats"]) 
    {
        NSLog(@"Sending Meats as category");
        subCategoryTableViewController.category = MEAT_CATEGORY;
    }
    else if ([segue.identifier isEqualToString:@"ViewSeafood"]) {
        NSLog(@"Sending Seafood as category");
        subCategoryTableViewController.category = SEAFOOD_CATEGORY;
    }
    else if([segue.identifier isEqualToString:@"ViewDairy"]) {
        NSLog(@"Sending Dairy as category");
        subCategoryTableViewController.category = DAIRY_CATEGORY;
    }
    else if([segue.identifier isEqualToString:@"ViewDryGoods"]) {
        NSLog(@"Sending Dairy as category");
        subCategoryTableViewController.category = DRYGOODS_CATEGORY;
    }
    else if([segue.identifier isEqualToString:@"ViewFruitsVegetables"]) {
        NSLog(@"Sending Dairy as category");
        subCategoryTableViewController.category = FRUITS_VEGETABLES_CATEGORY;
    }
    else if([segue.identifier isEqualToString:@"ViewFrozenFoods"]) {
        NSLog(@"Sending Dairy as category");
        subCategoryTableViewController.category = FROZEN_CATEGORY;
    }
}
@end
