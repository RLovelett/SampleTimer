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

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Register motion ended
    [self canBecomeFirstResponder];

    // Do any additional setup after loading the view, typically from a nib.
    model = [[TimeSheet alloc] init];

    //labelFont = [UIFont fontWithName:@"BPmono" size:50];
    //display.font = labelFont;
    //millidisplay.font = [UIFont fontWithName:@"BPmono" size:24];

    [[self splitsTable] setDataSource:model];
    splitsTable.rowHeight = 28.0;

    undoAlert = [[UIAlertView alloc] initWithTitle:@"SHAKEN" message:@"UNDO?" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK", nil];
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void) touchesBegan:(NSSet*) touches withEvent:(UIEvent*) event
{
    NSLog(@"caught");
    [model catchTemp];
}

- (void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger) buttonIndex
{
    NSString* title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"OK"])
    {
        NSLog(@"OK was selected.");
        [model undo];
        [self validateNSTimer];
        [splitsTable reloadData];
        splitsTable.userInteractionEnabled = NO;
        splitsTable.scrollEnabled = NO;
    }
    else if ([title isEqualToString:@"CANCEL"])
    {
        NSLog(@"CANCEL was selected.");
    }
}

- (void) motionEnded:(UIEventSubtype) motion withEvent:(UIEvent*) event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [undoAlert show];
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

- (IBAction) startOnTap :(UITapGestureRecognizer*) sender
{
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

        [[self splitsTable] reloadData];
    }
}

- (IBAction) stopOnHold :(UILongPressGestureRecognizer*) sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if (![model isStopped])
        {
            [model stop];
            [updateUI invalidate];
            [self updateLabel];

            display.textColor = [UIColor colorWithRed:237 / 255.0f green:102 / 255.0f blue:75 / 255.0f alpha:1.0f];
            millidisplay.textColor = [UIColor colorWithRed:204 / 255.0f green:64 / 255.0f blue:36 / 255.0f alpha:1.0f];

            splitsTable.userInteractionEnabled = YES;
            splitsTable.scrollEnabled = YES;
        }
    }
}

- (IBAction) gotoDataManager:(UISwipeGestureRecognizer*) sender
{
    NSLog(@"Swiped!");
}

- (void) validateNSTimer
{
    if (![updateUI isValid])
    {
        updateUI = [NSTimer scheduledTimerWithTimeInterval:0.04167 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }
}

@end
