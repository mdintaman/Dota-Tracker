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
#import "ScheduleViewController.h"

@implementation AppDelegate

@synthesize teams;
@synthesize upcoming;
@synthesize recent;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    databaseName = @"teamObjects.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths lastObject];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    [self checkAndCreateDatabase];
    
    [self readTeamsFromDatabase];
    
    [self readRecentFromDatabase];
    
    NSPredicate *selectedPredicate = [NSPredicate predicateWithFormat:@"SELF.selected == 1 "];
    
    NSArray *selected = [teams filteredArrayUsingPredicate:selectedPredicate];
    
    if ([selected count] == 0) {
        UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"          bundle:nil];
        ViewController* vc = [mainstoryboard      instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:vc animated:YES completion:NULL];
    }
    
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

- (void) checkAndCreateDatabase{
    
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"teamObjects.sqlite\0"];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}

- (void) readTeamsFromDatabase {
    
    sqlite3 *database;
    
    teams = [[NSMutableArray alloc] init];
    
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
                
                NSInteger weeks;
                NSInteger days;
                NSInteger hours;
                NSInteger minutes;
                    
                    if ([aGameDate rangeOfString:@"w"].location != NSNotFound) {
                        NSArray *weekSplit = [aGameDate componentsSeparatedByString:@"w"];
                        weeks = [[weekSplit objectAtIndex:0] integerValue];
                        if ([weekSplit[1] rangeOfString:@"d"].location != NSNotFound) {
                            NSArray *daySplit = [weekSplit[1] componentsSeparatedByString:@"d"];
                            days = [[daySplit objectAtIndex:0] integerValue];
                            hours = 0;
                            minutes = 0;
                        }
                        else if ([weekSplit[1] rangeOfString:@"h"].location != NSNotFound) {
                            NSArray *hourSplit = [weekSplit[1] componentsSeparatedByString:@"h"];
                            hours = [[hourSplit objectAtIndex:0] integerValue];
                            days = 0;
                            minutes = 0;
                        }
                        else {
                            NSArray *minuteSplit = [weekSplit[1] componentsSeparatedByString:@"m"];
                            minutes = [[minuteSplit objectAtIndex:0] integerValue];
                            days = 0;
                            hours = 0;
                        }
                    }
                    else if ([aGameDate rangeOfString:@"d"].location != NSNotFound) {
                        NSArray *daySplit = [aGameDate componentsSeparatedByString:@"d"];
                        days = [[daySplit objectAtIndex:0] integerValue];
                        if ([daySplit[1] rangeOfString:@"h"].location != NSNotFound) {
                            NSArray *hourSplit = [daySplit[1] componentsSeparatedByString:@"h"];
                            hours = [[hourSplit objectAtIndex:0] integerValue];
                            weeks = 0;
                            minutes = 0;
                        }
                        else {
                            NSArray *minuteSplit = [daySplit[1] componentsSeparatedByString:@"m"];
                            minutes = [[minuteSplit objectAtIndex:0] integerValue];
                            weeks = 0;
                            hours = 0;
                        }
                    }
                    else if ([aGameDate rangeOfString:@"h"].location != NSNotFound) {
                        NSArray *hourSplit = [aGameDate componentsSeparatedByString:@"h"];
                        hours = [[hourSplit objectAtIndex:0] integerValue];
                        if ([hourSplit[1] rangeOfString:@"m"].location != NSNotFound) {
                            NSArray *minuteSplit = [hourSplit[1] componentsSeparatedByString:@"m"];
                            minutes = [[minuteSplit objectAtIndex:0] integerValue];
                            weeks = 0;
                            days = 0;
                        }
                    }
                    else {
                        NSArray *minuteSplit = [aGameDate componentsSeparatedByString:@"m"];
                        minutes = [[minuteSplit objectAtIndex:0] integerValue];
                        weeks = 0;
                        days = 0;
                        hours = 0;
                    }
                    
                    NSDateComponents *offset = [[NSDateComponents alloc] init];
                    [offset setWeek:weeks];
                    [offset setDay:days];
                    [offset setHour:hours];
                    [offset setMinute:minutes];
                    
                    NSDate *now = [NSDate date];
                    
                    NSDate *gameDate = [[NSCalendar currentCalendar] dateByAddingComponents:offset toDate:now options:0];
                
                NSDate *aDate = gameDate;
                
                upcomingObject *game = [[upcomingObject alloc] initWithTeam1:(NSString *)aTeam1 team2:(NSString *)aTeam2 link:(NSString *)aLink tourney:(NSString *)aTourney gamedate:(NSString *)aGameDate savedDate:(NSDate *)aDate];
                
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

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
