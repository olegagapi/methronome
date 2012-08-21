//
//  MTSetupViewController.m
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//
//

#import "MTSetupViewController.h"
#import "MTMethronomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>

static NSString * const kMTStartMethronomeSegueKey = @"StartMethronomeSegue";

@interface MTSetupViewController ()

@property (retain, nonatomic) NSDate* startDate;

@end

@implementation MTSetupViewController

@synthesize startButton = _startButton;
@synthesize timeSlider = _timeSlider;
@synthesize timeLabel = _timeLabel;
@synthesize startDate = _startDate;
@synthesize picker = _picker;

- (void)viewDidLoad
{
	self.fromBPM = 60;
	self.toBPM = 120;
	[self.picker selectRow:self.fromBPM - 30 inComponent:0 animated:NO];
	[self.picker selectRow:self.toBPM - 30 inComponent:1 animated:NO];
	[self timeValueChanged: self];
    
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kMTStartMethronomeSegueKey])
    {
        MTMethronomeViewController *methronomeViewController = segue.destinationViewController;
        [methronomeViewController setFromBPM:self.fromBPM];
        [methronomeViewController setToBPM:self.toBPM];
        [methronomeViewController setTimeInterval:self.timeInterval];
    }
}

- (IBAction)timeValueChanged:(id)sender
{
	self.timeInterval = self.timeSlider.value * 60.0;
	NSUInteger min = floor(self.timeInterval / 60.0);
	NSUInteger sec = floor(self.timeInterval - min * 60);
	self.timeLabel.text = [NSString stringWithFormat: @"%umin %usec", min, sec];
}

- (IBAction)onExchangeButton:(id)sender
{
	[self.picker selectRow: self.toBPM - 30 inComponent: 0 animated: YES];
	[self.picker selectRow: self.fromBPM - 30 inComponent: 1 animated: YES];
		//XOR-swap ftw!
	self.fromBPM^=self.toBPM;
	self.toBPM^=self.fromBPM;
	self.fromBPM^=self.toBPM;
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 300 - 30;
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[NSNumber numberWithInteger: (row + 30)] description];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == 0)
	{
		self.fromBPM = row + 30;
		NSLog(@"from: %u", self.fromBPM);
	}
	else if (component == 1)
	{
		self.toBPM = row + 30;
		NSLog(@"to: %u", self.toBPM);
	}
}

@end
