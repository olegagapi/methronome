//
//  MTMethronomeViewController.h
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//  Copyright (c) 2012 HipsterNinja. All rights reserved.
//

#import "MTModel.h"
#import "MTViewController.h"

@interface MTMethronomeViewController : MTViewController <MTModelDelegate>

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *beatLabel;
@property (weak, nonatomic) IBOutlet UISwitch *stopWhenTimeIsUpSwitch;

- (IBAction)stopMethronome:(id)sender;

- (IBAction)onStopWhenTimeIsUpSwitch:(id)sender;

@end
