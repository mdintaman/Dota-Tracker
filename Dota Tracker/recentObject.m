//
//  recentObject.m
//  Dota Tracker
//
//  Created by Mike on 5/5/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "recentObject.h"

@implementation recentObject
@synthesize team1, team2, team1s, team2s, link, tourney, bo;

-(id)initWithTeam1:(NSString *)t1 team2:(NSString *)t2 team1s:(NSInteger *)t1s team2s:(NSInteger *)t2s link:(NSString *)l tourney:(NSString *)t bo:(NSInteger *)b {
    self.team1 = t1;
    self.team2 = t2;
    self.team1s = *(t1s);
    self.team2s = *(t2s);
    self.link = l;
    self.tourney = t;
    self.bo = *(b);
    return self;
}

@end
