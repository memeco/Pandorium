//
//  AppDelegate.m
//  Pandorium
//
//  Created by Gaurav Khanna on 2/23/12.
//  Copyright (c) 2012 Gaurav Khanna. All rights reserved.
//
//  This file is part of Pandorium.
//
//  Pandorium is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Pandorium is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Pandorium.  If not, see <http://www.gnu.org/licenses/>.
//

#import "AppDelegate.h"

//#define PANDORA_EMBED_WIDTH     640.0
//#define PANDORA_EMBED_HEIGHT    630.0

// w=799 h=903
// w=582 h=373 -- signup
// w=582 h=361

@implementation AppDelegate

@synthesize window;
@synthesize webView;
//@synthesize statusMenu = _statusMenu;
@synthesize prefWindow;

#pragma mark - Application life cycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // TODO: Detect and auto ask for password to fix problem...no need to ask
    //[GKHotKeyCenter sharedCenter];
    
    // 1. Detect event taps possibility
    //      if false, then use a-scpt to enable with HUD message describing why
    
    // 2. Detect state of account info storage, build appropriate frame
    //      if false, -> signup size
    //      if true,  -> start with window normal size
    
    NSString *acct = [NSDef stringForKey:@"username"];
    
    BOOL hasLogin = acct ? TRUE : /*FALSE*/ TRUE;
    NSRect frame = hasLogin ? NSMakeRect(0, 0, 799, 600) : NSMakeRect(0, 0, 582, 361);
    
    NSUInteger styleMask = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
    NSWindow *win = [[NSWindow alloc] initWithContentRect:frame styleMask:styleMask backing:NSBackingStoreBuffered defer:YES];
    win.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
    win.hidesOnDeactivate = FALSE;
    win.releasedWhenClosed = FALSE;
    win.autorecalculatesKeyViewLoop = FALSE;
    win.showsToolbarButton = FALSE;
    win.oneShot = FALSE;
    win.allowsToolTipsWhenApplicationIsInactive = FALSE;

    WebView *webview = [[WebView alloc] initWithFrame:self.window.screen.visibleFrame];
    webview.autoresizesSubviews = TRUE;
    webview.autoresizingMask = NSViewNotSizable;
    webview.focusRingType = NSFocusRingTypeDefault;
    webview.wantsLayer = FALSE;
    webview.resourceLoadDelegate = self;
    webview.shouldUpdateWhileOffscreen = TRUE;
    webview.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) \
     AppleWebKit/534.53.11 (KHTML, like Gecko) Version/5.1.3 Safari/534.53.10";
    webview.mainFrameURL = @"https://www.pandora.com/#/account/sign-in";

    NSRect screenBox = win.screen.visibleFrame;
    frame.origin.y = screenBox.origin.y + truncf((screenBox.size.height - frame.size.height) / 2);
    frame.origin.x = screenBox.origin.x + truncf((screenBox.size.width - frame.size.width) / 2);    
    [win setFrame:frame display:FALSE animate:FALSE];

    win.contentView = webview;
    [win orderFront:self];
    self.window = win;
    self.webView = webview;
    

    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //[center addObserver:self selector:@selector(playPauseKeyNotification) name:MediaKeyPlayPauseNotification object:nil];
    //[center addObserver:self selector:@selector(nextKeyNotification) name:MediaKeyNextNotification object:nil];
    //[center addObserver:self selector:@selector(previousKeyNotification) name:MediaKeyPreviousNotification object:nil];
    
    //DLogObject([SSKeychain allAccounts]);
    
    /*
    NSString *acct = [NSDef stringForKey:@"username"];
    if (!acct) {
        // ight load up signup page
        return;
    }
    
    NSString *pw = [SSKeychain passwordForService:@GLOBAL_SERVICE_NAME account:acct];
    if (!pw) {
        //signup pg
        return;
    }
    */
    
    // Actually perform signup, of previously stored data
}

-(void)awakeFromNib{
//    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
//    [_statusItem setMenu:_statusMenu];
//    [_statusItem setImage:[NSImage imageNamed:@"status_icon"]];
//    [_statusItem setAlternateImage:[NSImage imageNamed:@"status_icon_highlighted"]];
//    [_statusItem setHighlightMode:YES];
    
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
    //[self.prefWindow makeKeyAndOrderFront:NSApp];
    [self.prefWindow orderFront:self];
}

#pragma mark - WebView delegate Methods

