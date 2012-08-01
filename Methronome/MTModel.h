//
//  MTModel.h
//  Methronome
//
//  Created by Elag on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MTModel;

@protocol MTModelDelegate
- (void)methronome:(MTModel*)model didFinish:(BOOL)succesfully;
- (void)methronomeDidChangeBeatWithBPM:(NSUInteger)currentBPM;
@end

@interface MTModel : NSObject

@property (assign) id<MTModelDelegate> delegate;

@property (assign) NSUInteger fromBPM;
@property (assign) NSUInteger toBPM;
@property (assign) NSTimeInterval timeInterval;

@property (assign) BOOL shouldStop;
- (void)startFromBPM:(NSUInteger)aFromBPM toBPM:(NSUInteger)aToBPM forTime:(NSTimeInterval)aTimeInterval;

@end
