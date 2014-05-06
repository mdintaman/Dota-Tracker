//
//  teamCell.h
//  Dota Tracker
//
//  Created by Mike on 5/3/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol teamCellDelegate <NSObject>

-(IBAction)buttonPressed:(id)sender;

@end

@interface teamCell : UICollectionViewCell

@property (nonatomic, weak) id<teamCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *teamIcon;

@end
