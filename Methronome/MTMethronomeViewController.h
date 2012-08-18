//
//  MTMethronomeViewController.h
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//
//

@interface MTMethronomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *beatLabel;

- (IBAction)stopMethronome:(id)sender;

@end
