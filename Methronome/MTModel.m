//
//  MTModel.m
//  Methronome
//
//  Created by Elag on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTModel.h"
#import <AudioToolbox/AudioServices.h>

@interface MTModel ()

@property (assign, nonatomic) SystemSoundID beatSoundID;
@property (assign) BOOL shouldStop;
@end

@implementation MTModel

@synthesize fromBPM = _fromBPM;
@synthesize toBPM = _toBPM;
@synthesize timeInterval = _timeInterval;
@synthesize shouldStop = _shouldStop;
@synthesize delegate = _delegate;
@synthesize beatSoundID = _beatSoundID;

- (id)init
{
    self = [super init];
    if (self)
	{
		SystemSoundID outputID = 0;
		NSURL *url = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource: @"Metronome" ofType: @"aif"]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &outputID);
		self.beatSoundID = outputID;
    }
    return self;
}

- (void)methronomeDidFinish
{
	[self.delegate methronome:self didFinish: !self.shouldStop];
}

- (void)methronomeDidChangeBPM:(NSNumber *)currentBPM
{
	[self.delegate methronomeDidChangeBeatWithBPM:[currentBPM unsignedIntegerValue]];
}

- (void)backgroundMethronomeRunLoop
{
	NSTimeInterval roundTime = self.timeInterval / abs(self.toBPM - self.fromBPM);
	NSUInteger i = self.fromBPM;
	while (!self.shouldStop && (i != self.toBPM))
	{
		NSLog(@"current BPM: %u", i);
		NSDate* date = [NSDate date];
		NSTimeInterval beatTime = 60.0 / i;
		[self performSelectorOnMainThread:@selector(methronomeDidChangeBPM:) withObject: [NSNumber numberWithUnsignedInteger: i] waitUntilDone:NO];
		while (([date timeIntervalSinceNow] > -roundTime) && (!self.shouldStop))
		{
			AudioServicesPlaySystemSound(self.beatSoundID);
			NSLog(@"tuc!");
			[NSThread sleepForTimeInterval: beatTime];
		}
		i += (self.fromBPM < self.toBPM) ? 1 : -1;
	}
	[self performSelectorOnMainThread:@selector(methronomeDidFinish) withObject:nil waitUntilDone:NO];
}

- (void)start
{
    self.shouldStop = NO;
	[self performSelectorInBackground: @selector(backgroundMethronomeRunLoop) withObject: nil];
}

- (void)stop
{
    [self setShouldStop:YES];
}

@end
