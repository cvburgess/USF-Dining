//
//  NewReviewVC.h
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewReviewVC : UIViewController

@property (nonatomic, assign) NSInteger stars;

- (IBAction)rate:(id)sender;

@end
