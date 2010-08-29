//
//  WebView+Additions.m
//  Pandorium
//
//  Created by Gaurav Khanna on 8/16/10.
//

#import "WebView+Additions.h"

@implementation WebView (Additions)

- (void)keyClickWithKeyCode:(unsigned short)keyCode {
    NSEvent *fakeClickDown = [[NSEvent keyEventWithType:NSKeyDown keyCode:keyCode] retain];
    NSEvent *fakeClickUp = [[NSEvent keyEventWithType:NSKeyUp keyCode:keyCode] retain];
    
    NSView *respondingView = [self hitTest:NSMakePoint(300.0, 300.0)];
    
    [self dump];
    
    DLogObject(respondingView);
    
    if([respondingView isMemberOfClass:NSClassFromString(@"WebHTMLView")])
        respondingView = [(WebHTMLView*)respondingView _hitViewForEvent:fakeClickDown];
        
    DLogObject(respondingView);
    
    [respondingView keyDown:fakeClickDown];
    [respondingView keyUp:fakeClickUp];
    
    [fakeClickDown release];
    [fakeClickUp release];
}

- (void)mouseClickAtLocation:(NSPoint)point {
    NSEvent *fakeMouseDown = nil;
    NSEvent *fakeMouseUp   = nil;
    
    fakeMouseDown = [[NSEvent mouseEventWithType:NSLeftMouseDown point:point] retain];
    fakeMouseUp   = [[NSEvent mouseEventWithType:NSLeftMouseUp point:point] retain];
    
    NSView *respondingView = [self hitTest:point];
    
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
}

@end

#ifdef TEST

@implementation WebHTMLView (Additions)

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

- (void)keyDown:(NSEvent *)event {
    DLogFunc();
    DLogObject([self _hitViewForEvent:event]);
    DLogBOOL([self acceptsFirstResponder]);
    DLogObject(self);
    DLogObject(event);
    DLog(@" ----------------- ");
}

- (void)keyUp:(NSEvent *)event {
    DLogFunc();
    DLogObject([self _hitViewForEvent:event]);
    DLogBOOL([self acceptsFirstResponder]);
    DLogObject(self);
    DLogObject(event);
    DLog(@" ----------------- ");
}


@end

#endif
