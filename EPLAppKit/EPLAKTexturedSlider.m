//
//  EPLAKTexturedSlider.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/29/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "EPLAKTexturedSliderCell.h"

#import "EPLAKTexturedSlider.h"


@interface EPLAKTexturedSlider ()

@property (nonatomic, assign) NSUInteger indeterminateAnimationStep;
@property (nonatomic, retain) NSTimer *animationTimer;

- (void)startAnimation;
- (void)stopAnimation;
- (void)animate:(NSTimer *)timer;

@end


@implementation EPLAKTexturedSlider

@synthesize waiting = waiting_;
@synthesize indeterminateAnimationStep = indeterminateAnimationStep_;
@synthesize animationTimer = animationTimer_;

- (void)dealloc
{
    [self stopAnimation];
    [super dealloc];
}

- (void)setNeedsDisplayInRect:(NSRect)invalidRect
{
    [super setNeedsDisplayInRect:[self bounds]];
}

- (void)setWaiting:(BOOL)value
{
    if (value == waiting_) {
        return;
    }
    
    BOOL oldValue = waiting_;
    waiting_ = value;
    
    [self.cell setWaiting:value];

    if (oldValue == NO && value == YES) {
        [self startAnimation];
    } else {
        [self stopAnimation];
    }    
    [self setNeedsDisplay:YES];
}

- (void)startAnimation
{
    NSTimer *animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animate:) userInfo:NULL repeats:YES];
    self.animationTimer = animationTimer;
}

- (void)stopAnimation
{
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}

- (void)animate:(NSTimer *)timer
{
    self.indeterminateAnimationStep = ++self.indeterminateAnimationStep % 6;
    [self.cell setStep:self.indeterminateAnimationStep];
    [self setNeedsDisplay:YES];
}

@end
