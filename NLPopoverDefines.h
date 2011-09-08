//
//  Header.h
//  NLPopover
//
//  Created by Zachry Thayer on 9/8/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

#ifndef NLPopover_Defines_h
#define NLPopover_Defines_h

enum {
    NSPopoverBehaviorApplicationDefined = 0,
    NSPopoverBehaviorTransient = 1,
    NSPopoverBehaviorSemitransient = 2
};
typedef NSInteger NSPopoverBehavior;

enum {
    NSPopoverAppearanceMinimal = 0,
    NSPopoverAppearanceHUD = 1
};
typedef NSInteger NSPopoverAppearance;

NSString * const NSPopoverCloseReasonKey;
NSString * const NSPopoverCloseReasonStandard;
NSString * const NSPopoverCloseReasonDetachToWindow;

/** The arrow height **/ 
#define NLPOPOVER_ARROW_HEIGHT 12.0
/** The arrow width **/
#define NLPOPOVER_ARROW_WIDTH 24.0
/** Corner radius to use when drawing popover corners **/
#define NLPOPOVER_CORNER_RADIUS 4.0


#endif
