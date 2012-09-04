//
//  MTTimeIntervalView.h
//  Methronome
//
//  Created by Serge Rykovski on 8/24/12.
//
//

#import <UIKit/UIKit.h>

// All values are given in seconds
@interface MTTimeIntervalView : UIView

@property (assign, nonatomic) NSUInteger minValue;
@property (assign, nonatomic) NSUInteger maxValue;
@property (assign, nonatomic) NSUInteger currentValue;

@end
