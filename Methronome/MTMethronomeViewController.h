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

- (IBAction)stopMethronome:(id)sender;

@end
