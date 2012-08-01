//
//  MTViewController.h
//  Methronome
//
//  Created by Elag on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTModel.h"

@interface MTViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, MTModelDelegate>

@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *stopButton;

@property (retain, nonatomic) IBOutlet UISlider *timeSlider;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *beatLabel;
@property (retain, nonatomic) IBOutlet UIPickerView *picker;

- (IBAction)startMethronome:(id)sender;
- (IBAction)stopMethronome:(id)sender;

@end
