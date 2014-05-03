//
//  ScheduleViewController.h
//  Dota Tracker
//
//  Created by Mike on 5/2/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *selectedCollectionView;

- (void) changeTeam:(id) sender;

@end
