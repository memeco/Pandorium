//
//  HUDController.m
//  Pandorium
//
//  Created by Gaurav Khanna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDController.h"

@implementation HUDController

@synthesize window = _window;
@synthesize isName = _isName;
@synthesize statusMenu = _statusMenu;
@synthesize panelView = _panelView;
@synthesize isImage = _isImage;
@synthesize myStatusMenu = _myStatusMenu;
//@synthesize preferencesController = _preferencesController;

@synthesize timerToFadeOut = _timerToFadeOut;
@synthesize timerForHotKeyDelay = _timerForHotKeyDelay;

MAKE_SINGLETON(HUDController, sharedController)

- (id)init {
    self = [super init];
    if (self) {
        NSRect frm = NSMakeRect( 139,  81,  200,  100);
        NSUInteger msk = NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
        NSWindow *win = [[NSPanel alloc] initWithContentRect:frm
                                                   styleMask:msk
                                                     backing:NSBackingStoreBuffered
                                                       defer:YES];
        win.allowsToolTipsWhenApplicationIsInactive = NO;
        win.autorecalculatesKeyViewLoop = NO;
        win.hasShadow = YES;
        win.hidesOnDeactivate = YES;
        win.oneShot = NO;
        win.releasedWhenClosed = YES;
        win.showsToolbarButton = NO;
        win.title = @"Window";
        [win setFrame:NSMakeRect( 139,  81,  200,  100) display:NO];
        
        NSView * v = [[NSView alloc] initWithFrame:NSMakeRect( 100,  0,  200,  100)];
        v.autoresizesSubviews = YES;
        v.autoresizingMask = NSViewMaxXMargin | NSViewMinYMargin;
        v.focusRingType = NSFocusRingTypeDefault;
        v.hidden = NO;
        v.wantsLayer = NO;
        
#ifdef TEXTCELL
        NSTextFieldCell *c = [[NSTextFieldCell alloc] initTextCell:@""];
        c.alignment = NSCenterTextAlignment;
        c.allowsEditingTextAttributes = NO;
        c.backgroundColor = [NSColor colorWithCatalogName:@"System" colorName:@"alternateSelectedControlColor"];
        c.continuous = NO;
        c.controlSize = NSRegularControlSize;
        c.drawsBackground = NO;
        c.editable = NO;
        c.enabled = YES;
        c.focusRingType = NSFocusRingTypeDefault;
        c.font = [NSFont fontWithName:@"Helvetica" size:48];
        c.lineBreakMode = NSLineBreakByWordWrapping;
        c.scrollable = NO;
        c.selectable = NO;
        c.sendsActionOnEndEditing = YES;
        c.state = NSOffState;
        c.tag = 0;
        c.textColor = [NSColor colorWithCalibratedWhite:1 alpha:1];
        c.truncatesLastVisibleLine = NO;
        
        NSTextField *t = [[NSTextField alloc] initWithFrame:NSMakeRect( 17,  33,  166,  31)];
        t.autoresizesSubviews = YES;
        t.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
        t.focusRingType = NSFocusRingTypeDefault;
        t.hidden = NO;
        t.tag = 0;
        t.wantsLayer = NO;
        
        [t setCell:c];
        [v addSubview:t];
#else
        NSTextView *t = [[NSTextView alloc] initWithFrame:NSMakeRect( 0,  0,  200,  100)];
        t.autoresizesSubviews = YES;
        t.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
        t.focusRingType = NSFocusRingTypeDefault;
        t.hidden = NO;
        t.wantsLayer = NO;
        t.backgroundColor = [NSColor colorWithCatalogName:@"System" colorName:@"alternateSelectedControlColor"];
        t.drawsBackground = NO;
        t.font = [NSFont fontWithName:@"Helvetica" size:48];
#ifdef VIEW_SHADOW
        //t.layer.shadowColor = CGColorCreateGenericGray(0, 1);
        t.layer.shadowRadius = 1;
        t.layer.shadowOpacity = 0.5;
        t.layer.shadowOffset = CGSizeMake(0 ,1);
#endif
        
        [v addSubview:t];
#endif
        win.contentView = v;
        
        _window = win;
        _isName = t;
        _statusMenu = nil;
        _panelView = v;
        _isImage = nil;
        _myStatusMenu = nil;
        _timerToFadeOut = nil;
        _timerForHotKeyDelay = nil;
        
        [self initUIComponents];
        return self;
    }
    return nil;
}

- (void)setUpMediaViews {
    
}

