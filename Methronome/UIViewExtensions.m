//
//  UIViewExtensions.m
//  Methronome
//
//  Created by Serge Rykovski on 8/24/12.
//
//

#import "UIViewExtensions.h"

@implementation UIView (NibLoading)

+ (id)loadFromNib
{
	NSString *nibName = NSStringFromClass([self class]);
	NSArray* elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	for (NSObject *anObject in elements)
    {
		if ([anObject isKindOfClass:[self class]])
        {
			return anObject;
		}
	}
	return nil;
}

@end
