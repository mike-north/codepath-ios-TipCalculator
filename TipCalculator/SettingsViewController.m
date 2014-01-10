//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Mike North on 1/9/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
- (IBAction)defaultTipChanged:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // get user preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Get the default tip (by segment index). I checked to make sure
    // that if the user hasn't set a default, we get 0 (a reasonable value)
    int defaultTipIdx = [defaults integerForKey:@"default_tip"];

    // Apply the value we got from preferences to the segmented control
    self.defaultTipControl.selectedSegmentIndex = defaultTipIdx;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// User has changed their default tip
- (IBAction)defaultTipChanged:(id)sender {
    // get user preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    // Get value from segmented control
    int tipValue = self.defaultTipControl.selectedSegmentIndex;
    
    // persist the value
    [defaults setInteger:tipValue forKey:@"default_tip"];
    [defaults synchronize]; // FLUSH!
}
@end
