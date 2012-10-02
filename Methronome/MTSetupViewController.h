//
//  MTSetupViewController.h
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//
//

#import "MTViewController.h"
@class MTTimeIntervalView;

@interface MTSetupViewController : MTViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet MTTimeIntervalView *timeIntervalView;

@end
