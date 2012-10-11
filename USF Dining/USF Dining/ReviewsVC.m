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

- (NSDictionary*)getReviews
{
    NSDictionary *reviews = [[NSDictionary alloc] init];
    
    NSString *jsonUrl = [NSString stringWithFormat:@"http://usfdining.aws.af.cm/%@/reviews/", _foodID];
    
    NSLog(jsonUrl);
    
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
    NSLog(@"%i", [_reviews count]);
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
        [[cell rating] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"StarRate_%@", [review objectForKey:@"rating"]]]];
        
        return cell;
    }
}

@end
