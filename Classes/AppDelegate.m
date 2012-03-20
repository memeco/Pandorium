//
//  AppDelegate.m
//  Pandorium
//
//  Created by Gaurav Khanna on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#define PANDORA_EMBED_WIDTH     640.0
#define PANDORA_EMBED_HEIGHT    630.0

@implementation AppDelegate

@synthesize window = _window;
@synthesize statusMenu = _statusMenu;
@synthesize statusItem = _statusItem;
@synthesize webView = _webView;
@synthesize pandoraController = _pandoraController;
@synthesize prefWindow = _prefWindow;

#pragma mark -
#pragma mark Application Management

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_window setDelegate:self];
    
    PandoraController *aPandoraController = [[PandoraController alloc] initWithWebView:_webView];
    self.pandoraController = aPandoraController;
    
    [GKHotKeyController sharedController];
    
    //WebKitDeveloperExtras
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(playPauseKeyNotification) name:MediaKeyPlayPauseNotification object:nil];
    [center addObserver:self selector:@selector(nextKeyNotification) name:MediaKeyNextNotification object:nil];
    [center addObserver:self selector:@selector(previousKeyNotification) name:MediaKeyPreviousNotification object:nil];
    
    /*id scroller = [[_webView subviews] lastObject];
     unsigned int count;
     Method *method = class_copyMethodList([scroller class], &count);
     int i;
     for (i=0; i<count; i++) {
     if (strcmp(sel_getName(method_getName(method[i])), "setScrollingEnabled:") == 0)
     break;
     }
     IMP test = method_getImplementation(method[i]);
     test(scroller, @selector(setScrollingEnabled:), NO);*/
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

- (IBAction)activatePrefWindow:(id)sender {
    [self.prefWindow makeKeyAndOrderFront:NSApp];
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
    DLogFunc();
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



@end