- (id)webView:(WebView *)sender identifierForInitialRequest:(NSURLRequest *)request fromDataSource:(WebDataSource *)dataSource {
    DLogObject(request.URL.description);
    
    if ([request.URL.description isEqualToString:@"https://www.pandora.com/#/account/sign-in"]) {
        NSString *cleanJSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"js"];
        NSString *cleanjs = [NSString stringWithContentsOfFile:cleanJSPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *cleanCSSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"css"];
        NSString *cleancss = [NSString stringWithContentsOfFile:cleanCSSPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *escapedcss = [cleancss stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSString *jsfinal = [cleanjs stringByReplacingOccurrencesOfString:@"%%CLEANCSS%%" withString:escapedcss];
        
        [sender stringByEvaluatingJavaScriptFromString:jsfinal];
    }
    
    if ([request.URL.description isEqualToString:@"about:blank"]) {
//        DLogObject(request.URL);
//        DLogObject(dataSource.request.URL);
//        NSString *controlJSPath = [[NSBundle mainBundle] pathForResource:@"signin" ofType:@"js"];
//        NSString *contjs = [NSString stringWithContentsOfFile:controlJSPath encoding:NSUTF8StringEncoding error:nil];
//        [sender stringByEvaluatingJavaScriptFromString:contjs];
        
        WebFrame *mainFrame = [self.webView mainFrame];
            WebFrameView *frameView = [mainFrame frameView];
            for (id subview in frameView.subviews)
                if ([subview isKindOfClass:$(WebDynamicScrollBarsView)])
                    [subview setVerticalScrollElasticity:NSScrollElasticityNone];
        
        
    }
    
    //LOG_NETWORK(1, @"aURL: %@", request.URL.description);
    
    if ([request.URL.description hasPrefix:@"https://www.pandora.com/radio/xmlrpc"] 
        && [request.URL.description hasSuffix:@"createListener"]) {
//        DLogObject(request.URL);
//        DLogFunc();
//        LOG_GENERAL(0, @"main page detected %@", request.URL);
        
        //float delta = ... how much to make the window bigger or smaller ...;
//        NSRect frame = [window frame];
//        
//        int w = 799;
//        int h = 650;
//        
//        //frame.origin.y -= delta;
//        //frame.size.height += delta;
//        frame.origin.y -= (h-frame.size.height)/2;
//        frame.origin.x -= (w-frame.size.width)/2;
//        frame.size.height = h;
//        frame.size.width = w;
//        
//        [window setFrame:frame display:YES animate:YES];
        
        NSRect box = self.window.frame;
        DLogNSRect(box);
        NSRect screenBox = self.window.screen.visibleFrame;
        
        box.origin.y = screenBox.origin.y + truncf((screenBox.size.height - box.size.height) / 2);
        box.origin.x = screenBox.origin.x + truncf((screenBox.size.width - box.size.width) / 2);
        [self.window setFrame:box display:NO animate:YES];
        
        NSString *cleanJSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"js"];
        NSString *cleanjs = [NSString stringWithContentsOfFile:cleanJSPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *cleanCSSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"css"];
        NSString *cleancss = [NSString stringWithContentsOfFile:cleanCSSPath encoding:NSUTF8StringEncoding error:nil];

        NSString *escapedcss = [cleancss stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSString *jsfinal = [cleanjs stringByReplacingOccurrencesOfString:@"%%CLEANCSS%%" withString:escapedcss];
        
        [sender stringByEvaluatingJavaScriptFromString:jsfinal];
        
    }
    //DLogObject(request.URL);
    return nil;
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    
    self.webView.mainFrame.frameView.documentView.enclosingScrollView.horizontalScrollElasticity = NSScrollElasticityNone;
    self.webView.mainFrame.frameView.documentView.enclosingScrollView.verticalScrollElasticity   = NSScrollElasticityNone;
}

- (NSURLRequest *)webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource {
    //DLogObject(redirectResponse.URL);
    return request;
    
}

- (void)webView:(WebView *)sender resource:(id)identifier didReceiveResponse:(NSURLResponse *)response fromDataSource:(WebDataSource *)dataSource { 
    //DLogObject(response.URL);
}

- (void)webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource {
    
    
    //LOG_NETWORK(1, @"aURL: %@", dataSource.request.URL);
    //NSString *cleanJSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"js"];
    //NSString *cleanjs = [NSString stringWithContentsOfFile:cleanJSPath encoding:NSUTF8StringEncoding error:nil];
    //[sender stringByEvaluatingJavaScriptFromString:cleanjs];
    
    
    
    
    //DLogObject(dataSource.request.URL);
    /*[webView stringByEvaluatingJavaScriptFromString:@"                                                      \
     if(document.getElementById('pandoriumStyle') == null) {                                            \
     var style = document.createElement('style');                                                   \
     style.setAttribute('id','pandoriumStyle');                                                     \
     style.innerHTML = '#footer {display:none !important;}                                          \
     #container {height:661px;left:-44px;top:-27px;width:683px;}                 \
     #enhanced_skin_container {display:none;}                                    \
     body {background:none !important;}                                          \
     #advertisement {display:none !important;}                                   \
     html {overflow: hidden;}                                                    \
     ';                                                                           \
     document.body.appendChild(style);                                                              \
     }                                                                                                  \
     "];*/
    //[webView stringByEvaluatingJavaScriptFromString:@" \
    document.getElementsByName('email')[0].value = 'gauravk92@gmail.com'; \
    document.getElementsByName('password')[0].value = 'DnjjNe8G2bgHDo'; \
    document.forms[0].submit(); \
    "];
    //DLogObject(dataSource.request.URL);
}

#pragma mark - HotKey Actions

- (void)playPauseKeyNotification {
#define SPACE_KEYCODE 49
#define RIGHT_KEYCODE 124
#define PLUS_KEYCODE 24 //Shift?
#define MINUS_KEYCODE 27
#define UP_KEYCODE 126
#define DOWN_KEYCODE 125
    DLogFunc();
    //[self.webView keyClickWithKeyCode:SPACE_KEYCODE];
}

- (void)nextKeyNotification {
    //[self.webView keyClickWithKeyCode:RIGHT_KEYCODE];
}

- (void)previousKeyNotification {
    //DLogFunc();
}

@end
