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
    // Register motion ended
    [self canBecomeFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
    model = [[TimeSheet alloc] init];
    labelFont = [UIFont fontWithName:@"BPmono" size:50];
    display.font = labelFont;
    millidisplay.font = [UIFont fontWithName:@"BPmono" size:24];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"caught");
    [model catchTemp];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [model undo];
        if (![updateUI isValid])
        {
            updateUI = [NSTimer scheduledTimerWithTimeInterval:(1/30) target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
        }
    }
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
    if ([model isStarted])
    {
        [model addSplit];
    }
    else
    {
        [model start];
    }
    
    // Only create a new NSTimer if one does not exist
    // OR the current updateUI is invalid
    if (![updateUI isValid])
    {
        updateUI = [NSTimer scheduledTimerWithTimeInterval:(1/30) target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }
}

- (IBAction)stopOnHold:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [model stop];
        [updateUI invalidate];
        [self updateLabel];
    }
}

@end
