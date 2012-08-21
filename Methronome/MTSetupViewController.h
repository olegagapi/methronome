//
//  MTSetupViewController.h
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//
//

#import "MTViewController.h"

@interface MTSetupViewController : MTViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (retain, nonatomic) IBOutlet UIButton *startButton;

@property (retain, nonatomic) IBOutlet UISlider *timeSlider;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIPickerView *picker;

@end
