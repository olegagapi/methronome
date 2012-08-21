//
//  MTMethronomeViewController.m
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//  Copyright (c) 2012 HipsterNinja. All rights reserved.
//

#import "MTMethronomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MTMethronomeViewController ()
@property (retain, nonatomic) NSTimer* metaTimer;
@property (retain, nonatomic) NSDate* startDate;

@property (retain, nonatomic) MTModel* model;

- (void)setupBeatLabel;

@end

@implementation MTMethronomeViewController
@synthesize stopButton = _stopButton;
@synthesize beatLabel = _beatLabel;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupBeatLabel];
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

- (void)setFromBPM:(NSUInteger)fromBPM
{
    [self.model setFromBPM:fromBPM];
}

- (void)setToBPM:(NSUInteger)toBPM
{
    [self.model setToBPM:toBPM];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    [self.model setTimeInterval:timeInterval];
}

- (void)setupBeatLabel
{
    [self.beatLabel setText:[NSString stringWithFormat:@"%d", self.fromBPM]];    
}

- (IBAction)stopMethronome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
}

@end
