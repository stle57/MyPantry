//
//  MyPantryAppDelegate.h
//  MyPantry
//
//  Created by Stephanie Le on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface MyPantryAppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *databaseName;
    NSString *databasePath;
    NSString *databaseData;
    sqlite3 *myPantryDB;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *databaseName, *databasePath, *databaseData;
@property (nonatomic, readonly) sqlite3 *myPantryDB;

- (void) checkAndCreateDatabase;
- (void) loadDataFromDatabase;
@end
