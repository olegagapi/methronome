//
//  MTViewController.m
//  Methronome
//
//  Created by Elag on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>

@interface MTViewController ()

@property (assign, nonatomic) NSUInteger fromBPM;
@property (assign, nonatomic) NSUInteger toBPM;
@property (assign, nonatomic) NSTimeInterval timeInterval;
@property (retain, nonatomic) NSTimer* metaTimer;
@property (retain, nonatomic) NSDate* startDate;

@property (retain, nonatomic) MTModel* model;

@end

@implementation MTViewController

@synthesize fromBPM;
@synthesize toBPM;
@synthesize metaTimer;
@synthesize timeInterval;
@synthesize startButton;
@synthesize stopButton;
@synthesize timeSlider;
@synthesize timeLabel;
@synthesize startDate;
@synthesize beatLabel;
@synthesize model;
@synthesize picker;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
	{
        self.model = [[MTModel alloc] init];
		self.model.delegate = self;
    }
    return self;
}

- (void) dealloc
{
    self.model.delegate = nil;
}

- (void)viewDidLoad
{
	self.fromBPM = 60;
	self.toBPM = 120;
	[self.picker selectRow:self.fromBPM - 30 inComponent:0 animated:NO];
	[self.picker selectRow:self.toBPM - 30 inComponent:1 animated:NO];
	[self timeValueChanged: self];

    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

- (void)animateBeatWithBPM:(NSUInteger)currentBPM
{
	self.beatLabel.text = [NSString stringWithFormat:@"%u", currentBPM];
	[self.beatLabel.layer removeAllAnimations];
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.fromValue = [NSNumber numberWithFloat:1.0];
	animation.toValue = [NSNumber numberWithFloat:0.3];
	animation.duration = 60.0 / currentBPM;
	animation.repeatCount = HUGE_VALF;
	[self.beatLabel.layer addAnimation:animation forKey:@"opacity"];
//	NSTimeInterval duration = [self.rockTimer timeInterval];
//	UIViewAnimationOptions opt = UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseIn;
//	[UIView animateWithDuration:duration delay:0.0 options:opt animations: ^(void){self.beatLabel.alpha = 0.3;} completion: ^(BOOL f){}];
}

- (void)timerUpdate:(NSTimer *)timer
{
	self.timeSlider.value = (self.timeInterval + [self.startDate timeIntervalSinceNow]) / 60.0;
	NSUInteger min = floor(self.timeSlider.value);
	NSUInteger sec = (self.timeSlider.value - min) * 60.0;
	self.timeLabel.text = [NSString stringWithFormat: @"%umin %usec", min, sec];
}

- (IBAction)startMethronome:(id)sender
{
	self.startButton.hidden = YES;
	self.stopButton.hidden = NO;
	self.beatLabel.hidden = NO;
	self.timeSlider.enabled = NO;
	self.picker.userInteractionEnabled = NO;

	[self.model startFromBPM:self.fromBPM toBPM:self.toBPM forTime:self.timeInterval];
	
	self.startDate = [NSDate date];
	self.metaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerUpdate:) userInfo:nil repeats:YES];
}

- (IBAction)stopMethronome:(id)sender
{
	[self.model setShouldStop: YES];
}

- (IBAction)timeValueChanged:(id)sender
{
	self.timeInterval = self.timeSlider.value * 60.0;
	NSUInteger min = floor(self.timeInterval / 60.0);
	NSUInteger sec = floor(self.timeInterval - min * 60);
	self.timeLabel.text = [NSString stringWithFormat: @"%umin %usec", min, sec];
}

#pragma mark MTModelDelegate

- (void)methronomeDidChangeBeatWithBPM:(NSUInteger)currentBPM
{
	[self animateBeatWithBPM:currentBPM];
}

- (void)methronome:(MTModel *)model didFinish:(BOOL)succesfully
{
	[self.metaTimer invalidate];
	self.metaTimer = nil;
	self.stopButton.hidden = YES;
	self.startButton.hidden = NO;
	self.beatLabel.hidden = YES;
	self.timeSlider.enabled = YES;
	self.picker.userInteractionEnabled = YES;

	self.timeSlider.value = self.timeInterval / 60.0;
	[self timeValueChanged: self];
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
