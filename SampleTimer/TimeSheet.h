//
//  TimeSheet.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSTimeIntervalFormatter.h"

typedef enum {
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
    NSMutableArray* splitTimes;
    
    
    TimeSheetActions lastAction;
    
    NSTimeIntervalFormatter* formatter;
}

- (void) setTitle:(NSString*)newTitle;
- (void) start;
- (void) addSplit;
- (void) stop;
- (void) catchTemp;
- (void) undo;

- (Boolean) isStopped;
- (Boolean) isStarted;

- (NSString*) lastSplit:(NSString*)format;
- (NSString*) getElapsedTime:(NSString*)format;
- (int) splitIntervalsCount;
- (NSMutableArray*) getSplitIntervals;

@end