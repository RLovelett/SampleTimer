//
//  SplitViewController.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSheet.h"

@interface SplitViewController : UIViewController {
    TimeSheet* model;
    UIFont* labelFont;
    NSTimer* updateUI;
    UIView* touchContact;
}

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *millidisplay;

//- (IBAction) startButtonPress:(id)sender;
//- (IBAction) splitButtonPress:(id)sender;
//- (IBAction) stopButtonPress:(id)sender;
- (IBAction)startOnTap:(UITapGestureRecognizer *)sender;
- (IBAction)stopOnHold:(UILongPressGestureRecognizer *)sender;

@end
