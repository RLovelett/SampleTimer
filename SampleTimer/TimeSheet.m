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
    lastAction = FRESH;
    cellIdentifier = @"TimeSheetSplitCell";
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
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

- (NSString*) splitAtIndex:(NSIndexPath *)indexPath
{
    NSDate* start = [splitTimes objectAtIndex:indexPath.row];
    NSDate* stop = [splitTimes objectAtIndex:(indexPath.row + 1)];
    NSTimeInterval interval = [stop timeIntervalSinceDate:start];
    [formatter setFormat: @"MM:ss.SS"];
    return [formatter stringFromInterval:interval];
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [splitTimes count];
    if (count > 0) {
        count -= 1;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* localCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [localCell.textLabel setText:[self splitAtIndex:indexPath]];
    
    UIColor* color = [UIColor colorWithRed:102/255.0f green:154/255.0f blue:249/255.0f alpha:1.0f];
    localCell.textLabel.textColor = color;
    
    UIFont* fontBPmono = [UIFont fontWithName:@"BPmono" size:21.0];
    localCell.textLabel.font = fontBPmono;
    
    return localCell;
}

@end
