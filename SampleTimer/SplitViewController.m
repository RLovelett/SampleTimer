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
@synthesize splitsTable;

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
    
    [[self splitsTable] setDataSource: model];
    
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
        [self validateNSTimer];
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

- (IBAction)startOnTap : (UITapGestureRecognizer *)sender
{
    //Fixes taps after a stop
    if (![model isStopped])
    {
        if ([model isStarted])
        {
            [model addSplit];
        }
        else
        {
            [model start];
        }
    
        [self validateNSTimer];

        // Update splitstable
        [[self splitsTable] reloadData];
    }
}

- (IBAction)stopOnHold : (UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if (![model isStopped])
        {
            [model stop];
            [updateUI invalidate];
            [self updateLabel];
        }
    }
}

- (void) validateNSTimer
{
    if (![updateUI isValid])
    {
        updateUI = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }
}

#pragma tableview datasource and delegate methods

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return (int)1;
}

@end
