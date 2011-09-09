//
//  NLPopoverFrame.h
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

// Check if we actually need to use this code
//#ifndef __MAC_10_7

#import <Cocoa/Cocoa.h>

#import "NLPopoverDefines.h"


@interface NLPopoverFrame : NSView
{
    
    NSRectEdge _arrowDirection;
    
    NSPopoverAppearance _appearance;
    
    NSColor *color;
    NSColor *borderColor;
    NSColor *hudStroke;
    
    CGFloat _borderWidth;

}


@property (nonatomic, retain) NSColor *color;
@property (nonatomic, retain) NSColor *borderColor;
@property (nonatomic, retain) NSColor *hudStroke;

@property NSRectEdge arrowDirection;
@property NSPopoverAppearance appearance;



- (NSBezierPath*)_popoverBezierPathWithRect:(NSRect)aRect;

@end
//#endif
