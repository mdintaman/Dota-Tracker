//
//  upcomingCell.h
//  Dota Tracker
//
//  Created by Mike on 5/5/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface upcomingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *uGame;
@property (weak, nonatomic) IBOutlet UILabel *upcomingTourney;
@property (weak, nonatomic) IBOutlet UILabel *timeLeft;

@end
