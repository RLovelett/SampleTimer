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

- (id) initWithCoder:(NSCoder*) decoder
{
    if (self = [super initWithCoder:decoder])
    {
        undoAlert = [[UIAlertView alloc] initWithTitle:@"SHAKEN" message:@"UNDO?" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK", nil];

        lightGreen = [UIColor colorWithRed:183 / 255.0f green:242 / 255.0f blue:152 / 255.0f alpha:1.0f];
        darkGreen = [UIColor colorWithRed:43 / 255.0f green:127 / 255.0f blue:62 / 255.0f alpha:1.0f];
        lightRed = [UIColor colorWithRed:237 / 255.0f green:102 / 255.0f blue:75 / 255.0f alpha:1.0f];
        darkRed = [UIColor colorWithRed:204 / 255.0f green:64 / 255.0f blue:36 / 255.0f alpha:1.0f];

        splitsTable.rowHeight = 28.0;
    }

    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.

    [[self splitsTable] setDataSource:model];

    // Make sure the UI reflects the current model state
    [self syncDisplay];
}

- (void) syncDisplay
{
    if([model isStarted])
    {
        // Make sure the colors are right
        display.textColor = lightGreen;
        millidisplay.textColor = darkGreen;

        splitsTable.userInteractionEnabled = NO;
        splitsTable.scrollEnabled = NO;

        [self validateNSTimer];
    }

    if([model isStopped])
    {
        [updateUI invalidate];
        [self updateLabel];

        display.textColor = lightRed;
        millidisplay.textColor = darkRed;

        splitsTable.userInteractionEnabled = YES;
        splitsTable.scrollEnabled = YES;
    }

    // Refresh the table
    [splitsTable reloadData];
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
        [self syncDisplay];
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
    display.text = [model getElapsedTime];
    if ([model displaysHour])
    {
        millidisplay.text = @"";
    }
    else
    {
        millidisplay.text = [model getMilliElapsedTime];
    }
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

        [self syncDisplay];
    }
}

- (IBAction) stopOnHold :(UILongPressGestureRecognizer*) sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if (![model isStopped])
        {
            [model stop];
            [self syncDisplay];
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

- (void) setTimeSheet:(TimeSheet*) newTimeSheet
{
    model = newTimeSheet;
}

@end
