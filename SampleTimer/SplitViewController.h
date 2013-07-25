//
//  SplitViewController.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSheet.h"

@interface SplitViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    TimeSheet* model;
    UIFont* labelFont;
    NSTimer* updateUI;
    UIView* touchContact;
    NSMutableArray* splitIntervals;

}

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *millidisplay;

@property (weak, nonatomic) IBOutlet UITableView *splitstable;

- (IBAction)startOnTap:(UITapGestureRecognizer *)sender;
- (IBAction)stopOnHold:(UILongPressGestureRecognizer *)sender;

@end
