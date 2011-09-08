//
//  NLPopoverWindow.h
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

// Check if we actually need to use this code
//#ifndef __MAC_10_7

#import "NLPopoverDefines.h"
#import "NLPopoverFrame.h"

@interface NLPopoverWindow : NSWindow
{
    NSView *_popoverContentView;
}

@property (nonatomic, readonly) NLPopoverFrame *frameView;

@end

//#endif
