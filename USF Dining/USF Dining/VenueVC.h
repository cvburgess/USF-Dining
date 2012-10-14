//
//  VenueVC.h
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueVC : UIViewController

@property (nonatomic, retain) NSDictionary *foods;
@property (nonatomic, retain) NSString *venueID;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;

@end
