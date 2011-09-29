//
//  EPLAKTexturedSliderCell.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/29/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "EPLAKTexturedSliderCell.h"

@implementation EPLAKTexturedSliderCell

static NSImage *sliderKnobImage;
static NSImage *sliderBackLeftImage, *sliderBackCenterImage, *sliderBackRightImage;
static NSImage *sliderFillLeftImage, *sliderFillCenterImage, *sliderFillRightImage;

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

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    [self drawBarInside:cellFrame flipped:[controlView isFlipped]];
    [self drawKnob:cellFrame];        
}

- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped
{	
    // Track ========================
    
	NSRect slideRect = rect;

	// Inset the bar so the knob goes all the way to both ends
    slideRect = NSInsetRect(slideRect, 0, roundf((rect.size.height - sliderBackCenterImage.size.height) / 2));
    
    CGFloat alpha = [self isEnabled] ? 1.0 : 0.5;
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

    NSDrawThreePartImage(slideRect, sliderFillLeftImage, sliderFillCenterImage, sliderFillRightImage, NO, NSCompositeSourceOver, alpha, flipped);
}

- (void)drawKnob:(NSRect)rect
{
    double width = rect.size.width - sliderKnobImage.size.width;
    double delta = [self doubleValue] - [self minValue];
    double range = [self maxValue] - [self minValue];
    double tick = width / range;
    double deltaInPixels = roundf(delta * tick);
    
	NSPoint drawPoint;
	drawPoint.x = deltaInPixels;
	drawPoint.y = roundf((rect.size.height - sliderKnobImage.size.height) / 2);
    
    CGFloat alpha = [self isEnabled] ? 1.0 : 0.5;
    [sliderKnobImage drawAtPoint:drawPoint fromRect:NSMakeRect(0, 0, sliderKnobImage.size.width, sliderKnobImage.size.height) 
                       operation:NSCompositeSourceOver fraction:alpha];
}

//- (BOOL)_usesCustomTrackImage
//{
//	return YES;
//}

@end
