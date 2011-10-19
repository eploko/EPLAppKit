//
//  EPLAKView.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EPLAKView.h"

@implementation EPLAKView

@synthesize viewController = _viewController;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)setViewController:(NSViewController *)newController
{
    if (_viewController) {
        NSResponder *controllerNextResponder = [_viewController nextResponder];
        [super setNextResponder:controllerNextResponder];
        [_viewController setNextResponder:nil];
    }
    
    _viewController = newController;
    
    if (newController) {
        NSResponder *ownNextResponder = [self nextResponder];
        [super setNextResponder:_viewController];
        [_viewController setNextResponder:ownNextResponder];
    }
}

- (void)setNextResponder:(NSResponder *)newNextResponder
{
    if (_viewController) {
        [_viewController setNextResponder:newNextResponder];
        return;
    }
    
    [super setNextResponder:newNextResponder];
}

@end
