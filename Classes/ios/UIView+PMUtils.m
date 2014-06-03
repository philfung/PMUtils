//
//  UIView+PMUtils.m
//  
//
//  Created by Peter Meyers on 3/1/14.
//
//

#import "UIView+PMUtils.h"
#import "UIImage+PMUtils.h"

@implementation UIView (PMUtils)

+ (NSString *) defaultNibName
{
	return NSStringFromClass([self class]);
}

+ (UINib *) defaultNib
{
    //cache nib to prevent unnecessary filesystem access
    static NSCache *nibCache = nil;
    static dispatch_once_t cacheToken;
    dispatch_once(&cacheToken, ^{
        nibCache = [NSCache new];
    });
    
    NSString *name = [self defaultNibName];
    UINib *nib = [nibCache objectForKey:name];
    
    if (!nib && [[NSBundle mainBundle] pathForResource:name ofType:@"nib"]) {
        nib = [UINib nibWithNibName:name bundle:nil];
        [nibCache setObject:nib?: [NSNull null]  forKey:name];
    }
    else if ([nib isEqual:[NSNull null]]) {
        nib = nil;
    }
    
	return nib;
}

+ (instancetype) instanceFromDefaultNibWithOwner:(id)ownerOrNil
{
    UINib *nib = [self defaultNib];
    if (nib) {
        NSArray *contents = [nib instantiateWithOwner:ownerOrNil options:nil];
        UIView *view = [contents count]? contents[0]: nil;
        NSAssert ([view isKindOfClass:self], @"First object in nib '%@' was '%@'. Expected '%@'", [self defaultNibName], view, self);
        return view;
    }
    return nil;
}

- (void) removeSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (UIImage *)blurredViewWithRadius:(CGFloat)radius
						 iterations:(NSUInteger)iterations
					scaleDownFactor:(NSUInteger)scaleDownFactor
						 saturation:(CGFloat)saturation
						  tintColor:(UIColor *)tintColor
							   crop:(CGRect)crop
{
	UIGraphicsBeginImageContextWithOptions(crop.size, YES, 1.0f);

	[self drawViewHierarchyInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) afterScreenUpdates:NO];
	
	UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return 	[snapshot blurredImageWithRadius:radius
								  iterations:iterations
							 scaleDownFactor:scaleDownFactor
								  saturation:saturation
								   tintColor:tintColor
										crop:crop];
}

#pragma mark - Layout


- (void) centerInRect:(CGRect)rect forDirection:(PMDirection)direction;
{
    CGRect frame = self.frame;
    
    if (direction & PMDirectionHorizontal) {
        frame.origin.x = floorf((rect.size.width - frame.size.width) / 2.0f + rect.origin.x);
    }
    
    if (direction & PMDirectionVertical) {
        frame.origin.y = floorf((rect.size.height - frame.size.height) / 2.0f + rect.origin.y);
    }
    
    self.frame = frame;
}

- (void) setFX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void) setFY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void) setFOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void) setFWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void) setFHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void) setFSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void) setBWidth:(CGFloat)width
{
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (void) setBHeight:(CGFloat)height
{
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

- (void) setBSize:(CGSize)size
{
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

@end
