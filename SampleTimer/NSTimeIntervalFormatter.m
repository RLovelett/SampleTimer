//
//  NSTimeIntervalFormatter.m
//  NSTimeIntervalFormatter
//
//  Created by Ryan Lovelett on 7/19/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import "NSTimeIntervalFormatter.h"
#import "Constants.h"

@implementation NSTimeIntervalFormatter

- (id) init
{
    self = [super init];

    NSError* error = nil;

    hourRegex = [NSRegularExpression regularExpressionWithPattern:@"H+" options:0 error:&error];
    minuteRegex = [NSRegularExpression regularExpressionWithPattern:@"M+" options:0 error:&error];
    secondRegex = [NSRegularExpression regularExpressionWithPattern:@"s+" options:0 error:&error];
    milliSecondRegex = [NSRegularExpression regularExpressionWithPattern:@"S+" options:0 error:&error];

    return self;
}

- (NSString*) stringFromInterval:(NSTimeInterval) interval
{
    uint wholeSeconds = (uint) interval;
    uint milliseconds = (uint) (fmod(interval, 1.0) * milliSecondMultiplier);

    uint hours = (wholeSeconds / SECONDS_PER_HOUR) % HOURS_PER_DAY;
    uint minutes = (wholeSeconds / SECONDS_PER_MINUTE) % MINUTES_PER_HOUR;
    uint seconds = wholeSeconds % SECONDS_PER_MINUTE;

    //TODO NOT SAFE! Buffer overflow...
    char const* msg[512] = {0};

    sprintf(msg, [timeFormat UTF8String], hours, minutes, seconds, milliseconds);
    NSString* message = [NSString stringWithCString:msg encoding:NSUTF8StringEncoding];
    return message;
}

- (void) setFormat:(NSString*) format
{
    timeFormat = format;
    timeFormatRange = NSMakeRange(0, [timeFormat length]);
    [self extractMilliSecondFormat];
    [self extractSecondFormat];
    [self extractMinuteFormat];
    [self extractHourFormat];
}

- (void) extractHourFormat
{
    NSUInteger numberOfMatches = [hourRegex
            numberOfMatchesInString:timeFormat
                            options:0
                              range:timeFormatRange];

    if (numberOfMatches > 0)
    {
        NSTextCheckingResult* match = [hourRegex
                firstMatchInString:timeFormat
                           options:0
                             range:timeFormatRange];
        uint length = [[timeFormat substringWithRange:[match rangeAtIndex:0]] length];
        NSString* format = [NSString stringWithFormat:@"%%1\\$0%dd", length];

        timeFormat = [hourRegex
                stringByReplacingMatchesInString:timeFormat
                                         options:0
                                           range:timeFormatRange
                                    withTemplate:format];
    }
}

- (void) extractMinuteFormat
{
    NSUInteger numberOfMatches = [minuteRegex
            numberOfMatchesInString:timeFormat
                            options:0
                              range:timeFormatRange];

    if (numberOfMatches > 0)
    {
        NSTextCheckingResult* match = [minuteRegex
                firstMatchInString:timeFormat
                           options:0
                             range:timeFormatRange];
        uint length = [[timeFormat substringWithRange:[match rangeAtIndex:0]] length];
        NSString* format = [NSString stringWithFormat:@"%%2\\$0%dd", length];

        timeFormat = [minuteRegex
                stringByReplacingMatchesInString:timeFormat
                                         options:0
                                           range:timeFormatRange
                                    withTemplate:format];
    }
}

- (void) extractSecondFormat
{
    NSUInteger numberOfMatches = [secondRegex
            numberOfMatchesInString:timeFormat
                            options:0
                              range:timeFormatRange];

    if (numberOfMatches > 0)
    {
        NSTextCheckingResult* match = [secondRegex
                firstMatchInString:timeFormat
                           options:0
                             range:timeFormatRange];
        uint length = [[timeFormat substringWithRange:[match rangeAtIndex:0]] length];
        NSString* format = [NSString stringWithFormat:@"%%3\\$0%dd", length];

        timeFormat = [secondRegex
                stringByReplacingMatchesInString:timeFormat
                                         options:0
                                           range:timeFormatRange
                                    withTemplate:format];
    }
}

- (void) extractMilliSecondFormat
{
    NSUInteger numberOfMatches = [milliSecondRegex
            numberOfMatchesInString:timeFormat
                            options:0
                              range:timeFormatRange];

    if (numberOfMatches > 0)
    {
        NSTextCheckingResult* match = [milliSecondRegex
                firstMatchInString:timeFormat
                           options:0
                             range:timeFormatRange];
        uint length = [[timeFormat substringWithRange:[match rangeAtIndex:0]] length];
        milliSecondMultiplier = (uint) pow(10, length);
        NSString* format = [NSString stringWithFormat:@"%%4\\$0%dd", length];

        timeFormat = [milliSecondRegex
                stringByReplacingMatchesInString:timeFormat
                                         options:0
                                           range:timeFormatRange
                                    withTemplate:format];
    }
}

@end
