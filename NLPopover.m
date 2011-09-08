//
//  NLPopover.m
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//


// Optional force backwards compatability (Uncomment following line)
//#define __MAC_10_7 1065


// Check if we actually need to use this code
//#ifndef __MAC_10_7


#import "NLPopover.h"

NSString * const NSPopoverCloseReasonKey = @"NSPopoverCloseReasonKey";
NSString * const NSPopoverCloseReasonStandard = @"NSPopoverCloseReasonStandard";
NSString * const NSPopoverCloseReasonDetachToWindow = @"NSPopoverCloseReasonDetachToWindow";

@implementation NLPopover

@synthesize animates;
@synthesize appearance;
@synthesize behavior;
@synthesize contentSize;
@synthesize contentViewController;
@synthesize delegate;
@synthesize positioningRect;
@synthesize shown = _shown;

- (id)init
{
    self = [super init];
    if (self) {
        
        // Set default values;
        self.animates = YES;
        self.appearance = NSPopoverAppearanceMinimal;
        self.behavior = NSPopoverBehaviorApplicationDefined;
        self.contentViewController = nil;
        self.delegate = nil;
        _shown = NO;
    
    }
    
    return self;
}

- (void)showRelativeToRect:(NSRect)positioningRect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge{

}

- (IBAction)performClose:(id)sender{

}

- (void)close{

}


@end

//#endif