//
//  TimeSheet.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSTimeIntervalFormatter.h"

typedef enum
{
    FRESH,
    START,
    SPLIT,
    STOP
} TimeSheetActions;

@interface TimeSheet : NSObject <UITableViewDataSource>
{
    NSString* eventTitle;
    NSDate* startTime;
    NSDate* stopTime;
    NSDate* tempTime;
    NSDate* createdAt;
    NSMutableArray* splitTimes;

    // TODO Make the cellIdentifer static const
    NSString* cellIdentifier;
    UITableViewCell* cell;

    TimeSheetActions lastAction;

    NSTimeIntervalFormatter* formatter;
}

- (void) setTitle:(NSString*) newTitle;

- (void) start;

- (void) addSplit;

- (void) stop;

- (void) catchTemp;

- (void) undo;

- (Boolean) isStopped;

- (Boolean) isStarted;

- (NSString*) lapAtIndex:(NSIndexPath*) indexPath;

- (NSString*) splitAtIndex:(NSIndexPath*) indexPath;

- (NSString*) getElapsedTime:(NSString*) format;

@end