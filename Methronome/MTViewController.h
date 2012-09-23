//
//  MTViewController.h
//  Methronome
//
//  Created by Elag on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@protocol MTViewController <NSObject>
@property (nonatomic, assign) NSUInteger strongMesure;
@property (assign, nonatomic) NSUInteger fromBPM;
@property (assign, nonatomic) NSUInteger toBPM;
@property (assign, nonatomic) NSTimeInterval timeInterval;
@end

@interface MTViewController : UIViewController <MTViewController>

@end
