//
//  SubCategory.m
//  MyPantry
//
//  Created by Stephanie Le on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubCategory.h"

@implementation SubCategory

@synthesize subID, categoryID, subCategoryName, items;

+ (id)initSubCategory:(NSNumber *)subID categoryID:(NSNumber*)categoryID subCategoryName:(NSString *)subCategoryName items:(NSMutableArray *)items
{
    SubCategory* newSubCategory = [[self alloc] init];
    newSubCategory.subID = subID;
    newSubCategory.categoryID = categoryID;
    newSubCategory.subCategoryName = subCategoryName;
    newSubCategory.items = items;
    
    return newSubCategory;
}

- (void)printSubCategory {
    NSLog(@"Print SubCategory");
    NSLog(@"subID=%@d", self.subID);
    NSLog(@"categoryID=%@d", self.categoryID);
    NSLog(@"subCategoryName=%@d", self.subCategoryName);
    NSLog(@"items.count=%@d", self.items.count);
    
}
@end
