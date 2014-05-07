//
//  recentCell.h
//  Dota Tracker
//
//  Created by Mike on 5/5/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface recentCell : UICollectionViewCell {
    
}

@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIImageView *rGame;
@property (weak, nonatomic) IBOutlet UILabel *recentTourney;
@property (weak, nonatomic) IBOutlet UIImageView *g1;
@property (weak, nonatomic) IBOutlet UIImageView *g2;
@property (weak, nonatomic) IBOutlet UIImageView *g3;
@property (weak, nonatomic) IBOutlet UIImageView *g4;
@property (weak, nonatomic) IBOutlet UIImageView *g5;
@property (nonatomic) NSInteger myscore;
@property (nonatomic) NSInteger theirscore;
@property (nonatomic) NSInteger shown;
@property (weak, nonatomic) IBOutlet UILabel *noLogo;
@property (weak, nonatomic) NSString *link;
@property (weak, nonatomic) IBOutlet UIButton *linkLaunch;


-(IBAction)launch:(id)sender;
-(IBAction)showButton:(id)sender;

@end
