//
//  Item.m
//  MyPantry
//
//  Created by Stephanie Le on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize name, weight, brandName, expirationDate, categoryID, subID;


+ (id)initializeItem:(NSString *)name weight:(NSNumber *)weight brandName:(NSString *)brandName expirationDate:(NSDate *)expirationDate categoryID:(NSNumber*)categoryID subID:(NSNumber*)subID
{
    Item *newItem = [[self alloc] init];
    //newItem.uniqueID = uniqueID;
    newItem.name = name;
    newItem.weight = weight;
    newItem.brandName = brandName;
    newItem.expirationDate = expirationDate;
    newItem.categoryID = categoryID;
    newItem.subID = subID;
    
    return newItem;
}

- (void)printItem {
    NSLog(@"Printing Item:");
    NSLog(@"name=%@", self.name);
    NSLog(@"weight=%@d", self.weight);
    NSLog(@"brandName=%@", self.brandName);
    NSLog(@"expirationDate=%@", self.expirationDate);
    NSLog(@"categoryID=%@d", self.categoryID);
    NSLog(@"subID=%@d", self.subID);
}
@end
