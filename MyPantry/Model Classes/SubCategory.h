//
//  SubCategory.h
//  MyPantry
//
//  Created by Stephanie Le on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    SUB_ID = 0,
    CATEGORY_ID,
    SUB_NAME
} SubCategoryEnum;

@interface SubCategory : NSObject{
    NSNumber *subID;
    NSString *subCategoryName;
    NSNumber *categoryID;
    NSMutableArray *items;
}

@property (nonatomic, strong) NSNumber *subID;
@property (nonatomic, strong) NSString *subCategoryName;
@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSMutableArray *items;

+ (id)initSubCategory:(NSNumber *)subID categoryID:(NSNumber*)categoryID subCategoryName:(NSString *)subCategoryName items:(NSMutableArray *)items;

- (void)printSubCategory;
@end
