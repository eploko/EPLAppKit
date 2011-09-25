//
//  NSColor+EPLAppKit.h
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/25/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSColor (EPLAppKit)

+ (NSColor *)colorWithRGBHex:(UInt32)hex;
+ (NSColor *)colorWithHexString:(NSString *)stringToConvert;

@end
