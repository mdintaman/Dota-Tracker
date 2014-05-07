//
//  upcomingObject.h
//  Dota Tracker
//
//  Created by Mike on 5/4/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface upcomingObject : NSObject {
NSString *team1;
NSString *team2;
NSString *link;
NSString *tourney;
NSString *gamedate;
NSDate *savedDate;
}

@property (nonatomic, retain) NSString *team1;
@property (nonatomic, retain) NSString *team2;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *tourney;
@property (nonatomic, retain) NSString *gamedate;
@property (nonatomic, retain) NSDate *savedDate;

-(id)initWithTeam1:(NSString *)t1 team2:(NSString *)t2 link:(NSString *)l tourney:(NSString *)t gamedate:(NSString *)gd savedDate:(NSDate *)sd;



@end
