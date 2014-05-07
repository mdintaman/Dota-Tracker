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
@property (weak, nonatomic) IBOutlet UILabel *noLogo;
@property (weak, nonatomic) NSDate *savedDate;
@property (weak, nonatomic) NSString *link;
@property (weak, nonatomic) IBOutlet UIButton *linkLaunch;

- (IBAction)launch:(id)sender;

@end
