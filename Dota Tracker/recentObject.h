//
//  recentObject.h
//  Dota Tracker
//
//  Created by Mike on 5/5/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface recentObject : NSObject {
    NSString *team1;
    NSString *team2;
    NSInteger team1s;
    NSInteger team2s;
    NSString *link;
    NSString *tourney;
    NSInteger bo;
}

@property (nonatomic, retain) NSString *team1;
@property (nonatomic, retain) NSString *team2;
@property (nonatomic, assign) NSInteger team1s;
@property (nonatomic, assign) NSInteger team2s;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *tourney;
@property (nonatomic, assign) NSInteger bo;

-(id)initWithTeam1:(NSString *)t1 team2:(NSString *)t2 team1s:(NSInteger *)t1s team2s:(NSInteger *)t2s link:(NSString *)l tourney:(NSString *)t bo:(NSInteger *)b;



@end