//
//  DataManagerViewController.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/31/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitAppDelegate.h"

@interface DataManagerViewController : UIViewController
{
    SplitAppDelegate* appDelegate;
    NSMutableArray* timeSheets;
    TimeSheet* activeTimeSheet;
}

@end
