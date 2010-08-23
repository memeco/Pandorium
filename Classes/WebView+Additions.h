//
//  WebView+Additions.h
//  Pandorium
//
//  Created by Gaurav Khanna on 8/16/10.
//

#import <WebKit/WebKit.h>
#import "NSObject+GKAdditions.h"
#import "NSEvent+Additions.h"

#define NX_KEYTYPE_SPACE 57
#define NX_KEYTYPE_RIGHTARROW 132
#define NX_KEYTYPE_PLUS 32 //Shift?
#define NX_KEYTYPE_MINUS 35
#define NX_KEYTYPE_UPARROW 134
#define NX_KEYTYPE_DOWNARROW 133

//#define TEST

@interface WebHTMLView : NSControl {
    
}

- (NSView *)_hitViewForEvent:(NSEvent *)event;

@end

#ifdef TEST
@interface WebHostedNetscapePluginView : NSView {

}

@end
#endif

@interface WebView (Additions)

- (id)webHTMLView;

@end

@interface WebHTMLView (Additions)

- (void)keyClickWithKeyCode:(unsigned short)keyCode;
- (void)mouseClickAtLocation:(NSPoint)point;

#ifdef TEST

- (void)mouseDown:(NSEvent *)event;
- (void)mouseUp:(NSEvent *)event;

#endif

@end

#ifdef TEST1
@interface WebHostedNetscapePluginView (Additions)

- (void)mouseDown:(NSEvent *)event;
- (void)mouseUp:(NSEvent *)event;

@end
#endif