//
//  VenueVC.m
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import "VenueVC.h"
#import "JSONKit.h"
#import "MainCell.h"
#import "ReviewsVC.h"

@interface VenueVC ()

@end

@implementation VenueVC

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
    [_headerText setText:_venueInfo];
    [self setFoods:[self getFoods]];
}

- (void) viewWillAppear:(BOOL)animated {
    [_table deselectRowAtIndexPath:[_table indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
    
    float sHeight;
    
    if ([[UIScreen mainScreen] bounds].size.height == 480.00) { // iPhone 3.5 display
        if ([_foods count] <= 4) {
            sHeight = 416;
        }
        else {
            sHeight = 170 + (50 * [_foods count]); // header (150) + table padding (20px) + row height (50) * number of foods
        }
    }
    
    else {
        if ([_foods count] <= 6) {
            sHeight = 504;
        }
        else {
            sHeight = 170 + (50 * [_foods count]);
        }
    }
    
    [_mainScroll setContentSize:CGSizeMake(320, sHeight)];
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)getFoods
{
    NSDictionary *foods = [[NSDictionary alloc] init];
    
    NSString *jsonUrl = [NSString stringWithFormat:@"http://usfdiningapp.com/venues/%@/food/", _venueID];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrl]];
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoder];
    foods = [jsonKitDecoder objectWithData:jsonData];
    
    return foods;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_foods count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"iCell";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"MainCell" bundle:nil];
        cell = (MainCell *)temporaryController.view;
    }
    
    NSDictionary *food = [_foods objectForKey:[NSString stringWithFormat:@"%i", [indexPath row]]];
    
    [[cell title] setText:[food objectForKey:@"name"]];
    [[cell rating] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"StarRate_%@", [food objectForKey:@"rating"]]]];
    
    if ([indexPath row] == 0) {
        [[cell image] setImage:[UIImage imageNamed:@"RaspberryCake.jpg"]];
    }
    else if ([indexPath row] == 1) {
        [[cell image] setImage:[UIImage imageNamed:@"ChickenSandwhich.jpg"]];
    }
    else if ([indexPath row] == 2) {
        [[cell image] setImage:[UIImage imageNamed:@"ChocolateCake.jpg"]];
    }
    else if ([indexPath row] == 3) {
        [[cell image] setImage:[UIImage imageNamed:@"Tacos.jpg"]];
    }
    else if ([indexPath row] == 4) {
        [[cell image] setImage:[UIImage imageNamed:@"PastaMeatSauce.jpg"]];
    }
    else {
        [[cell image] setImage:[UIImage imageNamed:@"RaspberryCake.jpg"]];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"MainSegue"]) {
        
        NSIndexPath *indexPath = [_table indexPathForSelectedRow];
        
        NSDictionary *food = [_foods objectForKey:[NSString stringWithFormat:@"%i", [indexPath row]]];
        
        NSString *foodID = [food objectForKey:@"id"];
        
        ReviewsVC *reviewsVC = [segue destinationViewController];
        reviewsVC.foodID = foodID;
    }
}

@end
