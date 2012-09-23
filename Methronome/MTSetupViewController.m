//
//  MTSetupViewController.m
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//
//

#import "MTSetupViewController.h"
#import "MTMethronomeViewController.h"
#import "MTTimeIntervalView.h"
#import "MTConstants.h"

#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>

@interface MTSetupViewController ()

@property (retain, nonatomic) NSDate* startDate;
- (void)updatePickerView:(UIPickerView *)pickerView animated:(BOOL)animated;
@end

@implementation MTSetupViewController
@synthesize startButton = _startButton;
@synthesize startDate = _startDate;
@synthesize picker = _picker;
@synthesize timeIntervalView = _timeIntervalView;

- (void)viewDidLoad
{
    NSUInteger fromBPM = [[NSUserDefaults standardUserDefaults] integerForKey:kMTFromBPMDefaultsKey];
	self.fromBPM = (0 == fromBPM) ? kMTDefaultFromBPM : fromBPM;
    NSUInteger toBPM = [[NSUserDefaults standardUserDefaults] integerForKey:kMTToBPMDefaultsKey];
	self.toBPM = (0 == toBPM) ? kMTDefaultToBPM : toBPM;
    [self updatePickerView:self.picker animated:YES];
    
    NSUInteger timeInterval = [[NSUserDefaults standardUserDefaults] integerForKey:kMTTimeIntervalDefaultsKey];
    self.timeIntervalView.currentValue = (0 == timeInterval) ? kMTDefaultTimeInterval : timeInterval;
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
        [methronomeViewController setTimeInterval:self.timeIntervalView.currentValue];
        [methronomeViewController setStrongMesure:self.strongMesure];
    }
}

- (IBAction)onExchangeButton:(id)sender
{
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	CGSize size = [pickerView rowSizeForComponent: component];
	UILabel* label = nil;
	if (nil != view && [view isKindOfClass:[UIView class]])
	{
		label = (UILabel*)view;
	}
	else
	{
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
		[label setTextAlignment:UITextAlignmentCenter];
		[label setFont: [UIFont boldSystemFontOfSize:18]];
	}
	[label setText: [NSString stringWithFormat: @"%d", row + kMTPickerViewMinimumValue]];
	return label;
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
