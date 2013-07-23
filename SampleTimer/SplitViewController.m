//
//  SplitViewController.m
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/12/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import "SplitViewController.h"

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
    millidisplay.text = [[model getElapsedTime:@"SSS"] substringWithRange:NSMakeRange(2, 1)];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOnTap:(UITapGestureRecognizer *)sender
{
    [model start];
    updateUI = [NSTimer scheduledTimerWithTimeInterval:(1/30) target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
}

- (IBAction)stopOnHold:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [model stop];
        [updateUI invalidate];
        NSLog(@"Stop Button");
        NSString* time = [model getElapsedTime:@"MM:ss.SS"];
        NSLog(@"[Total Elapsed] %@", time);
        [self updateLabel];
    }
}

@end
