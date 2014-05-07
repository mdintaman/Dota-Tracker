//
//  regionCell.m
//  Dota Tracker
//
//  Created by Mike on 4/19/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "regionCell.h"
#import "AppDelegate.h"
#import "teamObject.h"
#import "upcomingObject.h"

@implementation regionCell

- (IBAction)teamSelected {
    
    
    AppDelegate *dbDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [dbDelegate readUpcomingFromDatabase];
    
    NSArray *upcomingGamesAll = dbDelegate.upcoming;
    
    sqlite3 *database;
    
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths lastObject];
    
    
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"teamObjects.sqlite"];;
    
    BOOL success=[fileMgr fileExistsAtPath:dbPath];
    if(!success)
    {
        NSLog(@"Cannot locate database '%@'.",dbPath);
    }
    if (!(sqlite3_open([dbPath UTF8String], &database)==SQLITE_OK)) {
        NSLog(@"An error has occured: %s",sqlite3_errmsg(database));
    }
    
    if (_regionIcon.selected == YES) {
        NSString *insertStatement=[NSString stringWithFormat:@"UPDATE Teams SET selected = 0 WHERE name = '%@'", self.regionIcon.titleLabel.text];
        char *error;
        if((sqlite3_exec(database, [insertStatement UTF8String], NULL, NULL, &error))==SQLITE_OK)
        {
            NSLog(@"State Switched.");
            
        }
        else
        {
            NSLog(@"Error: %s", error);
        }
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *eventArray = [app scheduledLocalNotifications];
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
            if ([uid isEqualToString:self.regionIcon.titleLabel.text])
            {
                //Cancelling local notification
                [app cancelLocalNotification:oneEvent];
            }
        }
        NSLog(@"%@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
        _regionIcon.selected = NO;
    }
    else {
        NSString *insertStatement=[NSString stringWithFormat:@"UPDATE Teams SET selected = 1 WHERE name = '%@'", self.regionIcon.titleLabel.text];
        char *error;
        if((sqlite3_exec(database, [insertStatement UTF8String], NULL, NULL, &error))==SQLITE_OK)
        {
            
            NSLog(@"State Switched.");
        }
        else
        {
            NSLog(@"Error: %s", error);
        }
        
        NSPredicate *upcomingPredicate = [NSPredicate predicateWithFormat:@"team1 == %@ OR team2 == %@", self.regionIcon.titleLabel.text, self.regionIcon.titleLabel.text];
        NSArray *upcomingTeam = [upcomingGamesAll filteredArrayUsingPredicate:upcomingPredicate];
  
        for (upcomingObject *gg in upcomingTeam) {
            NSDate *fireDate = [gg.savedDate dateByAddingTimeInterval:-1700];
            
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = fireDate;
            localNotification.alertBody = [NSString stringWithFormat:@"%@ vs. %@ in 5.  %@", gg.team1, gg.team2, gg.tourney];
            localNotification.soundName = UILocalNotificationDefaultSoundName;
            NSDictionary *teamName = [NSDictionary dictionaryWithObjectsAndKeys:self.regionIcon.titleLabel.text, @"uid", nil];
            localNotification.userInfo = teamName;
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
        }
        NSLog(@"%@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
        _regionIcon.selected = YES;
    }
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
