//
//  EPLAKViewToolbarItem.m
//  EPLAppKit
//
//  Based on:
//
//  KBViewToolbarItem.m
//  -------------------
//
//  Created by Keith Blount on 14/05/2006.
//  Copyright 2006 Keith Blount. All rights reserved.
//

#import "EPLAKViewToolbarItem.h"


@implementation EPLAKViewToolbarItem

- (void)setAction:(SEL)aSelector
{
	id control = [self view];
	if (control != nil) {
		if ([control respondsToSelector:@selector(setAction:)])
			[control setAction:aSelector];
	} 
    else {
		[super setAction:aSelector];        
    }
}

- (SEL)action
{
	id control = [self view];
	if (control != nil) {
		if ([control respondsToSelector:@selector(action)]) {
			return [control action];            
        }
	}
	
	return [super action];
}

- (void)setTarget:(id)anObject
{
	id control = [self view];
	if (control != nil) {
		if ([control respondsToSelector:@selector(setTarget:)]) {
			[control setTarget:anObject];
        }
	} 
    else {
		[super setTarget:anObject];        
    }
}

- (id)target
{
	id control = [self view];
	if (control != nil) {
		if ([control respondsToSelector:@selector(target)]) {
			return [control target];
        }
	}
	
	return [super target];
}

- (void)setToolTip:(NSString *)theToolTip
{
	if ([self view] != nil) {
		[[self view] setToolTip:theToolTip];
    } 
    else {
		[super setToolTip:theToolTip];
    }
}

- (NSString *)toolTip
{
	if ([self view] != nil) {
		return [[self view] toolTip];
    }
	return [super toolTip];
}

- (void)validate
{
	if ([[self toolbar] delegate]) {
		BOOL enabled = YES;
		
		if ([[[self toolbar] delegate] respondsToSelector:@selector(validateToolbarItem:)]) {
            NSObject *delegateImpl = [[self toolbar] delegate];
			enabled = [delegateImpl validateToolbarItem:self];
        } 		
		else if ([[[self toolbar] delegate] conformsToProtocol:@protocol(NSUserInterfaceValidations)]) {
            id<NSUserInterfaceValidations> delegateImpl = (id<NSUserInterfaceValidations>)[[self toolbar] delegate];
			enabled = [delegateImpl validateUserInterfaceItem:self];
        }
		
		[self setEnabled:enabled];
	}
	else if ([self action]) {
		if (![self target]) {
			[self setEnabled:[[[[self view] window] firstResponder] respondsToSelector:[self action]]];
        } else {
			[self setEnabled:[[self target] respondsToSelector:[self action]]];
        }
	}
	else {
		[super validate];
    }
}

@end
