//
//  TimeSheet.h
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeSheet : NSObject {
    NSString* eventTitle;
    NSDate* startTime;
    NSDate* stopTime;
    NSMutableArray* splitTimes;
    NSDateFormatter* formatter;
}

// [instanceOfTimeSheet setTitle:"New Title"]
- (void) setTitle:(NSString*)newTitle;
- (void) start;
- (void) addSplit;
- (void) stop;

// instanceOfTimeSheet = [new TimeSheett] ??
// [instanceOfTimeSheet start]
// [instanceOfTimeSheet getElapsedTime:"HH:mm:ss"]
- (NSString*) getElapsedTime:(NSString*)format;

@end