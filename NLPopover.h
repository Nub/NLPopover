//
//  NLPopover.h
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//


// Check if we actually need to use this code
//#ifndef __MAC_10_7

#import "NLPopoverFrame.h"
#import "NLPopoverWindow.h"
#import "NLPopoverDelegate.h"
#import "NLPopoverDefines.h"

#import <Quartz/Quartz.h>


@interface NLPopover : NSObject <NSAnimationDelegate>
{
  //Internal Objects
    BOOL shown;
    BOOL animates;
    
    NLPopoverWindow *popoverWindow;
    
    NSPopoverAppearance appearance;
    NSPopoverBehavior behavior;
    
    NSSize contentSize;
    NSViewController *contentViewController;
    
    id <NSPopoverDelegate> delegate;
    
    NSRect positioningRect;
    
}

@property BOOL animates;

@property NSPopoverAppearance appearance;

@property NSPopoverBehavior behavior;

@property NSSize contentSize;

@property (retain) IBOutlet NSViewController *contentViewController;

@property (assign) IBOutlet id <NSPopoverDelegate> delegate;

@property NSRect positioningRect;

@property (readonly, getter=isShown) BOOL shown;

- (void)showRelativeToRect:(NSRect)positioningRect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge;

- (IBAction)performClose:(id)sender;

- (void)close;

@end


// Hide custom implementation
#define NSPopover NLPopover

//#endif

