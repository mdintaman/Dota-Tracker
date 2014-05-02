//
//  ViewController.m
//  Dota Tracker
//
//  Created by Mike on 4/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "regionCell.h"
#import "AppDelegate.h"
#import "teamObject.h"


@interface ViewController () {
    
    NSArray *arrayOfChinaRegion;
    NSArray *arrayOfSEARegionIcons;
    NSArray *arrayOfEURegionIcons;
    NSArray *arrayOfNARegionIcons;
    NSArray *arrayOfKoreaRegionIcons;
    NSArray *arrayOfIcons;
    NSArray *arrayOfGraySEARegionIcons;
    NSArray *arrayOfGrayEURegionIcons;
    NSArray *arrayOfGrayNARegionIcons;
    NSArray *arrayOfGrayKoreaRegionIcons;
    NSArray *arrayOfGrayIcons;

}
@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController

- (IBAction)regionSelected {
    
    if(regionControl.selectedSegmentIndex == 0) {
        arrayOfIcons = arrayOfChinaRegion;
    }
    
    if(regionControl.selectedSegmentIndex == 1) {
        arrayOfIcons = arrayOfSEARegionIcons;
        arrayOfGrayIcons = arrayOfGraySEARegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 2) {
        arrayOfIcons = arrayOfEURegionIcons;
        arrayOfGrayIcons = arrayOfGrayEURegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 3) {
        arrayOfIcons = arrayOfNARegionIcons;
        arrayOfGrayIcons = arrayOfGrayNARegionIcons;
    }
    
    if(regionControl.selectedSegmentIndex == 4) {
        arrayOfIcons = arrayOfKoreaRegionIcons;
        arrayOfGrayIcons = arrayOfGrayKoreaRegionIcons;
    }

    [self.regionCollectionView reloadData];
    
}

-(NSManagedObjectContext*)managedObjectContext {
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self regionCollectionView]setDataSource:self];
    [[self regionCollectionView]setDelegate:self];
    
    AppDelegate *dbDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSInteger testint = 1;
    NSLog(@"SELF.region == %d", testint);
    
    NSPredicate *chinaPredicate = [NSPredicate predicateWithFormat:@"SELF.name beginswith[c] 'M' "];
    
    arrayOfChinaRegion = [dbDelegate.teams filteredArrayUsingPredicate:chinaPredicate];
    
    arrayOfGraySEARegionIcons = dbDelegate.teams;
    
    arrayOfSEARegionIcons = [[NSArray alloc] initWithObjects:@"Titan.PNG", @"Scythe.PNG", @"Arrow.PNG", @"Orange.PNG", @"Mineski.PNG", @"FD.PNG", @"Mith.PNG", nil];
    
    arrayOfGrayEURegionIcons = [[NSArray alloc] initWithObjects:@"Empiregray.PNG", @"NaVigray.PNG", @"Fnaticgray.PNG", @"Alliancegray.PNG", @"TeamDoggray.PNG", @"Roxgray.PNG", @"PRgray.PNG", @"Sigmagray.PNG", @"NEXTkzgray.PNG", @"Relaxgray.PNG", @"VPgray.PNG", @"MYMgray.PNG", nil];
    
    arrayOfEURegionIcons = [[NSArray alloc] initWithObjects:@"Empire.PNG", @"NaVi.PNG", @"Fnatic.PNG", @"Alliance.PNG", @"TeamDog.PNG", @"Rox.PNG", @"PR.PNG", @"Sigma.PNG", @"NEXTkz.PNG", @"Relax.PNG", @"VP.PNG", @"MYM.PNG", nil];
    
    arrayOfGrayNARegionIcons = [[NSArray alloc] initWithObjects:@"EGgray.PNG", @"C9gray.PNG", @"Liquidgray.PNG", @"Revengegray.PNG", @"Ehuggray.PNG", @"CNBgray.PNG", nil];
    
    arrayOfNARegionIcons = [[NSArray alloc] initWithObjects:@"EG.PNG", @"C9.PNG", @"Liquid.PNG", @"Revenge.PNG", @"Ehug.PNG", @"CNB.PNG", nil];
    
    arrayOfGrayKoreaRegionIcons = [[NSArray alloc] initWithObjects:@"Zephyrgray.PNG", @"MVPgray.PNG", @"EOTgray.PNG", nil];
    
    arrayOfKoreaRegionIcons = [[NSArray alloc] initWithObjects:@"Zephyr.PNG", @"MVP.PNG", @"EOT.PNG", nil];
    
    arrayOfIcons = arrayOfChinaRegion;

}

//data source and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int butt = [arrayOfIcons count];
    NSLog(@"%i", butt);
    return [arrayOfIcons count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    teamObject *team = (teamObject *)[arrayOfIcons objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"cell";
    
    regionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell regionIcon] setImage:[UIImage imageNamed:team.imageNotSelected] forState:UIControlStateNormal];
    [[cell regionIcon] setImage:[UIImage imageNamed:team.imageSelected] forState:UIControlStateSelected];
    [[cell regionIcon].imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    return cell;
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
