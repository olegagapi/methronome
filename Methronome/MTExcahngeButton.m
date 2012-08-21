//
//  MTExcahngeButton.m
//  Methronome
//
//  Created by Agapov Oleg on 8/22/12.
//
//

#import "MTExcahngeButton.h"

@implementation MTExcahngeButton

- (void)drawRect:(CGRect)aRect
{
	CGRect rect = CGRectZero;
	rect.size = self.frame.size;

	UIColor *colorBlue = [UIColor blueColor];
	[colorBlue setFill];
	UIColor *colorBlack = [UIColor darkGrayColor];
	[colorBlack setStroke];
    
	CGPoint startPoint = rect.origin;
	CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));

    UIBezierPath *arrowBodyPath = [UIBezierPath bezierPath];
    [arrowBodyPath moveToPoint: startPoint];
	[arrowBodyPath addQuadCurveToPoint: endPoint controlPoint: CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) * 1.2)];
	[arrowBodyPath addQuadCurveToPoint: startPoint controlPoint: CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) * 2)];
	[arrowBodyPath stroke];
	[arrowBodyPath fill];
		//TODO - finish arrow
}

@end
