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
}

@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction) startButtonPress:(id)sender;
- (IBAction) splitButtonPress:(id)sender;
- (IBAction) stopButtonPress:(id)sender;

@end
