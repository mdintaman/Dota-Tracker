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
    NSArray *arrayOfSEARegion;
    NSArray *arrayOfEURegion;
    NSArray *arrayOfNARegion;
    NSArray *arrayOfKoreaRegion;
    NSArray *arrayOfIcons;
}
@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController

- (IBAction)regionSelected {
    
    if(regionControl.selectedSegmentIndex == 0) {
        arrayOfIcons = arrayOfChinaRegion;
    }
    
    if(regionControl.selectedSegmentIndex == 1) {
        arrayOfIcons = arrayOfSEARegion;
    }
    
    if(regionControl.selectedSegmentIndex == 2) {
        arrayOfIcons = arrayOfEURegion;
    }
    
    if(regionControl.selectedSegmentIndex == 3) {
        arrayOfIcons = arrayOfNARegion;
    }
    
    if(regionControl.selectedSegmentIndex == 4) {
        arrayOfIcons = arrayOfKoreaRegion;
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
    
    NSPredicate *chinaPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 1 "];
    NSPredicate *seaPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 2 "];
    NSPredicate *euPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 3 "];
    NSPredicate *naPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 4 "];
    NSPredicate *koreaPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 5 "];
    
    arrayOfChinaRegion = [dbDelegate.teams filteredArrayUsingPredicate:chinaPredicate];
    
    arrayOfSEARegion = [dbDelegate.teams filteredArrayUsingPredicate:seaPredicate];
    
    arrayOfEURegion = [dbDelegate.teams filteredArrayUsingPredicate:euPredicate];
    
    arrayOfNARegion = [dbDelegate.teams filteredArrayUsingPredicate:naPredicate];
    
    arrayOfKoreaRegion = [dbDelegate.teams filteredArrayUsingPredicate:koreaPredicate];
    
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
