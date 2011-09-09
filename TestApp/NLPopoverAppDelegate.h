//
//  NLPopoverAppDelegate.h
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NLPopover.h"

@interface NLPopoverAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    
    NLPopover *popover;
}

@property (assign) IBOutlet NLPopover *popover;
@property (assign) IBOutlet NSViewController *popoverViewController;

@property (assign) IBOutlet NSWindow *window;

- (IBAction)togglePopover:(NSButton*)sender;

@end
