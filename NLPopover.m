//
//  NLPopover.m
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//


// Optional force backwards compatability (Uncomment following line)
#define _NLPOPOVER_FORCE


// Check if we actually need to use this code
//#ifndef __MAC_10_7


#import "NLPopover.h"

NSString * const NSPopoverCloseReasonKey = @"NSPopoverCloseReasonKey";
NSString * const NSPopoverCloseReasonStandard = @"NSPopoverCloseReasonStandard";
NSString * const NSPopoverCloseReasonDetachToWindow = @"NSPopoverCloseReasonDetachToWindow";

@interface NLPopover (Private)
        
- (NSRect)windowFrameWithArrowDirection:(NSRectEdge)direction inWindow:(NSWindow*)mainWindow;
- (NSRect)clearRectFromFinishRect:(NSRect)finishRect forDirection:(NSRectEdge)direction;

@end

@implementation NLPopover

@synthesize animates;
@synthesize appearance;
@synthesize behavior;
@synthesize contentSize;
@synthesize contentViewController;
@synthesize delegate;
@synthesize positioningRect;
@synthesize shown;

#pragma mark -
#pragma mark Public Methods

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
        shown = NO;
        
    }
    
    return self;
}

- (void)showRelativeToRect:(NSRect)newPositioningRect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge{
    
    if(!shown){
        
        popoverWindow = [[NLPopoverWindow alloc] initWithContentRect:NSMakeRect(0, 0, 100, 100) styleMask: NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
        
        contentSize = contentViewController.view.bounds.size;
        positioningRect = newPositioningRect;
        popoverWindow.frameView.arrowDirection = preferredEdge;
        
        popoverWindow.contentView = contentViewController.view;
        
        NSWindow *mainWindow = [positioningView window];
        
        [mainWindow addChildWindow:popoverWindow ordered:NSWindowAbove];
        
        NSRect newFrame = [self windowFrameWithArrowDirection:preferredEdge inWindow:mainWindow];
        
        NSRect clearFrame = [self clearRectFromFinishRect:newFrame forDirection:preferredEdge];
        
        [[popoverWindow contentView] setAlphaValue:0.0];
        [popoverWindow setAlphaValue:0.0];
        [popoverWindow setFrame:clearFrame display:NO];
        
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:0.5];
        [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.97 :0.00 :0.45 :1.00]]; 
        
        [[[popoverWindow contentView] animator] setAlphaValue:1.0];
        [[popoverWindow animator] setAlphaValue:1.0];
        [[popoverWindow animator] setFrame:newFrame display:YES];
        
        [NSAnimationContext endGrouping];
    
        shown = YES;
        
        NSLog(@"Show Popover");
        
    }    
}

- (IBAction)performClose:(id)sender{

    [self close];
    
    //TODO: Alerts go here
}

- (void)close{
    
    if(shown){
        
        if(animates){
            [[popoverWindow animator] setAlphaValue:0.0];
            [[popoverWindow animator] setDelegate:self];
        }
        
        
        shown = NO;
        
        NSLog(@"Hide Popover");
        
    }

}

#pragma mark -
#pragma mark Private Methods

- (void)animationDidEnd:(NSAnimation *)animation{
    
    if (shown) {
        
    }else{
        [[popoverWindow parentWindow] removeChildWindow:popoverWindow];
        [popoverWindow close];
    }
    
}

- (void) setContentSize:(NSSize)newContentSize{
    contentSize = newContentSize;
}

- (NSRect)clearRectFromFinishRect:(NSRect)finishRect forDirection:(NSRectEdge)direction{
    
    NSRect retFrame;
    
    switch (direction) {
        case NSMaxYEdge:
            retFrame = NSMakeRect(finishRect.origin.x + (finishRect.size.width * 0.5), finishRect.origin.y + (finishRect.size.height) , 0, 0);
            break;
        case NSMinYEdge:
            retFrame = NSMakeRect(finishRect.origin.x + (finishRect.size.width * 0.5), finishRect.origin.y, 0, 0);
            break;
        case NSMaxXEdge:
            retFrame = NSMakeRect(finishRect.origin.x + (finishRect.size.width * 0.5), finishRect.origin.y + (finishRect.size.height) , 0, 0);
            break;
        case NSMinXEdge:
            retFrame = NSMakeRect(finishRect.origin.x + (finishRect.size.width * 0.5), finishRect.origin.y + (finishRect.size.height) , 0, 0);
            break;
            
    }
    
    return retFrame;
    
}

- (NSRect)windowFrameWithArrowDirection:(NSRectEdge)direction inWindow:(NSWindow*)mainWindow
{
    
        
    NSRect mainWindowFrame = [mainWindow frame];
    
    NSLog(@"%@",NSStringFromRect(positioningRect));
    
    NSSize popoverSize = [popoverWindow frame].size;
    
    //Base positions
    CGFloat yPos = mainWindowFrame.origin.y;
    CGFloat xPos = mainWindowFrame.origin.x;

    
    switch (direction) {
        case NSMaxYEdge:
            xPos += positioningRect.origin.x + (positioningRect.size.width * 0.5)  - (contentSize.width * 0.5);
            yPos += positioningRect.origin.y + (positioningRect.size.height * 0.5) - contentSize.height - NLPOPOVER_ARROW_HEIGHT;   
            break;
            
        case NSMinYEdge:
            xPos += positioningRect.origin.x + (positioningRect.size.width * 0.5)  - (contentSize.width * 0.5);
            yPos += positioningRect.origin.y + positioningRect.size.height; 

            break;
            
        case NSMaxXEdge:
            yPos += positioningRect.origin.y + (positioningRect.size.height * 0.5)  - (contentSize.height * 0.5);
            xPos += positioningRect.origin.x - contentSize.width; 
            
            break;
            
        case NSMinXEdge:
            yPos += positioningRect.origin.y + (positioningRect.size.height * 0.5)  - (contentSize.height * 0.5);
            xPos += positioningRect.origin.x + positioningRect.size.width;
            
            break;
    }
    
    NSRect newFrame = NSMakeRect(xPos , yPos, contentSize.width, contentSize.height);
    
    return newFrame;
    
}

@end

//#endif