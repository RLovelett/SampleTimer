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
@synthesize splitstable;

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
    
    [[self splitstable] setDelegate : self];
    [[self splitstable] setDataSource : self];
    
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
    
    // Only create a new NSTimer if one does not exist
    // OR the current updateUI is invalid
        if (![updateUI isValid])
        {
            //Funky stuff happening with interval value????
            updateUI = [NSTimer scheduledTimerWithTimeInterval:(.005) target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
        }
    // Update splitstable
        [[self splitstable] reloadData];
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

#pragma tableview datasource and delegate methods

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return (int)1;
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return [model splitIntervalsCount];
}

- (UITableViewCell*) tableView: (UITableView*)  tableView cellForRowAtIndexPath : (NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier : CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    UIColor * cellTextColor = [UIColor colorWithRed:61/255.0f green:103/255.0f blue:255/255.0f alpha:1.0f];
    cell.textLabel.textColor = cellTextColor;
    
    cell.textLabel.text = [[model getSplitIntervals] objectAtIndex : indexPath.row];
    
    return cell;
}

@end
