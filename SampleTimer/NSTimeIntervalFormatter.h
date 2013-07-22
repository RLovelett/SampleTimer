//
//  NSTimeIntervalFormatter.h
//  NSTimeIntervalFormatter
//
//  Created by Ryan Lovelett on 7/19/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimeIntervalFormatter : NSObject {
    NSString* timeFormat;
    NSRange timeFormatRange;

    NSRegularExpression* hourRegex;
    NSRegularExpression* minuteRegex;
    NSRegularExpression* secondRegex;
    NSRegularExpression* milliSecondRegex;

    uint milliSecondMultiplier;
}

- (id) init;
- (NSString*) stringFromInterval:(NSTimeInterval) interval;
- (void) setFormat:(NSString *) format;

@end
