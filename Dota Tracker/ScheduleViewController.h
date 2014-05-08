//
//  ScheduleViewController.h
//  Dota Tracker
//
//  Created by Mike on 5/2/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "teamCell.h"

@interface ScheduleViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, teamCellDelegate>
    

@property (weak, nonatomic) IBOutlet UICollectionView *selectedCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *upcomingCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *recentCollectionView;


@end
