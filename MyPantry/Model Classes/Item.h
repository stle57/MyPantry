//
//  Item.h
//  MyPantry
//
//  Created by Stephanie Le on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CAT_ID =0,
    SUBCAT_ID,
    NAME,
    WEIGHT,
    BRAND_NAME,
    EXPIRATION_DATE
} ItemEnum;


@interface Item : NSObject {
    NSString *name;
    NSNumber *weight;
    NSString *brandName;
    NSDate *expirationDate;
    NSNumber *categoryID;
    NSNumber *subID;
}

//@property (nonatomic, strong) NSNumber *uniqueID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSNumber *subID;

+ (id)initializeItem:(NSString *)name weight:(NSNumber *)weight brandName:(NSString *)brandName expirationDate:(NSDate *)expirationDate categoryID:(NSNumber*)categoryID subID:(NSNumber*)subID;

//+ (id)initializeItem:(NSNumber *)uniqueID name:(NSString *)name weight:(NSNumber *)weight brandName:(NSString *)brandName expirationDate:(NSDate *)expirationDate categoryID:(NSNumber*)categoryID subID:(NSNumber*)subID;

- (void)printItem;

@end
