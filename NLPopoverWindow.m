//
//  NLPopoverWindow.m
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

// Check if we actually need to use this code
//#ifndef __MAC_10_7

#import "NLPopoverWindow.h"

typedef void * CGSConnectionID;

extern OSStatus CGSNewConnection(const void **attr, CGSConnectionID *id);

@implementation NLPopoverWindow

// Borderless, transparent window
- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation
{
    if ((self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:deferCreation])) {
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        
        CGSConnectionID _myConnection;
        uint32_t __compositingFilter;
        
        int __compositingType = 1; // Apply filter to contents underneath the window, then draw window normally on top
        
        /* Make a new connection to CoreGraphics, alternatively you could use the main connection*/
        
        CGSNewConnection(NULL , &_myConnection);
        
        /* The following creates a new CoreImage filter, then sets its options with a dictionary of values*/
        
        CGSNewCIFilterByName (_myConnection, (CFStringRef)@"CIGaussianBlur", &__compositingFilter);
        NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:3.0] forKey:@"inputRadius"];
        CGSSetCIFilterValuesFromDictionary(_myConnection, __compositingFilter, (CFDictionaryRef)optionsDict);
        
        /* Now just switch on the filter for the window */
        
        CGSAddWindowFilter(_myConnection, [self windowNumber], __compositingFilter, __compositingType );
        
        [self setHasShadow:YES];
        
    }
    return self;
}

// Leave some space around the content for drawing the arrow
- (NSRect)contentRectForFrameRect:(NSRect)windowFrame
{
    windowFrame.origin = NSZeroPoint;
    return NSInsetRect(windowFrame, NLPOPOVER_ARROW_HEIGHT, NLPOPOVER_ARROW_HEIGHT);
}

- (NSRect)frameRectForContentRect:(NSRect)contentRect
{
    return NSInsetRect(contentRect, -NLPOPOVER_ARROW_HEIGHT, -NLPOPOVER_ARROW_HEIGHT);
}

// Allow the popover to become the key window
- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return NO;
}

// Override the content view accessor to return the actual popover content view
- (NSView*)contentView
{
    return _popoverContentView;
}

- (NLPopoverFrame*)frameView
{
    return (NLPopoverFrame*)[super contentView];
}

- (void)setContentView:(NSView *)aView
{
	if ([_popoverContentView isEqualTo:aView]) { return; }
	NSRect bounds = [self frame];
	bounds.origin = NSZeroPoint;
	NLPopoverFrame *frameView = [super contentView];
	if (!frameView) {
		frameView = [[[NLPopoverFrame alloc] initWithFrame:bounds] autorelease];
		[super setContentView:frameView];
	}
	if (_popoverContentView) {
		[_popoverContentView removeFromSuperview];
	}
	_popoverContentView = aView;
	[_popoverContentView setFrame:[self contentRectForFrameRect:bounds]];
	[_popoverContentView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
	[frameView addSubview:_popoverContentView];
}

@end

//#endif
