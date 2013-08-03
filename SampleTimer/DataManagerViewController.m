//
//  DataManagerViewController.m
//  SampleTimer
//
//  Created by Ryan Lovelett on 7/31/13.
//  Copyright (c) 2013 Ryan Lovelett. All rights reserved.
//

#import "DataManagerViewController.h"
#import "SplitViewController.h"

@interface DataManagerViewController ()

@end

@implementation DataManagerViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        appDelegate = (SplitAppDelegate*)[[UIApplication sharedApplication] delegate];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    timeSheets = appDelegate.timeSheets;
    activeTimeSheet = appDelegate.activeTimeSheet;

    if (activeTimeSheet == nil)
    {
        appDelegate.activeTimeSheet = activeTimeSheet = [timeSheets createTimeSheet];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"DataManagerViewControllerToSplitViewControllerSegue"])
    {
        // Get reference to the destination view controller
        SplitViewController* vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setTimeSheet: activeTimeSheet];
    }
}

@end
