//
//  PandoriumAppDelegate.m
//  Pandorium
//
//  Created by Gaurav Khanna on 8/20/10.
//

#import "PandoriumAppDelegate.h"

#define PANDORA_EMBED_WIDTH     640.0
#define PANDORA_EMBED_HEIGHT    630.0

@implementation PandoriumAppDelegate

@synthesize window = _window, statusMenu = _statusMenu, statusItem = _statusItem, webView = _webView;

#pragma mark -
#pragma mark Application Management

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_window setDelegate:self];
    
    [_webView setMainFrameURL:@"http://pandora.com"];
    [_webView setResourceLoadDelegate:self];
    [_webView setShouldUpdateWhileOffscreen:TRUE];
    
    [HotKeyController sharedController];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(playPauseKeyNotification) name:MediaKeyPlayPauseNotification object:nil];
    [center addObserver:self selector:@selector(nextKeyNotification) name:MediaKeyNextNotification object:nil];
    [center addObserver:self selector:@selector(previousKeyNotification) name:MediaKeyPreviousNotification object:nil];
}

-(void)awakeFromNib{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setMenu:_statusMenu];
    [_statusItem setImage:[NSImage imageNamed:@"status_icon"]];
    [_statusItem setAlternateImage:[NSImage imageNamed:@"status_icon_highlighted"]];
    [_statusItem setHighlightMode:YES];
}

- (IBAction)showPandorium:(id)sender {
    //FIXME: [window makeKeyAndOrderFront:self] doesn't work here for some reason
    [NSApp activateIgnoringOtherApps:TRUE];
}

- (IBAction)quitPandorium:(id)sender {
    [NSApp terminate:self];
}

- (void)windowWillClose:(NSNotification *)aNotification {
    //LOOK@: consider adding preference for this
    [NSApp terminate:self];
}

#pragma mark -
#pragma mark WebView delegate Methods

- (void)webView:(WebView *)webView resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource {
    //SEE: strips all elements away from the <object> (the flash part)
    // consider using DOMDocument methods to manipulate css, 
    // since no real javascript is used, no reason to invoke JSToolKit
    [webView stringByEvaluatingJavaScriptFromString:@"                                                      \
         var sheet = document.createElement('style');                                                       \
         sheet.innerHTML = '#footer {display:none !important;}                                              \
                            #container {height:661px;left:-44px;top:-27px;width:683px;}                     \
                            #enhanced_skin_container {display:none;}                                        \
                            body {background:none !important;}                                              \
                           ';                                                                               \
         document.body.appendChild(sheet);                                                                  \
     "];
}

#pragma mark -
#pragma mark HotKey Actions

#define SPACE_KEYCODE 49
#define RIGHT_KEYCODE 124
#define PLUS_KEYCODE 24 //Shift?
#define MINUS_KEYCODE 27
#define UP_KEYCODE 126
#define DOWN_KEYCODE 125

- (void)playPauseKeyNotification {
    [self.webView keyClickWithKeyCode:SPACE_KEYCODE];
}

- (void)nextKeyNotification {
    [self.webView keyClickWithKeyCode:RIGHT_KEYCODE];
}

- (void)previousKeyNotification {
    //DLogFunc();
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [_statusItem release];
    [_webView release];
    [_statusMenu release];
    [_window release];
    [super dealloc];
}

@end

