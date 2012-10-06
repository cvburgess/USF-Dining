//
//  ReviewCell.h
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *rating;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *reviewTxt;

@end
