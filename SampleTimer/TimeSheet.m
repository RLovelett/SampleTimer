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

double const holdDuration = 0.5;

- (id) init
{
    self = [super init];
    formatter = [[NSTimeIntervalFormatter alloc] init];
    splitTimes = [[NSMutableArray alloc] init];
    
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
    if (startTime == NULL)
    {
        startTime = tempTime;
        [splitTimes addObject: tempTime];
    }
    else
    {
        if (stopTime == NULL)
        {
            NSLog(@"added split");
            [splitTimes addObject: tempTime];
        }
        
    }
}

/*- (void) addSplit
{
    NSDate* now = [NSDate date];
    [splitTimes addObject: now];
}*/

- (void) stop
{
    if (stopTime == NULL)
    {
        stopTime = tempTime;
    }
    else
    {
    stopTime = NULL;
    startTime = NULL;
    splitTimes = NULL;
    }
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

@end
