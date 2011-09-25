//
//  NSColor+EPLAppKit.m
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/25/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "NSColor+EPLAppKit.h"

@implementation NSColor (EPLAppKit)

+ (NSColor *)colorWithRGBHex:(UInt32)hex 
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [self colorWithCalibratedRed:r / 255.0f
                                  green:g / 255.0f
                                   blue:b / 255.0f
                                  alpha:1.0f];
}

// Returns a NSColor by scanning the string for a hex number and passing that to +[NSColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (NSColor *)colorWithHexString:(NSString *)stringToConvert 
{
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [self colorWithRGBHex:hexNum];
}

@end
