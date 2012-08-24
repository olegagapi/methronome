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

@property (weak) id<MTModelDelegate> delegate;

@property (nonatomic, assign) NSUInteger fromBPM;
@property (nonatomic, assign) NSUInteger toBPM;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (void)start;
- (void)stop;

@end
