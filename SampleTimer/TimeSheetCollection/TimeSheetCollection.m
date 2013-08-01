//
// Created by Ryan Lovelett on 7/31/13.
// Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TimeSheetCollection.h"


@implementation NSMutableArray (TimeSheetCollection)

- (TimeSheet*) createTimeSheet
{
    TimeSheet* ts = [[TimeSheet alloc] init];
    [self addObject:ts];
    return ts;
}

- (TimeSheet*) getTimeSheetAtIndex:(NSUInteger) index
{
    return (TimeSheet*)[self objectAtIndex:index];
}

- (TimeSheet*) lastTimeSheet
{
    return (TimeSheet*)[self lastObject];
}

@end