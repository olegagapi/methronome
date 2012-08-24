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

static NSUInteger kMTDefaultFromBPM         = 60.0;
static NSUInteger kMTDefaultToBPM           = 120.0;
static NSUInteger kMTPickerViewMinimumValue = 30.0;

static NSString * const kMTStartMethronomeSegueKey = @"StartMethronomeSegue";
static NSString * const kMTFromBPMDefaultsKey = @"fromBPM";
static NSString * const kMTToBPMDefaultsKey = @"toBPM";

@interface MTSetupViewController ()

@property (retain, nonatomic) NSDate* startDate;
- (void)updatePickerView:(UIPickerView *)pickerView animated:(BOOL)animated;
@end

@implementation MTSetupViewController

@synthesize startButton = _startButton;
@synthesize timeSlider = _timeSlider;
@synthesize timeLabel = _timeLabel;
@synthesize startDate = _startDate;
@synthesize picker = _picker;

- (void)viewDidLoad
{
    NSUInteger fromBPM = [[NSUserDefaults standardUserDefaults] integerForKey:kMTFromBPMDefaultsKey];
	self.fromBPM = (0 == fromBPM) ? kMTDefaultFromBPM : fromBPM;
    NSUInteger toBPM = [[NSUserDefaults standardUserDefaults] integerForKey:kMTToBPMDefaultsKey];
	self.toBPM = (0 == toBPM) ? kMTDefaultToBPM : toBPM;
    [self updatePickerView:self.picker animated:YES];
	[self timeValueChanged: self];
    
    [super viewDidLoad];
}

- (void)setFromBPM:(NSUInteger)fromBPM
{
    if (fromBPM != super.fromBPM)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:fromBPM forKey:kMTFromBPMDefaultsKey];
        [super setFromBPM:fromBPM];
    }
}

- (void)setToBPM:(NSUInteger)toBPM
{
    if (toBPM != super.toBPM)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:toBPM forKey:kMTToBPMDefaultsKey];
        [super setToBPM:toBPM];
    }
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
    //XOR-swap ftw!
//	self.fromBPM ^= self.toBPM;
//	self.toBPM ^= self.fromBPM;
//	self.fromBPM ^= self.toBPM;
    
    NSUInteger newFromBPM = self.toBPM;
    [self setToBPM:self.fromBPM];
    [self setFromBPM:newFromBPM];
    
    [self updatePickerView:self.picker animated:YES];
}

- (void)updatePickerView:(UIPickerView *)pickerView animated:(BOOL)animated
{
	[pickerView selectRow: self.fromBPM - kMTPickerViewMinimumValue inComponent: 0 animated: animated];
	[pickerView selectRow: self.toBPM - kMTPickerViewMinimumValue inComponent: 1 animated: animated];
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 300 - kMTPickerViewMinimumValue;
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[NSNumber numberWithInteger: (row + kMTPickerViewMinimumValue)] description];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == 0)
	{
		self.fromBPM = row + kMTPickerViewMinimumValue;
		NSLog(@"from: %u", self.fromBPM);
	}
	else if (component == 1)
	{
		self.toBPM = row + kMTPickerViewMinimumValue;
		NSLog(@"to: %u", self.toBPM);
	}
}

@end
