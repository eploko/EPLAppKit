//
//  EPLAKTexturedSlider.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/29/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "EPLAKTexturedSlider.h"

@implementation EPLAKTexturedSlider

- (void)drawRect:(NSRect)aRect
{
	[[self cell] drawWithFrame:self.bounds inView:self];
}

@end
