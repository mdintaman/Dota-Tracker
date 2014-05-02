//
//  teamObject.m
//  Dota Tracker
//
//  Created by Mike on 4/30/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "teamObject.h"

@implementation teamObject
@synthesize name, imageSelected, imageNotSelected, selected, region, regionRank;

-(id)initWithName:(NSString *)n imageSelected:(NSString *)is imageNotSelected:(NSString *)ins selected:(NSInteger *)s region:(NSInteger *)r regionRank:(NSInteger *)rr {
    self.name = n;
    self.imageSelected = is;
    self.imageNotSelected = ins;
    self.selected = s;
    self.region = r;
    self.regionRank = rr;
    return self;
}

@end
