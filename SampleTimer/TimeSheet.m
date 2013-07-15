//
//  TimeSheet.m
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import "TimeSheet.h"

@implementation TimeSheet

- (id) init
{
    self = [super init];
    formatter = [[NSDateFormatter alloc] init];
    splitTimes = [[NSMutableArray alloc] init];
    
    return self;
}

- (void) setTitle:(NSString *)newTitle
{
    eventTitle = newTitle;
}

- (void) start
{
    startTime = [NSDate date];
}

- (void) addSplit
{
    NSDate* now = [NSDate date];
    [splitTimes addObject: now];
}

- (void) stop
{
    stopTime = [NSDate date];
}

- (NSString*) lastSplit:(NSString *)format
{
    NSDate* now = [NSDate date];
    NSDate* nextToLast;
    NSDate* last = [splitTimes lastObject];
    if ([splitTimes count] < 2) {
        nextToLast = now;
    } else {
        nextToLast = [splitTimes objectAtIndex:[splitTimes count] - 2];
    }
    
    NSTimeInterval interval = fabs([last timeIntervalSinceDate: nextToLast]);
    
    return [NSString stringWithFormat:@"Interval %.20f", interval];
}

- (NSString*) getElapsedTime:(NSString *)format
{
    NSTimeInterval interval = 0;
    if (stopTime == NULL) {
        NSDate* now = [NSDate date];
        interval = [now timeIntervalSinceDate: startTime];
    } else {
        interval = [stopTime timeIntervalSinceDate: startTime];
    }
    
    NSDate* elapsed = [NSDate dateWithTimeIntervalSinceReferenceDate: interval];
    [formatter setDateFormat: format];
    return [formatter stringFromDate: elapsed];
}

@end
