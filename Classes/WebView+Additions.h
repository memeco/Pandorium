//
//  WebView+Additions.h
//  Pandorium
//
//  Created by Gaurav Khanna on 8/16/10.
//

#import <WebKit/WebKit.h>
#import "NSObject+GKAdditions.h"
#import "NSEvent+Additions.h"

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