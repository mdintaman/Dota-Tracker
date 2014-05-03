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

@implementation regionCell

- (IBAction)teamSelected {
    sqlite3 *database;
    
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    
    NSString *dbPath=@"/Users/mike/Library/Application Support/iPhone Simulator/7.1/Applications/E62DE0FA-77F9-4FBA-8F56-71B22422BCEB/Library/teamObjects.sqlite";
    
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
