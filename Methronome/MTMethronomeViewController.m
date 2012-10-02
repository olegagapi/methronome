//
//  MTMethronomeViewController.m
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//  Copyright (c) 2012 HipsterNinja. All rights reserved.
//

#import "MTMethronomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MTConstants.h"

@interface MTMethronomeViewController ()
@property (retain, nonatomic) NSTimer* metaTimer;
@property (retain, nonatomic) NSDate* startDate;

@property (retain, nonatomic) MTModel* model;

- (void)setupBeatLabel;

@end

@implementation MTMethronomeViewController
@synthesize stopButton = _stopButton;
@synthesize beatLabel = _beatLabel;
@synthesize stopWhenTimeIsUpSwitch = _stopWhenTimeIsUpSwitch;

@synthesize model = _model;

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

- (void) viewDidLoad
{
	self.stopWhenTimeIsUpSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey: kMTStopWhenTimesUpKey];
	[self onStopWhenTimeIsUpSwitch: self.stopWhenTimeIsUpSwitch];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self setupBeatLabel];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.model start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.model stop];
    [super viewWillDisappear:animated];
}

-(NSUInteger)fromBPM
{
    return [self.model fromBPM];
}

- (void)setFromBPM:(NSUInteger)fromBPM
{
    [self.model setFromBPM:fromBPM];
}

- (NSUInteger)toBPM
{
    return [self.model toBPM];
}

- (void)setToBPM:(NSUInteger)toBPM
{
    [self.model setToBPM:toBPM];
}

- (NSTimeInterval)timeInterval
{
    return [self.model timeInterval];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    [self.model setTimeInterval:timeInterval];
}

-(NSUInteger)strongMesure
{
    return [self.model strongMesure];
}

- (void)setStrongMesure:(NSUInteger)strongMesure
{
    [self.model setStrongMesure:strongMesure];
}

- (void)setupBeatLabel
{
    [self.beatLabel setText:[NSString stringWithFormat:@"%d", self.fromBPM]];    
}

- (IBAction)stopMethronome:(id)sender
{
    [self.model stop];
}

- (IBAction)onStopWhenTimeIsUpSwitch:(UISwitch*)sender
{
	self.model.stopWhenTimeIsUp = sender.isOn;
	[[NSUserDefaults standardUserDefaults] setBool: sender.isOn forKey: kMTStopWhenTimesUpKey];
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
}

#pragma mark MTModelDelegate

- (void)methronomeDidChangeBeatWithBPM:(NSUInteger)currentBPM
{
	[self animateBeatWithBPM:currentBPM];
}

- (void)methronome:(MTModel *)model didFinish:(BOOL)succesfully
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