- (void)setUpHUD {
    //Set the longest name in the label, the make the label to autofit the name.
#if !GKTEST
    #ifdef TEXTFIELD
        [self.isName setStringValue:@""];
    #endif
#else
    [self.isName setStringValue:[self getLongestInputSourceName]];
#endif
    [self.isName sizeToFit];
    
    //Re-calculate the window frame and the the positions of subviews.
    CGRect labelFrame = [self.isName frame];
    CGRect windowFrame = [self.window frame];
    NSLog(@"label:(%f, %f) (%f x %f) ", labelFrame.origin.x, labelFrame.origin.y, labelFrame.size.width, labelFrame.size.height);
    NSLog(@"window:(%f, %f) (%f x %f) ", windowFrame.origin.x, windowFrame.origin.y, windowFrame.size.width, windowFrame.size.height);
    
    windowFrame.size.width = HUD_HEIGHT + 4;
    windowFrame.size.height = HUD_HEIGHT;
    
    NSRect screenRect = [[[NSScreen screens] objectAtIndex:0] visibleFrame];
    windowFrame.origin.x = ((screenRect.size.width - windowFrame.size.width) / 2);
    windowFrame.origin.y = screenRect.size.height - (screenRect.size.height - (HUD_HEIGHT - 69));
    
    //screenRect.frame.size.height - 703;
    
    [self.window setFrame:windowFrame display:YES];
    
    NSRect viewFrame = windowFrame;
    viewFrame.origin.x = 0;
    viewFrame.origin.y = 0;
    [self.panelView setFrame:viewFrame];
    
    labelFrame.origin.x = HUD_HORIZONTAL_MARGIN;
    labelFrame.origin.y = HUD_VERTICAL_MARGIN;
    [self.isName setFrame:labelFrame];
}

-(void)initUIComponents {
    [self.window setOpaque:NO];
    [self.window setBackgroundColor:[NSColor clearColor]];
    [self.window setLevel:kCGUtilityWindowLevelKey + 1000]; //Make the window be the top most one while displayed. (The 1000 is a magic number.)
    [self.window setStyleMask:NSBorderlessWindowMask]; //No title bar;
    [self.window setHidesOnDeactivate:NO];
    // Make the window behavior like the menu bar.
    [self.window setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
    
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.05, 0.05, 0.05, HUD_ALPHA_VALUE)]; //RGB plus Alpha Channel
    [viewLayer setCornerRadius:HUD_CORNER_RADIUS];
    [self.panelView setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [self.panelView setLayer:viewLayer];
    [[self.panelView layer] setOpacity:0.0];
    
    [self setUpHUD];

#if MEDIA_KEY
    [self setUpMediaViews];
#endif

}

- (void)fadeInHud {
    if (self.timerToFadeOut) {
        [self.timerToFadeOut invalidate];
        self.timerToFadeOut = nil;
    }
    
    fadingOut = NO;
    DLogObject(self.window);
    [self.window orderFrontRegardless];
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:HUD_FADE_IN_DURATION] forKey:kCATransactionAnimationDuration];
    [CATransaction setValue:^{ [self didFadeIn]; } forKey:kCATransactionCompletionBlock];
    
    [[self.panelView layer] setOpacity:1.0];
    
    [CATransaction commit];
}

