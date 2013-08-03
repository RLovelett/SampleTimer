//
//  SplitAppDelegate.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSheet.h"
#import "TimeSheetCollection.h"

@interface SplitAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow* window;
@property(strong, nonatomic) NSMutableArray* timeSheets;
@property(strong, nonatomic) TimeSheet* activeTimeSheet;

@end
