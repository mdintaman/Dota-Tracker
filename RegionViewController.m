//
//  RegionViewController.m
//  Dota Tracker
//
//  Created by Mike on 4/19/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "RegionViewController.h"
#import "regionCell.h"
#import "ViewController.h"

@interface RegionViewController () {
    
    NSArray *arrayOfChinaRegionIcons;
    NSArray *arrayOfSEARegionIcons;
    NSArray *arrayOfEURegionIcons;
    NSArray *arrayOfNARegionIcons;
    NSArray *arrayOfKoreaRegionIcons;
}

@property (weak, nonatomic) IBOutlet UICollectionView *regionCollectionView;

@end

@implementation RegionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self regionCollectionView]setDataSource:self];
    [[self regionCollectionView]setDelegate:self];
    
    arrayOfChinaRegionIcons = [[NSArray alloc] initWithObjects:@"DK.PNG", @"IG.PNG", @"VG.PNG", @"LGD.PNG", @"Newbee.PNG", @"DT.PNG", @"CIS.PNG", @"HGT.PNG", @"TongFu.PNG", nil];
    
    arrayOfSEARegionIcons = [[NSArray alloc] initWithObjects:@"Titan.PNG", @"Scythe.PNG", @"Arrow.PNG", @"Orange.PNG", @"Mineski.PNG", @"FD.PNG", @"Mith.PNG", nil];
    
    arrayOfEURegionIcons = [[NSArray alloc] initWithObjects:@"Empire.PNG", @"NaVi.PNG", @"Fnatic.PNG", @"Alliance.PNG", @"TeamDog.PNG", @"Rox.PNG", @"PR.PNG", @"Sigma.PNG", @"NEXTkz.PNG", @"Relax.PNG", @"VP.PNG", @"MYM.PNG", nil];
    
    arrayOfNARegionIcons = [[NSArray alloc] initWithObjects:@"EG.PNG", @"Liquid.PNG", @"Revenge.PNG", @"Ehug.PNG", @"CNB.PNG", nil];
    
    arrayOfKoreaRegionIcons = [[NSArray alloc] initWithObjects:@"Zephyr.PNG", @"MVP.PNG", @"EOT.PNG", nil];
    
}

//data source and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayOfChinaRegionIcons count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    regionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    [[cell regionIcon] setImage:[UIImage imageNamed:[arrayOfChinaRegionIcons objectAtIndex:indexPath.item]] forState:UIControlStateNormal];
    [[cell regionIcon].imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    return cell; 
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
