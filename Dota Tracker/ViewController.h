//
//  ViewController.h
//  Dota Tracker
//
//  Created by Mike on 4/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    IBOutlet UISegmentedControl *regionControl;
    IBOutlet UILabel *regionHeader;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *regionCollectionView;
@property (strong, nonatomic) NSString *teamDatabasePath;
@property (nonatomic) sqlite3 *contactDB;

- (IBAction)regionSelected;


@end
