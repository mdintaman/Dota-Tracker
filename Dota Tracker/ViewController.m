//
//  ViewController.m
//  Dota Tracker
//
//  Created by Mike on 4/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "regionCell.h"

@interface ViewController () {
    
    NSArray *arrayOfChinaRegionIcons;
    NSArray *arrayOfSEARegionIcons;
    NSArray *arrayOfEURegionIcons;
    NSArray *arrayOfNARegionIcons;
    NSArray *arrayOfKoreaRegionIcons;
    NSArray *arrayOfIcons;
    NSArray *arrayOfGrayChinaRegionIcons;
    NSArray *arrayOfGrayIcons;

}


@end

@implementation ViewController


-(void)cellButtonPressed:(regionCell*)cell  {
    NSLog(@"Pressed");
}


- (IBAction)regionSelected {
    
    if(regionControl.selectedSegmentIndex == 0) {
        arrayOfIcons = arrayOfChinaRegionIcons;
        arrayOfGrayIcons = arrayOfGrayChinaRegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 1) {
        arrayOfIcons = arrayOfSEARegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 2) {
        arrayOfIcons = arrayOfEURegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 3) {
        arrayOfIcons = arrayOfNARegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 4) {
        arrayOfIcons = arrayOfKoreaRegionIcons;
    }

    [self.regionCollectionView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self regionCollectionView]setDataSource:self];
    [[self regionCollectionView]setDelegate:self];
    
    arrayOfGrayChinaRegionIcons = [[NSArray alloc] initWithObjects:@"DKgray.png", @"Alliancegray.png", @"Arrowgray.png", @"C9gray.png", @"CISgray.png", @"CNBgray", @"DTgray.png", @"EGgray", @"Ehuggray.png", nil];
    
    arrayOfChinaRegionIcons = [[NSArray alloc] initWithObjects:@"DK.PNG", @"IG.PNG", @"VG.PNG", @"LGD.PNG", @"Newbee.PNG", @"DT.PNG", @"CIS.PNG", @"HGT.PNG", @"TongFu.PNG", nil];
    
    arrayOfSEARegionIcons = [[NSArray alloc] initWithObjects:@"Titan.PNG", @"Scythe.PNG", @"Arrow.PNG", @"Orange.PNG", @"Mineski.PNG", @"FD.PNG", @"Mith.PNG", nil];
    
    arrayOfEURegionIcons = [[NSArray alloc] initWithObjects:@"Empire.PNG", @"NaVi.PNG", @"Fnatic.PNG", @"Alliance.PNG", @"TeamDog.PNG", @"Rox.PNG", @"PR.PNG", @"Sigma.PNG", @"NEXTkz.PNG", @"Relax.PNG", @"VP.PNG", @"MYM.PNG", nil];
    
    arrayOfNARegionIcons = [[NSArray alloc] initWithObjects:@"EG.PNG", @"C9.PNG", @"Liquid.PNG", @"Revenge.PNG", @"Ehug.PNG", @"CNB.PNG", nil];
    
    arrayOfKoreaRegionIcons = [[NSArray alloc] initWithObjects:@"Zephyr.PNG", @"MVP.PNG", @"EOT.PNG", nil];
    
    arrayOfGrayIcons = arrayOfGrayChinaRegionIcons;
    arrayOfIcons = arrayOfChinaRegionIcons;

}

//data source and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayOfIcons count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    regionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell regionIcon] setImage:[UIImage imageNamed:[arrayOfGrayIcons objectAtIndex:indexPath.item]] forState:UIControlStateNormal];
    [[cell regionIcon] setImage:[UIImage imageNamed:[arrayOfIcons objectAtIndex:indexPath.item]] forState:UIControlStateSelected];
    [[cell regionIcon].imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    return cell;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
