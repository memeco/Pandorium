//
//  PandoriumAppDelegate.h
//  Pandorium
//
//  Created by Gaurav Khanna on 8/20/10.
//

#import <WebKit/WebKit.h>
#import "HotKeyController.h"
#import "WebView+Additions.h"

@interface PandoriumAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
    IBOutlet NSWindow *_window;
    IBOutlet WebView *_webView;
    IBOutlet NSMenu *_statusMenu;
    NSStatusItem *_statusItem;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet WebView *webView;
@property (nonatomic, retain) IBOutlet NSMenu *statusMenu;
@property (nonatomic, retain) NSStatusItem *statusItem;

- (IBAction)showPandorium:(id)sender;
- (IBAction)quitPandorium:(id)sender;

@end

