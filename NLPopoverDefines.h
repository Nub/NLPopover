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
    NLPopoverBehaviorApplicationDefined = 0,
#define NSPopoverBehaviorApplicationDefined NLPopoverBehaviorApplicationDefined
    NLPopoverBehaviorTransient = 1,
#define NSPopoverBehaviorTransient NLPopoverBehaviorTransient
    NLPopoverBehaviorSemitransient = 2
#define NSPopoverBehaviorSemitransient NLPopoverBehaviorSemitransient
    
};
typedef NSInteger NSPopoverBehavior;

enum {
    NLPopoverAppearanceMinimal = 0,
#define NSPopoverAppearanceMinimal NLPopoverAppearanceMinimal
    NLPopoverAppearanceHUD = 1
#define NSPopoverAppearanceHUD NLPopoverAppearanceHUD
    
};
typedef NSInteger NSPopoverAppearance;

NSString * const NLPopoverCloseReasonKey;
NSString * const NLPopoverCloseReasonStandard;
NSString * const NLPopoverCloseReasonDetachToWindow;

/** The arrow height **/ 
#define NLPOPOVER_ARROW_HEIGHT 12.0
/** The arrow width **/
#define NLPOPOVER_ARROW_WIDTH 24.0
/** Corner radius to use when drawing popover corners **/
#define NLPOPOVER_CORNER_RADIUS 4.0


#endif
