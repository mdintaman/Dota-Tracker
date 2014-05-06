//
//  AppDelegate.m
//  Dota Tracker
//
//  Created by Mike on 4/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "teamObject.h"
#import "upcomingObject.h"
#import "recentObject.h"

@implementation AppDelegate

@synthesize teams;
@synthesize upcoming;
@synthesize recent;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    databaseName = @"teamObjects.sqlite";
    
    
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths lastObject];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    [self checkAndCreateDatabase];
    
    [self readTeamsFromDatabase];
    
    [self readRecentFromDatabase];
    
    
    
    
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

- (void)dealloc {

}

- (void) checkAndCreateDatabase{
    
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success) return;
    
    NSLog(@"%@", [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName]);
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"teamObjects.sqlite\0"];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}

- (void) readTeamsFromDatabase {
    
    sqlite3 *database;
    
    teams = [[NSMutableArray alloc] init];
    
    //const char *test = [databasePath UTF8String];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "select * from Teams";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *aImageSelected = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *aImageNotSelected = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSInteger aSelected = sqlite3_column_int(compiledStatement, 3);
                NSInteger aRegion = sqlite3_column_int(compiledStatement, 4);
                NSInteger aRegionRank = sqlite3_column_int(compiledStatement, 5);
                
                teamObject *team = [[teamObject alloc] initWithName:aName imageSelected:aImageSelected imageNotSelected:aImageNotSelected selected:&aSelected region:&aRegion regionRank:&aRegionRank];
                
                [teams addObject:team];
                
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

- (void) readUpcomingFromDatabase {
    
    sqlite3 *database;
    
    upcoming = [[NSMutableArray alloc] init];
    
    //const char *test = [databasePath UTF8String];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "select * from Upcoming";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *aTeam1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *aTeam2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *aLink = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *aTourney = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString *aGameDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                
                upcomingObject *game = [[upcomingObject alloc] initWithTeam1:(NSString *)aTeam1 team2:(NSString *)aTeam2 link:(NSString *)aLink tourney:(NSString *)aTourney gamedate:(NSString *)aGameDate];
                
                [upcoming addObject:game];
                
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

- (void) readRecentFromDatabase {
    
    sqlite3 *database;
    
    recent = [[NSMutableArray alloc] init];
    
    //const char *test = [databasePath UTF8String];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "select * from Recent";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *aTeam1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *aTeam2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSInteger aTeam1s = sqlite3_column_int(compiledStatement, 2);
                NSInteger aTeam2s = sqlite3_column_int(compiledStatement, 3);
                NSString *aLink = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString *aTourney = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSInteger abo = sqlite3_column_int(compiledStatement, 6);
                
                recentObject *game = [[recentObject alloc] initWithTeam1:aTeam1 team2:aTeam2 team1s:&aTeam1s team2s:&aTeam2s link:aLink tourney:aTourney bo:&abo];
                
                [recent addObject:game];
                
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Dota_Tracker" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Dota_Tracker.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