- (void)fadeInHudKey:(GKHotKey*)key {
    DLogObject(key.symbolicString);
    
    CGFloat fontSize = 102;
    NSFont *textFont = [NSFont fontWithName:@"Webdings" size:fontSize];
    NSColor *liveColor = [NSColor colorWithCalibratedWhite:1 alpha:1];
    
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: 
                          textFont, NSFontAttributeName, 
                          liveColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *nsStr = [[NSMutableAttributedString alloc] initWithString:key.symbolicString attributes:attr];
    CFMutableAttributedStringRef cfStr = (__bridge CFMutableAttributedStringRef)nsStr;
    NSUInteger strLen = [nsStr length];
    
    if (key.hasMediaKey) {
        CTFontRef uniCharFont = (__bridge CTFontRef)[NSFont fontWithName:@"Webdings" size:round(fontSize*.869)];
        CTFontRef pauseFont = (__bridge CTFontRef)[NSFont fontWithName:@"Webdings" size:round(fontSize*1.27)];
        
        int uniCharLen = key.isPlayKey ? 1 : 2;
        CFRange uniCharRange = strLen > 0 ? CFRangeMake(0, uniCharLen) : CFRangeMake(0, 0);
        CFRange pauseRange = key.isPlayKey && strLen > 0 ? CFRangeMake(1, 1) : CFRangeMake(0, 0);
        CFAttributedStringSetAttribute(cfStr, uniCharRange, kCTFontAttributeName, uniCharFont);
        CFAttributedStringSetAttribute(cfStr, pauseRange, kCTFontAttributeName, pauseFont);
        
        
        //CFNumberRef allOffset = (__bridge CFNumberRef)[NSNumber numberWithInt:30];
        //CFAttributedStringSetAttribute(cfStr, CFRangeMake(0, 1), kCTKernAttributeName, allOffset);
        
        
        int nextBackAdj = key.isNextKey ? round(fontSize*-.043478) : round(fontSize*-.2174);
        int kernAdjVal = key.isPlayKey ? round(fontSize*-.33435) : nextBackAdj;
        CFNumberRef uniCharKernAdj = (__bridge CFNumberRef)[NSNumber numberWithInt:kernAdjVal];
        CFAttributedStringSetAttribute(cfStr, uniCharRange, kCTKernAttributeName, uniCharKernAdj);
        
        
        
        
#ifdef TEXTFIELD
        //DLogObject([self.isName cell]);
        //[[self.isName cell] setTitle:nsStr];
        //[self.isName setStringValue:nsStr];
#else
        
        
        NSShadow *sh = [[NSShadow alloc] init];
        [sh setShadowOffset:NSMakeSize(0,-1)];
        [sh setShadowColor:[NSColor blackColor]];
        [sh setShadowBlurRadius:3];
        /*NSMutableParagraphStyle *pSt = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [pSt setAlignment:[self alignment]];
        
        NSDictionary *atts = [NSDictionary dictionaryWithObjectsAndKeys:
                              [self font],NSFontAttributeName,
                              sh,NSShadowAttributeName,
                              [self textColor],NSForegroundColorAttributeName,
                              pSt,NSParagraphStyleAttributeName,nil];*/
        
        [nsStr addAttribute:NSShadowAttributeName value:sh range:NSMakeRange(0, 2)];
        
        
        /*if (key.isPlayKey) {
            //CFNumberRef charsVertAdj = (__bridge CFNumberRef)[NSNumber numberWithFloat:0];
            //CFAttributedStringSetAttribute(cfStr, CFRangeMake(0, 2), kCTSuperscriptAttributeName, charsVertAdj); 
            
            NSNumber *n = [NSNumber numberWithInt:40];
            [nsStr addAttribute:NSBaselineOffsetAttributeName value:n range:NSMakeRange(1, 1)];
            
        }*/
        
        if (key.isNextKey) {
            
            NSNumber *n = [NSNumber numberWithInt:-18];
            [nsStr addAttribute:NSBaselineOffsetAttributeName value:n range:NSMakeRange(0, 2)];
            
        }
        
        if (key.isBackKey) {
            NSNumber *n = [NSNumber numberWithInt:-23];
            [nsStr addAttribute:NSBaselineOffsetAttributeName value:n range:NSMakeRange(0, 2)];
            
            CGRect labelFrame = [self.isName frame];
            labelFrame.origin.x = HUD_HORIZONTAL_MARGIN - 12;
            [self.isName setFrame:labelFrame];
            
//            CFNumberRef uniCharKernAdj = (__bridge CFNumberRef)[NSNumber numberWithInt:-35];
//            CFAttributedStringSetAttribute(cfStr, CFRangeMake(0, 2), kCTKernAttributeName, uniCharKernAdj);
        } else {
            CGRect labelFrame = [self.isName frame];
            labelFrame.origin.x = HUD_HORIZONTAL_MARGIN;
            [self.isName setFrame:labelFrame];
        }
        
        NSRect r = [nsStr boundingRectWithSize:self.isName.frame.size options:0];
        /*if (key.isPlayKey) {
            CGRect labelFrame = [self.isName frame];
            labelFrame.origin.y = HUD_VERTICAL_MARGIN + 25;
            [self.isName setFrame:labelFrame];
        }*/
        
        
        [self.isName.textStorage setAttributedString:nsStr];
        
        DLogFLOAT(r.size.height);
#endif
        
        
    }
    [self fadeInHud];
}

- (void) didFadeIn {
    self.timerToFadeOut = [NSTimer scheduledTimerWithTimeInterval:HUD_DISPLAY_DURATION target:self selector:@selector(fadeOutHud) userInfo:nil repeats:NO];
}

- (void)fadeOutHud {
    fadingOut = YES;
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:HUD_FADE_OUT_DURATION] forKey:kCATransactionAnimationDuration];
    [CATransaction setValue:^{ [self didFadeOut]; } forKey:kCATransactionCompletionBlock];
    
    [[self.panelView layer] setOpacity:0.0];
    
    [CATransaction commit];
}

- (void)didFadeOut {
    if (fadingOut) {
        //GHKLOG(@"Did fade out!");
        [self.window orderOut:nil];
    }
    fadingOut = NO;
}

@end
