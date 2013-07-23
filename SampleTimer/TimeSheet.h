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

@interface TimeSheet : NSObject {
    NSString* eventTitle;
    NSDate* startTime;
    NSDate* stopTime;
    NSDate* tempTime;
    NSMutableArray* splitTimes;
    TimeSheetActions lastAction;
    
    NSTimeIntervalFormatter* formatter;
}

// [instanceOfTimeSheet setTitle:"New Title"]
- (void) setTitle:(NSString*)newTitle;
- (void) start;
- (void) addSplit;
- (void) stop;
- (void) catchTemp;
- (void) undo;

- (Boolean) isStarted;
- (NSString*) lastSplit:(NSString*)format;

// instanceOfTimeSheet = [new TimeSheett] ??
// [instanceOfTimeSheet start]
// [instanceOfTimeSheet getElapsedTime:"HH:mm:ss"]
- (NSString*) getElapsedTime:(NSString*)format;

@end