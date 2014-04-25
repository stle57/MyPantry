//
//  MyPantryAppDelegate.m
//  MyPantry
//
//  Created by Stephanie Le on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyPantryAppDelegate.h"
#import "SubCategory.h"

@implementation MyPantryAppDelegate

@synthesize window = _window;
@synthesize databaseName, databasePath, databaseData;
@synthesize myPantryDB;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    databaseName = @"myPantry.db";
    databaseData = @"myPantryInserts.sql";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    NSLog(@"databasePath=%@", databasePath);
    
    [self checkAndCreateDatabase];
    
    //[self loadDataFromDatabase];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- Check if the SQL database has already been saved to the users phone, if not then copy it over
- (void)checkAndCreateDatabase {
    NSLog(@"Inside MyPantryAppDelegate::checkAndCreateDatabase");
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    success = [fileManager fileExistsAtPath:databasePath];
    
    NSLog(@"databasePath = %@", databasePath);
    
    if(success) 
        return;
    
    NSLog(@"Copy db over!");
    // If not then proceed to copy the database from the  application to users filesystem
    
    // Get the path to the database in the applicatin package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    // Copy the database from the package to users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}

  


//- Load the database from the files
- (void)loadDataFromDatabase {
    NSLog(@"Load data from database");
    //- Do test to see if categories are there
    if (sqlite3_open([databasePath UTF8String], &myPantryDB) == SQLITE_OK )
    {
        NSLog(@"Open db successful");
        const char *sqlStmt = "SELECT subID, categoryID, subName FROM SubCategory";
        sqlite3_stmt *compiled_sql;
 
        int err = sqlite3_prepare_v2(myPantryDB, sqlStmt, -1, &compiled_sql, NULL);
        if(err == SQLITE_OK)
        {
            NSLog(@"Done preparing select statement");
            //SubCategory * subCategory = NULL;
            while (sqlite3_step(compiled_sql) == SQLITE_ROW){
                NSLog(@"Inside while");
                int subid = sqlite3_column_int(compiled_sql, SUB_ID);
                NSLog(@"subid from db=%d", subid);
                int categoryid = sqlite3_column_int(compiled_sql, CATEGORY_ID);
                NSLog(@"categoryid = %d", categoryid);
                NSString * subname = [NSString stringWithUTF8String:(const char*    ) sqlite3_column_text(compiled_sql, SUB_NAME)];
                NSLog(@"subname = %@", subname);
            }
        }
        else {
            NSLog(@"could not select, err=%d", err);
            printf("could not prepare statement: %s\n", sqlite3_errmsg(myPantryDB));
        }
        //- Release the rows
        sqlite3_finalize(compiled_sql);
    }
    else {
        NSLog(@"No DB!");
    }
    //- Close the database
    sqlite3_close(myPantryDB);
}
@end
