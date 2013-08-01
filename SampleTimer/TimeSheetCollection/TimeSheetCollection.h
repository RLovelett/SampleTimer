//
// Created by Ryan Lovelett on 7/31/13.
// Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TimeSheet.h"

@interface NSMutableArray (TimeSheetCollection)
- (TimeSheet*) createTimeSheet;

- (TimeSheet*) getTimeSheetAtIndex:(NSUInteger) index;

- (TimeSheet*) lastTimeSheet;
@end