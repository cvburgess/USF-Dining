//
//  ReviewsVC.h
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLImageView.h"

@interface ReviewsVC : UIViewController

@property (weak, nonatomic) IBOutlet FLImageView *headerImage;
@property (nonatomic, retain) NSDictionary *reviews;
@property (nonatomic, retain) NSString *foodID;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *photoScroll;

@end
