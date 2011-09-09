//
//  NLPopoverAppDelegate.m
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

#import "NLPopoverAppDelegate.h"

@implementation NLPopoverAppDelegate

@synthesize popover;
@synthesize popoverViewController;
@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}


- (IBAction)togglePopover:(NSButton*)sender{
    
    if ([self.popover isShown]) {
        [self.popover close];
        return;
    }
        
    [self.popover showRelativeToRect:[sender frame] ofView:sender preferredEdge:NSMinYEdge];
    
}

@end
