//
//  TimeSheet.m
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import "TimeSheet.h"
#import "NSTimeIntervalFormatter.h"

@implementation TimeSheet

- (id) init
{
    self = [super init];
    formatter = [[NSTimeIntervalFormatter alloc] init];
    splitTimes = [[NSMutableArray alloc] init];
    splitIntervals = [[NSMutableArray alloc] init];
    lastAction = FRESH;
    
    return self;
}

- (void) catchTemp
{
    tempTime = [NSDate date];
}

- (void) setTitle:(NSString *)newTitle
{
    eventTitle = newTitle;
}

- (void) start
{
    lastAction = START;
    startTime = tempTime;
    [splitTimes addObject: tempTime];
}

- (void) addSplit
{
    [splitTimes addObject: tempTime];
    [splitIntervals addObject: [self lastSplit:@"HH:MM:ss.SSS"]];
    
    lastAction = SPLIT;
}

- (void) stop
{
    stopTime = tempTime;
    lastAction = STOP;
}

- (Boolean) isStarted
{
    return lastAction != FRESH;
}

- (Boolean) isStopped
{
    return lastAction == STOP;
}

- (Boolean) hasSplits
{
    return [splitTimes count] > 1;
}

- (void) undo
{
    switch (lastAction) {
        case START:
            lastAction = FRESH;
            startTime = nil;
            [splitTimes removeAllObjects];
            break;
        case SPLIT:
            [splitTimes removeLastObject];
            if ([self hasSplits]) {
                lastAction = SPLIT;
            }
            else
            {
                lastAction = START;
            }
            break;
        case STOP:
            stopTime = nil;
            if ([self hasSplits]) {
                lastAction = SPLIT;
            }
            else
            {
                lastAction = START;
            }
            break;
        default:
            break;
    }
}

- (NSString*) lastSplit:(NSString *)format
{
    NSDate* now = tempTime;
    NSDate* nextToLast;
    NSDate* last = [splitTimes lastObject];
    if ([splitTimes count] < 2) {
        nextToLast = now;
    } else {
        nextToLast = [splitTimes objectAtIndex:[splitTimes count] - 2];
    }
    
    NSTimeInterval interval = fabs([last timeIntervalSinceDate: nextToLast]);
    [formatter setFormat: format];
    
    return [formatter stringFromInterval: interval];
}

- (NSString*) getElapsedTime:(NSString *)format
{
    NSTimeInterval interval = 0;
    if (stopTime == NULL) {
        NSDate* now = [NSDate date];
        interval = [now timeIntervalSinceDate: startTime];
    } else {
        interval = [tempTime timeIntervalSinceDate: startTime];
    }
    
    [formatter setFormat: format];
    return [formatter stringFromInterval: interval];
}

- (int) splitIntervalsCount;
{
    return [splitIntervals count];
}

- (NSMutableArray*) getSplitIntervals
{
    return splitIntervals;
}


@end
