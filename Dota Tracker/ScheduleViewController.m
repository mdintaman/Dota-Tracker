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
#import "upcomingObject.h"
#import "upcomingCell.h"
#import "recentObject.h"
#import "recentCell.h"

@interface ScheduleViewController () {
    NSArray *selectedTeams;
    NSString *currentTeam;
    NSArray *upcomingGamesAll;
    NSArray *upcomingTeam;
    NSArray *recentGamesAll;
    NSArray *recentTeam;
}

@end

@implementation ScheduleViewController

@synthesize tsd;

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
    
    [[self selectedCollectionView]setDataSource:self];
    [[self selectedCollectionView]setDelegate:self];
    [[self upcomingCollectionView]setDataSource:self];
    [[self upcomingCollectionView]setDelegate:self];
    [[self recentCollectionView]setDataSource:self];
    [[self recentCollectionView]setDelegate:self];
    
    AppDelegate *dbDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [dbDelegate readTeamsFromDatabase];
    [dbDelegate readUpcomingFromDatabase];
    [dbDelegate readRecentFromDatabase];
    
    NSPredicate *selectedPredicate = [NSPredicate predicateWithFormat:@"SELF.selected == 1 "];
    
    selectedTeams = [dbDelegate.teams filteredArrayUsingPredicate:selectedPredicate];
    
    upcomingGamesAll = dbDelegate.upcoming;
    
    recentGamesAll = dbDelegate.recent;
    
    currentTeam = [selectedTeams[0] name];
    
    // Do any additional setup after loading the view.
}

-(IBAction)buttonPressed:(id)sender{
    UIButton *hit = (UIButton *)sender;
    currentTeam = hit.titleLabel.text;
    [self.selectedCollectionView reloadData];
    [self.upcomingCollectionView reloadData];
    [self.recentCollectionView reloadData];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.selectedCollectionView) {
        return [selectedTeams count];
    }
    else if (collectionView == self.upcomingCollectionView) {
        return [upcomingTeam count];
    }
    else {
        return [recentTeam count];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.selectedCollectionView) {
    
        teamObject *team = (teamObject *)[selectedTeams objectAtIndex:indexPath.row];
    
        static NSString *CellIdentifier = @"cell";
    
        teamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
        [[cell teamIcon] setImage:[UIImage imageNamed:team.imageNotSelected] forState:UIControlStateNormal];
        [[cell teamIcon] setImage:[UIImage imageNamed:team.imageSelected] forState:UIControlStateSelected];
        [[cell teamIcon] setTitle:[NSString stringWithFormat:@"%@", team.name] forState:UIControlStateNormal];
        [[cell teamIcon] setTitle:[NSString stringWithFormat:@"%@", team.name] forState:UIControlStateSelected];
        [[cell teamIcon].imageView setContentMode:UIViewContentModeScaleAspectFit];
    
        if ([team.name isEqualToString:currentTeam]) {
            [cell teamIcon].selected = YES;
            NSPredicate *upcomingPredicate = [NSPredicate predicateWithFormat:@"team1 == %@ OR team2 == %@", team.name, team.name];
            upcomingTeam = [upcomingGamesAll filteredArrayUsingPredicate:upcomingPredicate];
            recentTeam = [recentGamesAll filteredArrayUsingPredicate:upcomingPredicate];
            NSLog(@"%@", upcomingTeam);
        
        }
        else {
            [cell teamIcon].selected = NO;
        }
    
        return cell;
    
    }
    else if (collectionView == self.upcomingCollectionView) {
        upcomingObject *gg = (upcomingObject *)[upcomingTeam objectAtIndex:indexPath.row];
        
        static NSString *CellIdentifier = @"cell";
        
        upcomingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if ([[gg team1] isEqualToString:currentTeam]){
            [[cell uGame] setImage:[UIImage imageNamed:(@"%@.png", gg.team2)]];
            [[cell uGame] setContentMode:UIViewContentModeScaleAspectFit];
        }
        else {
            [[cell uGame] setImage:[UIImage imageNamed:(@"%@.png", gg.team1)]];
            [[cell uGame] setContentMode:UIViewContentModeScaleAspectFit];
        }
        
        [[cell timeLeft] setText:gg.gamedate];
        [[cell upcomingTourney] setText:gg.tourney];
        
        return cell;
        
    }
    else{
        recentObject *gg = (recentObject *)[recentTeam objectAtIndex:indexPath.row];
        
        static NSString *CellIdentifier = @"cell";
        
        recentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if ([[gg team1] isEqualToString: currentTeam]){
            [[cell rGame] setImage:[UIImage imageNamed:(@"%@.png", gg.team2)]];
            [[cell rGame] setContentMode:UIViewContentModeScaleAspectFit];
            cell.myscore = gg.team1s;
            cell.theirscore = gg.team2s;
            if (cell.myscore > cell.theirscore) {
                [[cell showButton] setImage:[UIImage imageNamed:@"wonbutton.png"] forState:UIControlStateSelected];
            }
            else if (cell.myscore < cell.theirscore) {
                [[cell showButton] setImage:[UIImage imageNamed:@"lostbutton.png"] forState:UIControlStateSelected];
            }
            else {
                [[cell showButton] setImage:[UIImage imageNamed:@"tiebutton.png"] forState:UIControlStateSelected];
            }
            NSLog(@"ggteam 1 = %@ crrt = %@ ggteam 2 %@", gg.team1, currentTeam, gg.team2);
        }
        else {
            [[cell rGame] setImage:[UIImage imageNamed:(@"%@.png", gg.team1)]];
            [[cell rGame] setContentMode:UIViewContentModeScaleAspectFit];
            cell.myscore = gg.team2s;
            cell.theirscore = gg.team1s;
            if (cell.myscore > cell.theirscore) {
                [[cell showButton] setImage:[UIImage imageNamed:@"wonbutton.png"] forState:UIControlStateSelected];
            }
            else if (cell.myscore < cell.theirscore) {
                [[cell showButton] setImage:[UIImage imageNamed:@"lostbutton.png"] forState:UIControlStateSelected];
            }
            else {
                [[cell showButton] setImage:[UIImage imageNamed:@"tiebutton.png"] forState:UIControlStateSelected];
            }
            NSLog(@"ggteam 1 = %@ crrt = %@ ggteam 2 %@", gg.team1, currentTeam, gg.team2);
        }
        
        if ([gg bo] == 5) {
            [[cell g1] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g2] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g3] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g4] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g5] setImage:[UIImage imageNamed:@"hiddeng.png"]];
        }
        else if ([gg bo] == 3) {
            [[cell g1] setImage:nil];
            [[cell g2] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g3] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g4] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g5] setImage:nil];
        }
        else if ([gg bo] == 2) {
            [[cell g1] setImage:nil];
            [[cell g2] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g3] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g4] setImage:nil];
            [[cell g5] setImage:nil];
        }
        else {
            [[cell g1] setImage:nil];
            [[cell g2] setImage:nil];
            [[cell g3] setImage:[UIImage imageNamed:@"hiddeng.png"]];
            [[cell g4] setImage:nil];
            [[cell g5] setImage:nil];
        }
        
        NSLog(@"%ld", (long)cell.shown);
       
        
        cell.showButton.selected = NO;
        
        
        [[cell showButton] setImage:[UIImage imageNamed:@"showbutton.png"] forState:UIControlStateNormal];
        [[cell showButton].imageView setContentMode:UIViewContentModeScaleAspectFit];
        [[cell recentTourney] setText:gg.tourney];
        
        return cell;
    }
    
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
