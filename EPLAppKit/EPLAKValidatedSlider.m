//
//  EPLAKValidatedSlider.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/28/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "EPLAKValidatedSlider.h"

@implementation EPLAKValidatedSlider

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[super dealloc];
}

- (void)viewDidMoveToWindow
{
	[super viewDidMoveToWindow];
	
	NSWindow *window = [self window];
	
	if (window != nil) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(windowDidUpdate:)
													 name:NSWindowDidUpdateNotification
												   object:window];
	}
}

- (void)windowDidUpdate:(NSNotification*)notification
{
    id validator = [NSApp targetForAction:[self action] to:[self target] from:self];
	
    if ((validator == nil) || ![validator respondsToSelector:[self action]]) {
		[self setEnabled:NO];
    }
    else if ([validator respondsToSelector:@selector(validateUserInterfaceItem:)]) {
        [self setEnabled:[validator validateUserInterfaceItem:self]];
    }
    else {
		[self setEnabled:YES];
    }
}

@end
