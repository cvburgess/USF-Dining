//
//  VenuesVC.h
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenuesVC : UIViewController

@property (nonatomic, retain) NSDictionary *venues;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
