//
//  EPLAKTexturedSliderCell.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/29/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "NSBezierPath+MCAdditions.h"

#import "EPLAKTexturedSliderCell.h"


@interface EPLAKTexturedSliderCell ()

- (void)drawWaitingStepInRect:(NSRect)rect;

@end

@implementation EPLAKTexturedSliderCell

static NSImage *sliderKnobImage;
static NSImage *sliderBackLeftImage, *sliderBackCenterImage, *sliderBackRightImage;
static NSImage *sliderFillLeftImage, *sliderFillCenterImage, *sliderFillRightImage;
static NSImage *sliderWaitingColorImage;

@synthesize waiting = waiting_;
@synthesize step = step_;

+ (void)initialize 
{
	if([EPLAKTexturedSliderCell class] == [self class])
	{
		NSBundle *bundle = [NSBundle bundleForClass:[EPLAKTexturedSliderCell class]];
        
		sliderKnobImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_knob_s1.png"]];
        [sliderKnobImage setFlipped:YES];
		sliderBackLeftImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_back_left_s1.png"]];
		sliderBackCenterImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_back_center_s1.png"]];
		sliderBackRightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_back_right_s1.png"]];
		sliderFillLeftImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_fill_left_s1.png"]];
		sliderFillCenterImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_fill_center_s1.png"]];
		sliderFillRightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_fill_right_s1.png"]];
		sliderWaitingColorImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"slider_waiting_color_s1.png"]];
	}
}

- (NSControlSize)controlSize
{
	return NSRegularControlSize;
}

- (void)setControlSize:(NSControlSize)size
{
	
}

- (NSInteger)numberOfTickMarks
{
	return 0;
}

- (void)setNumberOfTickMarks:(NSInteger)numberOfTickMarks
{
	
}

- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped
{
    CGFloat alpha = [self isEnabled] ? 1.0 : 0.5;

    // Track ========================
    
    NSRect slideRect = NSInsetRect(rect, 0, roundf((rect.size.height - sliderBackCenterImage.size.height) / 2));
    NSRect waitingStepRect = slideRect;
    waitingStepRect.origin.y += 1;
    waitingStepRect.origin.x += 1;
    waitingStepRect.size.width -= 2;
    waitingStepRect.size.height -= 3;
    
    NSDrawThreePartImage(slideRect, sliderBackLeftImage, sliderBackCenterImage, sliderBackRightImage, NO, NSCompositeSourceOver, alpha, flipped);
    
    // Fill =========================

    double width = rect.size.width - sliderKnobImage.size.width;
    double delta = [self doubleValue] - [self minValue];
    double range = [self maxValue] - [self minValue];
    double tick = width / range;
    double deltaInPixels = roundf(delta * tick);
    
    slideRect = rect;

    slideRect = NSInsetRect(slideRect, 0, roundf((rect.size.height - sliderFillCenterImage.size.height) / 2));
    slideRect.origin.y -= 1;
    slideRect.size.width = deltaInPixels + sliderKnobImage.size.width - 1;

    if (self.waiting == NO) {
        NSDrawThreePartImage(slideRect, sliderFillLeftImage, sliderFillCenterImage, sliderFillRightImage, NO, NSCompositeSourceOver, alpha, flipped);        
    } else {
        [self drawWaitingStepInRect:waitingStepRect];
    }
}

- (NSRect)knobRectFlipped:(BOOL)flipped
{
    double width = self.controlView.bounds.size.width - sliderKnobImage.size.width;
    double delta = [self doubleValue] - [self minValue];
    double range = [self maxValue] - [self minValue];
    double tick = width / range;
    double deltaInPixels = roundf(delta * tick);
    
	NSPoint drawPoint;
	drawPoint.x = deltaInPixels;
	drawPoint.y = roundf((self.controlView.bounds.size.height - sliderKnobImage.size.height) / 2);

    NSRect result = NSMakeRect(drawPoint.x, drawPoint.y, sliderKnobImage.size.width, sliderKnobImage.size.height);
    return result;
}

- (void)drawKnob:(NSRect)rect
{
    // Don't draw the knob in the waiting mode...
    if (self.waiting == YES) {
        return;
    }
    
    CGFloat alpha = [self isEnabled] ? 1.0 : 0.5;
    
    [sliderKnobImage drawAtPoint:rect.origin fromRect:NSMakeRect(0, 0, sliderKnobImage.size.width, sliderKnobImage.size.height) 
                       operation:NSCompositeSourceOver fraction:alpha];
}

- (BOOL)_usesCustomTrackImage
{
	return YES;
}

- (void)drawWaitingStepInRect:(NSRect)rect
{
//    NSLog(@"ANIMATION STEP: %lu RECT: %0.2f,%0.2f %0.2fx%0.2f FLIPPED: %@", 
//          self.step, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height,
//          [[self controlView] isFlipped] ? @"YES" : @"NO");    
    
    NSGraphicsContext* context = [NSGraphicsContext currentContext];
    [context saveGraphicsState];
    {{
        NSBezierPath *path = [NSBezierPath bezierPath];
        [path appendBezierPathWithRoundedRect:rect xRadius:(rect.size.height / 2.0) yRadius:(rect.size.height / 2.0)];
        
        NSColor *fillColor = [NSColor colorWithPatternImage:sliderWaitingColorImage];
        
        [context setPatternPhase:NSMakePoint(self.step, rect.origin.y - 3)];
        [fillColor set];
                
        [path fill];        
                
        NSShadow * shadow = [[[NSShadow alloc] init] autorelease];
        [shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.9]];
        [shadow setShadowOffset:NSMakeSize(0.0, -1.0)];
        [shadow setShadowBlurRadius:3.0f];
        
        [path fillWithInnerShadow:shadow];
    }}
    [context restoreGraphicsState];             
}

@end
