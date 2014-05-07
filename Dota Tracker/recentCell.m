//
//  recentCell.m
//  Dota Tracker
//
//  Created by Mike on 5/5/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "recentCell.h"

@implementation recentCell

-(IBAction)showButton:(id)sender{
    if (self.g1.image  != nil) {
        if (self.myscore == 0) {
            [self.g1 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g2 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
        }
        else if (self.myscore == 1) {
            [self.g1 setImage:[UIImage imageNamed:@"wong.png"]];
            [self.g2 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g4 setImage:[UIImage imageNamed:@"lostg.png"]];
        }
        else if (self.myscore == 2) {
            [self.g1 setImage:[UIImage imageNamed:@"wong.png"]];
            [self.g2 setImage:[UIImage imageNamed:@"wong.png"]];
            [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g4 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g5 setImage:[UIImage imageNamed:@"lostg.png"]];
        }
        else {
            if (self.theirscore == 0) {
                [self.g1 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g2 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g3 setImage:[UIImage imageNamed:@"wong.png"]];
            }
            else if (self.theirscore == 1) {
                [self.g1 setImage:[UIImage imageNamed:@"lostg.png"]];
                [self.g2 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g3 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g4 setImage:[UIImage imageNamed:@"wong.png"]];
            }
            else {
                [self.g1 setImage:[UIImage imageNamed:@"lostg.png"]];
                [self.g2 setImage:[UIImage imageNamed:@"lostg.png"]];
                [self.g3 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g4 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g5 setImage:[UIImage imageNamed:@"wong.png"]];
            }
        }
    }
    else if (self.g4.image != nil) {
        if (self.myscore == 0) {
            [self.g2 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
        }
        else if (self.myscore == 1) {
            [self.g2 setImage:[UIImage imageNamed:@"wong.png"]];
            [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
            [self.g4 setImage:[UIImage imageNamed:@"lostg.png"]];
        }
        else {
            if (self.theirscore == 0) {
                [self.g2 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g3 setImage:[UIImage imageNamed:@"wong.png"]];
            }
            else if (self.theirscore == 1) {
                [self.g2 setImage:[UIImage imageNamed:@"lostg.png"]];
                [self.g3 setImage:[UIImage imageNamed:@"wong.png"]];
                [self.g4 setImage:[UIImage imageNamed:@"wong.png"]];
            }
        }
    }
    else if (self.g2.image != nil) {
        [self.g2 setImage:[UIImage imageNamed:@"wong.png"]];
        [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
    }
    else {
        if (self.myscore == 0) {
            [self.g3 setImage:[UIImage imageNamed:@"lostg.png"]];
        }
        else {
            [self.g3 setImage:[UIImage imageNamed:@"wong.png"]];
        }
    }
    
    self.shown = 1;
    self.showButton.selected = YES;
}

- (IBAction)launch:(id)sender{
    NSString *temp = [NSString stringWithFormat:@"http://www.gosugamers.com%@",_link];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:temp]];
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
