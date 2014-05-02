//
//  regionCell.h
//  Dota Tracker
//
//  Created by Mike on 4/19/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface regionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *regionIcon;

- (IBAction)teamSelected;

@end
