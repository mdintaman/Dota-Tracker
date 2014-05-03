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
    NSArray *arrayOfIcons;
}
@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController

- (IBAction)regionSelected {
    
    AppDelegate *dbDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [dbDelegate readTeamsFromDatabase];
    
    NSPredicate *chinaPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 1 "];
    NSPredicate *seaPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 2 "];
    NSPredicate *euPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 3 "];
    NSPredicate *naPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 4 "];
    NSPredicate *koreaPredicate = [NSPredicate predicateWithFormat:@"SELF.region == 5 "];
    
    if(regionControl.selectedSegmentIndex == 0) {
        arrayOfIcons = [dbDelegate.teams filteredArrayUsingPredicate:chinaPredicate];
    }
    
    if(regionControl.selectedSegmentIndex == 1) {
        arrayOfIcons = [dbDelegate.teams filteredArrayUsingPredicate:seaPredicate];
    }
    
    if(regionControl.selectedSegmentIndex == 2) {
        arrayOfIcons = [dbDelegate.teams filteredArrayUsingPredicate:euPredicate];
    }
    
    if(regionControl.selectedSegmentIndex == 3) {
        arrayOfIcons = [dbDelegate.teams filteredArrayUsingPredicate:naPredicate];
    }
    
    if(regionControl.selectedSegmentIndex == 4) {
        arrayOfIcons = [dbDelegate.teams filteredArrayUsingPredicate:koreaPredicate];
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
    
    arrayOfIcons = [dbDelegate.teams filteredArrayUsingPredicate:chinaPredicate];

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
    teamObject *team = (teamObject *)[arrayOfIcons objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"cell";
    
    regionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [[cell regionIcon] setImage:[UIImage imageNamed:team.imageNotSelected] forState:UIControlStateNormal];
    [[cell regionIcon] setImage:[UIImage imageNamed:team.imageSelected] forState:UIControlStateSelected];
    [[cell regionIcon] setTitle:[NSString stringWithFormat:@"%@", team.name] forState:UIControlStateNormal];
    [[cell regionIcon] setTitle:[NSString stringWithFormat:@"%@", team.name] forState:UIControlStateSelected];
    [[cell regionIcon].imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    if (team.selected == 0) {
        [cell regionIcon].selected = NO;
    }
    else {
        [cell regionIcon].selected = YES;
    }
    
    return cell;
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
