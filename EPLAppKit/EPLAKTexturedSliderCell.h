//
//  EPLAKTexturedSliderCell.h
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/29/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface EPLAKTexturedSliderCell : NSSliderCell

@property (nonatomic, assign, getter = isWaiting) BOOL waiting;
@property (nonatomic, assign) NSUInteger step;

@end
