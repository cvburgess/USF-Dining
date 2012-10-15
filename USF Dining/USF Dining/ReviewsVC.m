//
//  ReviewsVC.m
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import "ReviewsVC.h"
#import "JSONKit.h"
#import "ReviewCell.h"

@interface ReviewsVC ()

@end

@implementation ReviewsVC

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
    [self setReviews:[self getReviews]];
}

- (void) viewWillAppear:(BOOL)animated {
    [_table deselectRowAtIndexPath:[_table indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
    
    float sHeight;
    
    if ([[UIScreen mainScreen] bounds].size.height == 480.00) { // iPhone 3.5 display
        if ([_reviews count] <= 1) {
            sHeight = 416;
        }
        else {
            sHeight = 220 + (100 * [_reviews count]); // header (150) + table padding (20) + row1 (50) + row height (100) * number of foods
        }
    }
    
    else {
        if ([_reviews count] <= 2) {
            sHeight = 504;
        }
        else {
            sHeight = 220 + (100 * [_reviews count]);
        }
    }
    
    [_mainScroll setContentSize:CGSizeMake(320, sHeight)];
    
    //NSURL *photoURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://usfdiningapp/%@/headerImage", _foodID]];
    [_headerImage loadImageAtURL:[NSURL URLWithString:@"http://.jpg"] placeholderImage:[UIImage imageNamed:@"Tomato_Pasta_Penne.jpg"]];
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)getReviews
{
    NSDictionary *reviews = [[NSDictionary alloc] init];
    
    NSString *jsonUrl = [NSString stringWithFormat:@"http://usfdiningapp.com/food/%@/reviews/", _foodID];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrl]];
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoder];
    reviews = [jsonKitDecoder objectWithData:jsonData];
    
    return reviews;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_reviews count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 50.0;
    }
    else {
        return 100.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0)
    {
        static NSString *CellIdentifier = @"newCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"UITableViewCell" bundle:nil];
            cell = (UITableViewCell *)temporaryController.view;
        }
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"iCell";
        
        ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"ReviewCell" bundle:nil];
            cell = (ReviewCell *)temporaryController.view;
        }
        
        NSDictionary *review = [_reviews objectForKey:[NSString stringWithFormat:@"%i", [indexPath row]-1]];
        
        [[cell title] setText:@"Charles B."];//[review objectForKey:@"name"]];
        [[cell reviewTxt] setText:[review objectForKey:@"text"]];
        //[[cell image] setImage:[UIImage imageNamed:[review objectForKey:@"photo"]]];
        [[cell rating] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"StarRateVert%@", [review objectForKey:@"rating"]]]];
        
        return cell;
    }
}

@end
