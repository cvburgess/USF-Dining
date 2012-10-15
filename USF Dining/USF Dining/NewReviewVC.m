//
//  NewReviewVC.m
//  USF Dining
//
//  Created by Charles Burgess on 10/6/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import "NewReviewVC.h"

@interface NewReviewVC ()

@end

@implementation NewReviewVC

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rate:(id)sender {
    [self setStars:[sender tag]];
    
    for (UIButton *button in [[self view] subviews])
    {
        if([button isKindOfClass:[UIButton class]])
        {
            if ([button tag] <= [sender tag])
            {
                [button setImage:[UIImage imageNamed:@"StarSelected"] forState:UIControlStateNormal];
            }
            else if ([button tag] < 6)
            {
                [button setImage:[UIImage imageNamed:@"StarUnSelected"] forState:UIControlStateNormal];
            }
        }
    }
}

@end
