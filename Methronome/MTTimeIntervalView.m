//
//  MTTimeIntervalView.m
//  Methronome
//
//  Created by Serge Rykovski on 8/24/12.
//
//

#import "MTTimeIntervalView.h"
#import "UIViewExtensions.h"
#import "MTConstants.h"

@interface MTTimeIntervalView()
@property (weak, nonatomic) IBOutlet UILabel *minValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)onSliderValueChanged:(id)sender;
@end

@implementation MTTimeIntervalView
@synthesize minValue = _minValue;
@synthesize maxValue = _maxValue;
@synthesize currentValue = _currentValue;

@synthesize minValueLabel = _minValueLabel;
@synthesize maxValueLabel = _maxValueLabel;
@synthesize currentValueLabel = _currentValueLabel;
@synthesize slider = _slider;

- (id)awakeAfterUsingCoder:(NSCoder*)aDecoder
{
    BOOL isJustAPlaceholder = ([[self subviews] count] == 0);
    if (isJustAPlaceholder)
    {
        MTTimeIntervalView* theRealThing = [[self class] loadFromNib];
        
        theRealThing.frame = self.frame;    // ... (pass through selected properties)
        
        // convince ARC that we're legit
        CFRelease((__bridge const void*)self);
        CFRetain((__bridge const void*)theRealThing);
        
        return theRealThing;
    }
    return self;
}

- (NSString *)timeStringWithSeconds:(NSUInteger)someSeconds
{
    NSString *timeText = [NSString string];
    NSUInteger minutes = someSeconds / 60;
    NSUInteger seconds = someSeconds % 60;
    if (0 != minutes)
    {
        timeText = [timeText stringByAppendingString:[NSString stringWithFormat:@"%dm ", minutes]];
    }
    if (0 != seconds)
    {
        timeText = [timeText stringByAppendingString:[NSString stringWithFormat:@"%ds", seconds]];
    }
    return timeText;
}

- (void)setMinValue:(NSUInteger)minValue
{
    _minValue = minValue;
    [self.slider setMinimumValue:minValue];
    self.minValueLabel.text = [self timeStringWithSeconds:minValue];
}

- (void)setMaxValue:(NSUInteger)maxValue
{
    _maxValue = maxValue;
    [self.slider setMaximumValue:maxValue];
    self.maxValueLabel.text = [self timeStringWithSeconds:maxValue];
}

- (void)setCurrentValue:(NSUInteger)currentValue
{
    if (self.minValue <= currentValue && self.maxValue >= currentValue)
    {
        _currentValue = currentValue;
        [self.slider setValue:currentValue];
        self.currentValueLabel.text = [self timeStringWithSeconds:currentValue];
    }
}

- (void)onSliderValueChanged:(id)sender
{
    NSInteger value = [[NSNumber numberWithFloat:[(UISlider *)sender value]] integerValue];
    [self setCurrentValue:value];
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:kMTTimeIntervalDefaultsKey];
}

@end
