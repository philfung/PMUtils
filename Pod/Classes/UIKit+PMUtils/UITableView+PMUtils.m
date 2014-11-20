// Copyright (c) 2013-2014 Peter Meyers
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//  UITableView+PMUtils.m
//  Created by Peter Meyers on 3/2/14.
//

#import "UITableView+PMUtils.h"

@implementation UITableView (PMUtils)


- (void) reloadVisibleRowsWithRowAnimation:(UITableViewRowAnimation)animation
{
	NSArray *visibleRows = [self indexPathsForVisibleRows];
	[self reloadRowsAtIndexPaths:visibleRows withRowAnimation:animation];
}

- (id) sizingCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    NSMutableDictionary *sharedDictionary = [[self class] PM_sharedSizingCellsByReuseIdentifier];
    UITableViewCell *cell = sharedDictionary[reuseIdentifier];
    if (!cell) {
        cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
        sharedDictionary[reuseIdentifier] = cell;
    }
    return cell;
}

- (void) scrollToTopAnimated:(BOOL)animated
{
    if (self.contentSize.height && self.contentSize.width) {
        CGRect top = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        [self scrollRectToVisible:top animated:animated];
    }
}

- (void) scrollToBottomAnimated:(BOOL)animated
{
    if (self.contentSize.height && self.contentSize.width) {
        CGRect bottom = CGRectMake(self.contentSize.width - 1.0f, self.contentSize.height - 1.0f, 1.0f, 1.0f);
        [self scrollRectToVisible:bottom animated:animated];
    }
}

#pragma mark - Internal Methods


+ (NSMutableDictionary *) PM_sharedSizingCellsByReuseIdentifier
{
    static dispatch_once_t cacheToken;
    static NSMutableDictionary *sharedSizingCellsByReuseIdentifier = nil;
    dispatch_once(&cacheToken, ^{
        sharedSizingCellsByReuseIdentifier = [@{} mutableCopy];
    });
    return sharedSizingCellsByReuseIdentifier;
}


@end