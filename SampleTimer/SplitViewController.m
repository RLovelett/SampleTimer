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

@synthesize display;
@synthesize millidisplay;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    model = [[TimeSheet alloc] init];
    labelFont = [UIFont fontWithName:@"BPmono" size:50];
    display.font = labelFont;
    millidisplay.font = [UIFont fontWithName:@"BPmono" size:24];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"caught");
    [model catchTemp];
}

- (void) updateLabel
{
    display.text = [model getElapsedTime:@"MM:ss.SS"];
    millidisplay.text = [model getElapsedTime:@"S"];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction) startButtonPress:(id)sender
{
    NSLog(@"Start Button");
    [model start];
}

- (IBAction) splitButtonPress:(id)sender
{
    NSLog(@"Split Button");
    [model addSplit];
    display.text = [model lastSplit:@"MM:ss.SS"];
}

- (IBAction) stopButtonPress: (id)sender
{
    [updateUI invalidate];
    NSLog(@"Stop Button");
    [model stop];
    NSString* time = [model getElapsedTime:@"MM:ss.SS"];
    NSLog(@"[Total Elapsed] %@", time);
    display.text = time;
}*/

- (IBAction)startOnTap:(UITapGestureRecognizer *)sender
{
    [model start];
    updateUI = [NSTimer scheduledTimerWithTimeInterval:(1/30) target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
}

- (IBAction)stopOnHold:(UILongPressGestureRecognizer *)sender
{
   //NSLog(@"[HoldState] %d", sender.state);
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [model stop];
        [updateUI invalidate];
        NSLog(@"Stop Button");
        NSString* time = [model getElapsedTime:@"MM:ss.SS"];
        NSLog(@"[Total Elapsed] %@", time);
        display.text = time;
        millidisplay.text = [model getElapsedTime:@"S"];
    }
}

@end
