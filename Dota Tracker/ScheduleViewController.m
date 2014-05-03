//
//  ScheduleViewController.m
//  Dota Tracker
//
//  Created by Mike on 5/2/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "ScheduleViewController.h"
#import "AppDelegate.h"
#import "teamCell.h"
#import "teamObject.h"

@interface ScheduleViewController () {
    NSArray *selectedTeams;
    NSString *currentTeam;
}

@end

@implementation ScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) changeTeam: (id) sender {
    UIButton *selected = (UIButton *)sender;
    currentTeam = selected.titleLabel.text;
    [self.selectedCollectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self selectedCollectionView]setDataSource:self];
    [[self selectedCollectionView]setDelegate:self];
    
    AppDelegate *dbDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [dbDelegate readTeamsFromDatabase];
    
    NSPredicate *selectedPredicate = [NSPredicate predicateWithFormat:@"SELF.selected == 1 "];
    
    selectedTeams = [dbDelegate.teams filteredArrayUsingPredicate:selectedPredicate];
    
    currentTeam = [selectedTeams[0] name];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)selectedCollectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)selectedCollectionView numberOfItemsInSection:(NSInteger)section
{
    return [selectedTeams count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)selectedCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    teamObject *team = (teamObject *)[selectedTeams objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"cell";
    
    teamCell *cell = [selectedCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell teamIcon] setImage:[UIImage imageNamed:team.imageNotSelected] forState:UIControlStateNormal];
    [[cell teamIcon] setImage:[UIImage imageNamed:team.imageSelected] forState:UIControlStateSelected];
    [[cell teamIcon] setTitle:[NSString stringWithFormat:@"%@", team.name] forState:UIControlStateNormal];
    [[cell teamIcon] setTitle:[NSString stringWithFormat:@"%@", team.name] forState:UIControlStateSelected];
    [[cell teamIcon].imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [cell.teamIcon addTarget:self action:@selector(changeTeam:) forControlEvents:UIControlEventTouchDown];
    
    if (team.name == currentTeam) {
        [cell teamIcon].selected = YES;
    }
    else {
        [cell teamIcon].selected = NO;
    }
    
    return cell;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
