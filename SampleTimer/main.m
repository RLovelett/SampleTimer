//
//  main.m
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SplitAppDelegate.h"
#import "TimeSheet.h"

int main(int argc, char *argv[])
{
    TimeSheet* instanceOfTimeSheet = [[TimeSheet alloc] init];
    
    [instanceOfTimeSheet start];
    
    sleep(2); // sleep for 2s
    
    NSLog(@"[Running] %@", [instanceOfTimeSheet getElapsedTime:@"ss.SSSS"]);
    
    [instanceOfTimeSheet stop];
    
    NSLog(@"[Total Elapsed] %@", [instanceOfTimeSheet getElapsedTime:@"ss.SSSS"]);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SplitAppDelegate class]));
    }
}
