//
//  VenuesVC.m
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import "VenuesVC.h"
#import "JSONKit.h"

@interface VenuesVC ()

@end

@implementation VenuesVC

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
    
    [self setVenues:[self getVenues]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)getVenues
{
    NSDictionary *venues = [[NSDictionary alloc] init];
   
    NSString *jsonUrl = [NSString stringWithFormat:@"http://usfdining.aws.af.com/venues/"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrl]];
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoder];
    venues = [jsonKitDecoder objectWithData:jsonData];

    return venues;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
