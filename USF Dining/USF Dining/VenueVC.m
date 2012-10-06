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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)getFoods
{
    NSDictionary *foods = [[NSDictionary alloc] init];
    
    NSString *jsonUrl = [NSString stringWithFormat:@"http://usfdining.aws.af.cm/<%@>/food/", _venueID];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"iCell";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"MainCell" bundle:nil];
        cell = (MainCell *)temporaryController.view;
    }
    
    NSDictionary *venue = [_foods objectForKey:[NSString stringWithFormat:@"%i", [indexPath row]]];
    
    [[cell title] setText:[venue objectForKey:@"name"]];
    //[[cell image] setImage:[UIImage imageNamed:[venue objectForKey:@"photo"]]];
    [[cell rating] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"StarRate_%@", [venue objectForKey:@"rating"]]]];
    
    return cell;
}
@end
