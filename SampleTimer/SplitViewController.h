//
//  SplitViewController.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSheet.h"

@interface SplitViewController : UIViewController <UIAlertViewDelegate>
{
    TimeSheet* model;
    UIFont* labelFont;
    NSTimer* updateUI;
    UIView* touchContact;
    UIAlertView* undoAlert;
}

@property(weak, nonatomic) IBOutlet UILabel* display;
@property(weak, nonatomic) IBOutlet UILabel* millidisplay;
@property(weak, nonatomic) IBOutlet UITableView* splitsTable;

- (IBAction) startOnTap:(UITapGestureRecognizer*) sender;

- (IBAction) stopOnHold:(UILongPressGestureRecognizer*) sender;

@end