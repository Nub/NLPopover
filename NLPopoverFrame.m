//
//  NLPopoverFrame.m
//  NLPopover
//
//  Created by Zachry Thayer on 9/7/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

// Check if we actually need to use this code
//#ifndef __MAC_10_7

#import "NLPopoverFrame.h"

@implementation NLPopoverFrame

@synthesize arrowDirection = _arrowDirection;
@synthesize appearance = _appearance;
@synthesize color;
@synthesize borderColor;
@synthesize hudStroke;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set some default values
        self.arrowDirection = NSMaxYEdge;
        
        [self setAppearance:NSPopoverAppearanceMinimal];

    }
    return self;
}

- (void)dealloc
{
    [color release];
    [borderColor release];
    [hudStroke release];
    
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *path = [self _popoverBezierPathWithRect:[self bounds]];
    
    CGContextRef ref = [[NSGraphicsContext currentContext] graphicsPort];
        
    //Gradient and extra stroke for HUD mimic
    if(self.appearance == NSPopoverAppearanceHUD){
        
        NSGradient *borderGradient =
        [[[NSGradient alloc]
          initWithColorsAndLocations:
          [NSColor colorWithCalibratedWhite:0.65 alpha:0.85],0.0,
          [NSColor colorWithCalibratedWhite:0.15 alpha:0.85],0.08, nil]
         autorelease];
        [borderGradient drawInBezierPath:path angle:-90];
        
        [path setLineWidth:_borderWidth];
        [self.borderColor set];
        [path stroke];
        
        //Stroke Inside
        [path setLineWidth:2];
        [self.hudStroke set];
        CGContextSaveGState(ref);
            [path addClip];
            [path stroke];
        CGContextRestoreGState(ref);
        
    }else if(self.appearance == NSPopoverAppearanceMinimal){
        
        //Fix blurred edges by offsetting by half a pixel
        CGContextTranslateCTM(ref, 0.5, 0.5);
        
        [self.color set];
        [path fill];//Default fill
    
        [path setLineWidth:_borderWidth];
        [self.borderColor set];
        [path stroke];
    }
    
    

}

#pragma mark -
#pragma mark Private

- (NSBezierPath*)_popoverBezierPathWithRect:(NSRect)aRect
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    CGFloat radius = NLPOPOVER_CORNER_RADIUS;
    CGFloat inset = radius + NLPOPOVER_ARROW_HEIGHT;
    NSRect drawingRect = NSInsetRect(aRect, inset, inset);
    CGFloat minX = NSMinX(drawingRect);
    CGFloat maxX = NSMaxX(drawingRect);
    CGFloat minY = NSMinY(drawingRect);
    CGFloat maxY = NSMaxY(drawingRect);
    
    // Bottom left corner
    [path appendBezierPathWithArcWithCenter:NSMakePoint(minX, minY) radius:radius startAngle:180.0 endAngle:270.0];
    
    if (self.arrowDirection == NSMinYEdge) {
        CGFloat midX = NSMidX(drawingRect);
        NSPoint points[3];
        points[0] = NSMakePoint(floor(midX - (NLPOPOVER_ARROW_WIDTH / 2.0)), minY - radius); // Starting point
        points[1] = NSMakePoint(floor(midX), points[0].y - NLPOPOVER_ARROW_HEIGHT + 1); // Arrow tip
        points[2] = NSMakePoint(floor(midX + (NLPOPOVER_ARROW_WIDTH / 2.0)), points[0].y); // Ending point
        [path appendBezierPathWithPoints:points count:3];
    }
    // Bottom right corner
    [path appendBezierPathWithArcWithCenter:NSMakePoint(maxX, minY) radius:radius startAngle:270.0 endAngle:360.0];
    
    if (self.arrowDirection == NSMaxXEdge) {
        CGFloat midY = NSMidY(drawingRect);
        NSPoint points[3];
        points[0] = NSMakePoint(maxX + radius, floor(midY - (NLPOPOVER_ARROW_WIDTH / 2.0)));
        points[1] = NSMakePoint(points[0].x + NLPOPOVER_ARROW_HEIGHT, floor(midY));
        points[2] = NSMakePoint(points[0].x, floor(midY + (NLPOPOVER_ARROW_WIDTH / 2.0)));
        [path appendBezierPathWithPoints:points count:3];
    }
    // Top right corner
    [path appendBezierPathWithArcWithCenter:NSMakePoint(maxX, maxY) radius:radius startAngle:0.0 endAngle:90.0];
    
    if (self.arrowDirection == NSMaxYEdge) {
        CGFloat midX = NSMidX(drawingRect);
        NSPoint points[3];
        points[0] = NSMakePoint(floor(midX + (NLPOPOVER_ARROW_WIDTH / 2.0)), maxY + radius);
        points[1] = NSMakePoint(floor(midX), points[0].y + NLPOPOVER_ARROW_HEIGHT - 1);
        points[2] = NSMakePoint(floor(midX - (NLPOPOVER_ARROW_WIDTH / 2.0)), points[0].y);
        [path appendBezierPathWithPoints:points count:3];
    }
    // Top left corner
    [path appendBezierPathWithArcWithCenter:NSMakePoint(minX, maxY) radius:radius startAngle:90.0 endAngle:180.0];
    
    if (self.arrowDirection == NSMinXEdge) {
        CGFloat midY = NSMidY(drawingRect);
        NSPoint points[3];
        points[0] = NSMakePoint(minX - radius, floor(midY + (NLPOPOVER_ARROW_WIDTH / 2.0)));
        points[1] = NSMakePoint(points[0].x - NLPOPOVER_ARROW_HEIGHT, floor(midY));
        points[2] = NSMakePoint(points[0].x, floor(midY - (NLPOPOVER_ARROW_WIDTH / 2.0)));
        [path appendBezierPathWithPoints:points count:3];
    }
    [path closePath];
    return path;
}

- (void)setArrowDirection:(NSRectEdge)newArrowDirection
{
    _arrowDirection = newArrowDirection;
    [self setNeedsDisplay:YES];
    
}

- (void)setAppearance:(NSPopoverAppearance)newAppearance
{
    
    _appearance = newAppearance;
    
    [color release];
    [borderColor release];
    [hudStroke release];
    
    switch(_appearance){ 
        case NSPopoverAppearanceMinimal:
            self.color = [NSColor colorWithCalibratedWhite:0.95 alpha:0.95];
            self.borderColor = [NSColor colorWithCalibratedWhite:1.0 alpha:1.0];
            _borderWidth = 1.0;
            break;
        case NSPopoverAppearanceHUD:
            self.color = [NSColor colorWithCalibratedWhite:0.15 alpha:0.85];
            self.borderColor = [NSColor colorWithCalibratedWhite:0.0 alpha:0.65];
            self.hudStroke = [NSColor colorWithCalibratedWhite:1.0 alpha:0.35];
            _borderWidth = 2;
            break;
    }
    
    [self setNeedsDisplay:YES];
    
}

@end

//#endif
