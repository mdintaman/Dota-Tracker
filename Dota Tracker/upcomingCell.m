//
//  upcomingCell.m
//  Dota Tracker
//
//  Created by Mike on 5/5/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "upcomingCell.h"

@implementation upcomingCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)launch:(id)sender{
    NSString *temp = [NSString stringWithFormat:@"http://www.gosugamers.com%@",_link];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:temp]];
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
