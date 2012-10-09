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
    
    [self setFoods:[self getFoods]];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [_table deselectRowAtIndexPath:[_table indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)getFoods
{
    NSDictionary *foods = [[NSDictionary alloc] init];
    
    NSString *jsonUrl = [NSString stringWithFormat:@"http://usfdining.aws.af.cm/%@/food/", _venueID];
    
    NSLog(jsonUrl);
    
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
    NSLog(@"%i", [_foods count]);
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
    //[[cell image] setImage:[UIImage imageNamed:[food objectForKey:@"photo"]]];
    [[cell rating] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"StarRate_%@", [food objectForKey:@"rating"]]]];
    
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
