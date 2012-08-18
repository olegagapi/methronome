//
//  MTMethronomeViewController.m
//  Methronome
//
//  Created by Serge Rykovski on 8/18/12.
//
//

#import "MTMethronomeViewController.h"

@interface MTMethronomeViewController ()

@end

@implementation MTMethronomeViewController
@synthesize stopButton = _stopButton;
@synthesize beatLabel = _beatLabel;

- (IBAction)stopMethronome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
