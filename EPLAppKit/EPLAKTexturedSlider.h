//
//  EPLAKTexturedSlider.h
//  EPLAppKit
//
//  Created by Andrey Subbotin on 9/29/11.
//  Copyright (c) 2011 Andrey Subbotin. All rights reserved.
//

#import "EPLAKValidatedSlider.h"

@interface EPLAKTexturedSlider : EPLAKValidatedSlider

@property (nonatomic, assign, getter = isWaiting) BOOL waiting;

@end
