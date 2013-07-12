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

- (void) stop
{
    stopTime = [NSDate date];
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
