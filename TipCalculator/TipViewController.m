//
//  TipViewController.m
//  TipCalculator
//
//  Created by Mike North on 1/9/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

// View post-initialization stuff
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    
    // get user preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // Get the default tip (by segment index). I checked to make sure
    // that if the user hasn't set a default, we get 0 (a reasonable value)
    int defaultTipIdx = [defaults integerForKey:@"default_tip"];
    
    // Apply the value we got from preferences to the segmented control
    self.tipControl.selectedSegmentIndex = defaultTipIdx;

    // Do any additional setup after loading the view from its nib.
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Called whenever the user taps anywhere on the screen (except for the bill text field)
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    
    // bill amount as a float
    float billAmount = [self.billTextField.text floatValue];
    
    // array of tip percentages
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    // tip amount (in dollars)
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    // total bill amount
    float totalAmount = tipAmount + billAmount;
    
    // all currencies are formatted similarly. Let's re-use our format string!!
    NSString *currencyFormatString = @"$%0.2f";
    
    // Update tip label
    self.tipLabel.text = [NSString stringWithFormat:currencyFormatString, tipAmount];
    
    // Update total label
    self.totalLabel.text = [NSString stringWithFormat:currencyFormatString, totalAmount];
    
}
@end
