//
//  SplitViewController.m
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController ()

@end

@implementation SplitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    model = [[TimeSheet alloc] init];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) startButtonPress:(id)sender
{
    NSLog(@"Start Button");
    [model start];
}

- (IBAction) splitButtonPress:(id)sender
{
    NSLog(@"Split Button");
    [model addSplit];
    _display.text = [model lastSplit:@"HH:MM:ss.SSSS"];
}

- (IBAction) stopButtonPress: (id)sender
{
    NSLog(@"Stop Button");
    [model stop];
    NSString* time = [model getElapsedTime:@"ss.SSSS"];
    NSLog(@"[Total Elapsed] %@", time);
    _display.text = time;
}

@end
