//
//  upcomingObject.m
//  Dota Tracker
//
//  Created by Mike on 5/4/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "upcomingObject.h"

@implementation upcomingObject
@synthesize team1, team2, link, tourney, gamedate;

-(id)initWithTeam1:(NSString *)t1 team2:(NSString *)t2 link:(NSString *)l tourney:(NSString *)t gamedate:(NSString *)gd {
    self.team1 = t1;
    self.team2 = t2;
    self.link = l;
    self.tourney = t;
    self.gamedate = gd;

    return self;
}

@end
