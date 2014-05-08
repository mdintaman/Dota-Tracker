//
//  AppDelegate.h
//  Dota Tracker
//
//  Created by Mike on 4/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *databaseName;
    NSString *databasePath;
    
    NSMutableArray *teams;
    NSMutableArray *upcoming;
    NSMutableArray *recent;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *teams;
@property (nonatomic, retain) NSMutableArray *upcoming;
@property (nonatomic, retain) NSMutableArray *recent;

- (void)readTeamsFromDatabase;
- (void)readUpcomingFromDatabase;
- (void)readRecentFromDatabase;
- (NSURL *)applicationDocumentsDirectory;

@end
