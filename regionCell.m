//
//  regionCell.m
//  Dota Tracker
//
//  Created by Mike on 4/19/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "regionCell.h"

@implementation regionCell

- (IBAction)teamSelected {
    if (_regionIcon.selected == YES) {
        _regionIcon.selected = NO;
    }
    else {
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
