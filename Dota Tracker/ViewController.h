//
//  ViewController.h
//  Dota Tracker
//
//  Created by Mike on 4/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    IBOutlet UISegmentedControl *regionControl;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *regionCollectionView;

- (IBAction)regionSelected;


@end
