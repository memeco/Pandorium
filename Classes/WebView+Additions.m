//
//  WebView+Additions.m
//  Pandorium
//
//  Created by Gaurav Khanna on 8/16/10.
//

#import "WebView+Additions.h"

@implementation WebView (Additions)

- (id)webHTMLView {
    NSView *webHTMLView = nil;
    
    //FIXME: recurse through entire hierarchy to get WebHTMLView instance
    //preprogrammed traversal can cause problems
    NSView *view = [[[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:0];
    
    for(NSView *subview in view.subviews) {
        if([subview isKindOfClass:[WebHTMLView class]])
            webHTMLView = subview;
    }
    return webHTMLView;
}

@end

@implementation WebHTMLView (Additions)

/*- (void)mouseClickAtLocation:(NSPoint)point {
    NSEvent *fakeMouseDown = nil;
    NSEvent *fakeMouseUp   = nil;
    
    fakeMouseDown = [[NSEvent mouseEventWithType:NSLeftMouseDown point:point] retain];
    fakeMouseUp   = [[NSEvent mouseEventWithType:NSLeftMouseUp point:point] retain];
    
    NSView *respondingView = [self _hitViewForEvent:fakeMouseDown];
    
    [respondingView becomeFirstResponder];
    
    [respondingView mouseDown:fakeMouseDown];
    [respondingView mouseUp:fakeMouseUp];
    
    [fakeMouseDown release];
    [fakeMouseUp release];
    
    //FIXME: requires a second set of mouseDown/mouseUp to take effect
    // shouldn't be neccesary, need to figure out proper workaround
    fakeMouseDown = [[NSEvent mouseEventWithType:NSLeftMouseDown point:point] retain];
    fakeMouseUp   = [[NSEvent mouseEventWithType:NSLeftMouseUp point:point] retain];
    
    [respondingView mouseDown:fakeMouseDown];
    [respondingView mouseUp:fakeMouseUp];
    
    [fakeMouseDown release];
    [fakeMouseUp release];
    
    //FIXME: stupid flash/Pandora changes the cursor to the hand,
    // need now and delayed 'set's to make sure hand doesn't stay
    [[NSCursor arrowCursor] set];
    [NSObject scheduleRunAfterDelay:0.1 forBlock:^{
        [[NSCursor arrowCursor] set]; 
    }];
    [NSObject scheduleRunAfterDelay:0.5 forBlock:^{
        [[NSCursor arrowCursor] set]; 
    }];
}*/

- (void)mouseClickAtLocation:(NSPoint)point {
    NSEvent *fakeMouseDown = nil;
    NSEvent *fakeMouseUp   = nil;
    //DLogFunc();
    fakeMouseDown = [[NSEvent mouseEventWithType:NSLeftMouseDown point:point] retain];
    fakeMouseUp   = [[NSEvent mouseEventWithType:NSLeftMouseUp point:point] retain];
    //DLogFunc();
    NSView *respondingView = [self _hitViewForEvent:fakeMouseDown];
    //DLogObject(respondingView);
    //respondingView = self;
    //DLogCGRect(respondingView.frame);
    //[self dump];
    
    //DLogObject([NSView focusView]);
    //[respondingView lockFocus];
    
    //DLogObject([self window]);
    //DLogObject([respondingView window]);
    
    //[[self window] setActivateFakeScreenCoordinates:TRUE];
    
    //DLogBOOL([respondingView acceptsFirstResponder]);
    //[respondingView becomeFirstResponder];
    //[respondingView sendActivateEvent:YES];
    //[respondingView invalidatePluginContentRect:[self bounds]];
    //[respondingView restartTimers];
    //[respondingView becomeFirstResponder];
    //[respondingView windowFocusChanged:TRUE];
    //[[[self superview] window] windowFocusChanged:TRUE];
    
    //[NSApp sendEvent:fakeMouseDown];
    //[NSApp postEvent:fakeMouseDown atStart:YES];
    
    //DLog(@" %i %@ ", respondingCView->_eventHandler, respondingCView->_eventHandler);
    
    [respondingView mouseDown:fakeMouseDown];
    //[NSApp sendEvent:fakeMouseUp];
    [respondingView mouseUp:fakeMouseUp];
    
    [fakeMouseDown release];
    [fakeMouseUp release];
    
    //FIXME: requires a second set of mouseDown/mouseUp to take effect
    // shouldn't be neccesary, need to figure out proper workaround
    fakeMouseDown = [[NSEvent mouseEventWithType:NSLeftMouseDown point:point] retain];
    fakeMouseUp   = [[NSEvent mouseEventWithType:NSLeftMouseUp point:point] retain];
    
    [respondingView mouseDown:fakeMouseDown];
    [respondingView mouseUp:fakeMouseUp];
    
    [fakeMouseDown release];
    [fakeMouseUp release];
    
    //[respondingView unlockFocus];
    
    //DLogBOOL([respondingView acceptsFirstResponder]);
    
    //[[self window] setActivateFakeScreenCoordinates:FALSE];
    
    //FIXME: stupid flash/Pandora changes the cursor to the hand,
    // need now and delayed 'set's to make sure hand doesn't stay
    /*[[NSCursor arrowCursor] set];
    [NSObject scheduleRunAfterDelay:0.1 forBlock:^{
        [[NSCursor arrowCursor] set]; 
    }];
    [NSObject scheduleRunAfterDelay:0.5 forBlock:^{
        [[NSCursor arrowCursor] set]; 
    }];*/
    //DLogFunc();
}

#ifdef TEST

- (void)mouseDown:(NSEvent *)event {
    DLogFunc();
    DLogObject([self _hitViewForEvent:event]);
    DLogBOOL([self acceptsFirstResponder]);
    DLogObject(self);
    DLogObject(event);
    DLog(@" ----------------- ");
}

- (void)mouseUp:(NSEvent *)event {
    DLogFunc();
    DLogObject([self _hitViewForEvent:event]);
    DLogBOOL([self acceptsFirstResponder]);
    DLogObject(self);
    DLogObject(event);
    DLog(@" ----------------- ");
}

#endif

@end

#ifdef TEST1

@implementation WebHostedNetscapePluginView (Additions)

- (void)mouseDown:(NSEvent *)event {
    DLogFunc();
    //DLogObject([self _hitViewForEvent:event]);
    DLogBOOL([self acceptsFirstResponder]);
    DLogObject(self);
    DLogObject(event);
    DLog(@" ----------------- ");
}

- (void)mouseUp:(NSEvent *)event {
    DLogFunc();
    //DLogObject([self _hitViewForEvent:event]);
    DLogBOOL([self acceptsFirstResponder]);
    DLogObject(self);
    DLogObject(event);
    DLog(@" ----------------- ");
}

@end

#endif
