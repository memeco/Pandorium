//
//  WebViewController.m
//  Pandorium
//
//  Created by Gaurav Khanna on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebController.h"

@interface WebPreferences (PRIVATE)

- (void)_setLocalStorageDatabasePath:(NSString*)str;
- (void)setLocalStorageEnabled:(BOOL)f1;

@end

@implementation WebController

@synthesize webView;

#pragma mark - NSWindow setup methods

- (void)setupWindowScrolling {
    WebFrame *mainFrame = [self.webView mainFrame];
    WebFrameView *frameView = [mainFrame frameView];
    for (id subview in frameView.subviews) {
        if ([subview isKindOfClass:$(WebDynamicScrollBarsView)]) {
            [subview setVerticalScrollElasticity:NSScrollElasticityNone];
            [subview setHorizontalScrollElasticity:NSScrollElasticityNone];
            [subview setAutohidesScrollers:YES];
            [[subview horizontalScroller] setScrollerStyle:NSScrollerStyleOverlay];
            [[subview verticalScroller] setScrollerStyle:NSScrollerStyleOverlay];
        }
    }
}

#pragma mark - Window life cycle

- (IBAction)activateWindow:(id)sender {
    if (!GKAppDelegate.window) {
        int width = 800;
        int height = 600;
        NSRect frame = NSMakeRect(0, 0, width, height);
        NSUInteger styleMask = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
        NSWindow *win = [[NSWindow alloc] initWithContentRect:frame styleMask:styleMask backing:NSBackingStoreBuffered defer:YES];
        win.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
        win.hidesOnDeactivate = FALSE;
        win.releasedWhenClosed = FALSE;
        win.autorecalculatesKeyViewLoop = FALSE;
        win.showsToolbarButton = FALSE;
        win.oneShot = FALSE;
        win.minSize = NSMakeSize(width, height);
        win.maxSize = NSMakeSize(width, height);
        win.delegate = self;
        win.title = @"Pandorium";
        win.allowsToolTipsWhenApplicationIsInactive = FALSE;
        
        WebView *webview = [[WebView alloc] initWithFrame:win.screen.visibleFrame];
        webview.autoresizesSubviews = TRUE;
        webview.autoresizingMask = NSViewNotSizable;
        webview.focusRingType = NSFocusRingTypeDefault;
        webview.wantsLayer = FALSE;
        webview.frameLoadDelegate = self;
        webview.resourceLoadDelegate = self;
        webview.policyDelegate = self;
        webview.shouldUpdateWhileOffscreen = TRUE;
        webview.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/534.53.11 (KHTML, like Gecko) Version/5.1.3 Safari/534.53.10";
        //webview.customUserAgent = @"Mozilla/5.0 (Windows NT 6.1; Intel Mac OS X 10.6; rv:7.0.1) Gecko/20100101 Firefox/7.0.1";
        webview.mainFrameURL = @"https://www.pandora.com/#/account/sign-in";
        
        WebPreferences* prefs = webview.preferences;
        [prefs _setLocalStorageDatabasePath:[PrefController localStoragePath]];
        [prefs setLocalStorageEnabled:YES];
        
        // center frame
        NSRect screenBox = win.screen.visibleFrame;
        frame.origin.y = screenBox.origin.y + truncf((screenBox.size.height - frame.size.height) / 2);
        frame.origin.x = screenBox.origin.x + truncf((screenBox.size.width - frame.size.width) / 2);    
        [win setFrame:frame display:FALSE animate:FALSE];
        
        win.contentView = webview;
        self.webView = webview;
        GKAppDelegate.window = win;
    }
    //[GKAppDelegate.window makeMainWindow];
    //[GKAppDelegate.window orderFront:self];
    //[self setupWindowScrolling];
    [GKAppDelegate.window makeKeyAndOrderFront:nil];
}

#pragma mark - NSWindow delegate methods

/*- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions {
   TODO: turn off clean.css 
}*/

- (void)windowWillClose:(NSNotification *)aNotification {
    //LOOK@: consider adding preference for this
    [NSApp terminate:self];
}

#pragma mark - WebViewFrameLoad delegate methods

/*- (void)webView:(WebView *)sender didReceiveServerRedirectForProvisionalLoadForFrame:(WebFrame *)frame {
    //DLogObject(frame);
    //DLogFunc();
}*/
#ifdef IDEA
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
//    DLogObject(frame.name);
//    DLogFunc();
//    DLogObject(frame.DOMDocument.title);
    
    if ([frame.name isEqualToString:@"google_adwords_frame"]) {
        NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"css"];
        NSString *css = [NSString stringWithContentsOfFile:cssPath encoding:NSUTF8StringEncoding error:nil];
        NSString *safeCSS = [css stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"js"];
        NSString *js = [NSString stringWithContentsOfFile:splashPath encoding:NSUTF8StringEncoding error:nil];
        NSString *finalJS = [js stringByReplacingOccurrencesOfString:@"%%CSS%%" withString:safeCSS];
        
        //DStart(1);
        //[self.webView stringByEvaluatingJavaScriptFromString:finalJS];
        
    }

    /*if ([frame.name isEqualToString:@""]) {
        
    }*/
    
    /*if ([[frame.DOMDocument.title componentsSeparatedByString:@"Pandora"] count] > 1) {
        [NSObject scheduleRunAfterDelay:2.0 forBlock:^{
            [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('email')[0].focus();"];
        }];
    }*/
}
#endif
/*- (void)webView:(WebView *)sender willPerformClientRedirectToURL:(NSURL *)URL delay:(NSTimeInterval)seconds fireDate:(NSDate *)date forFrame:(WebFrame *)frame {
    //DLogObject(URL);
    //DLogINT(seconds);
    //DLogFunc();
}

- (void)webView:(WebView *)sender didCancelClientRedirectForFrame:(WebFrame *)frame {
    //DLogFunc();
}*/

#pragma mark - WebViewResourceLoad delegate methods

- (id)webView:(WebView *)sender identifierForInitialRequest:(NSURLRequest *)request fromDataSource:(WebDataSource *)dataSource {
    [self setupWindowScrolling];
    //DLogObject(request.URL.description);
    
    /*if ([request.URL.description isEqualToString:@"https://www.pandora.com/#/account/sign-in"]) {
        return @"InitialPage";
    }
    
    if ([[request.URL.description componentsSeparatedByString:@"script.combined.js"] count]) {
        //return @"SplashPage";
    }
    
    if ([[request.URL.description componentsSeparatedByString:@"compiled.css"] count] > 1) {
        //return @"SplashPage";
    }
    
    if ([request.URL.description isEqualToString:@"https://www.pandora.com/img/player-controls/progress-middle.png"]) {
        //return @"InitialPage";
    }*/
    
    // trigger login page style
    if ([request.URL.description isEqualToString:@"about:blank"]) {
        
#ifdef IDEA
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"js"];
        NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"css"];
        NSString *cleancss = [NSString stringWithContentsOfFile:cssPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *escapedcss = [cleancss stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSString *jsfinal = [js stringByReplacingOccurrencesOfString:@"%%CSS%%" withString:escapedcss];
        
        [self.webView stringByEvaluatingJavaScriptFromString:jsfinal];
#endif
#ifdef MANUAL_SIGNIN
        NSString *signinPath = [[NSBundle mainBundle] pathForResource:@"signin" ofType:@"js"];
        NSString *signinJS = [NSString stringWithContentsOfFile:signinPath encoding:NSUTF8StringEncoding error:nil];
        NSString *username = [NSDef stringForKey:@"username"];
        NSString *password = [SSKeychain passwordForService:SERVICE_NAME account:username];
        NSString *userMod = [signinJS stringByReplacingOccurrencesOfString:@"%%USERNAME%%" withString:username];
        NSString *passMod = [userMod stringByReplacingOccurrencesOfString:@"%%PASSWORD%%" withString:password];
        [self.webView stringByEvaluatingJavaScriptFromString:passMod];
#endif
    }
    
    // trigger logged-in style
    if (([request.URL.description hasPrefix:@"https://www.pandora.com/radio/xmlrpc"] 
        && [request.URL.description hasSuffix:@"createListener"]) 
        || [request.URL.description hasPrefix:@"http://www.pandora.com/radio/jsonp"]) {
//        NSString *rsplashJSPath = [[NSBundle mainBundle] pathForResource:@"rsplash" ofType:@"js"];
//        NSString *rsplashjs = [NSString stringWithContentsOfFile:rsplashJSPath encoding:NSUTF8StringEncoding error:nil];
//        [self.webView stringByEvaluatingJavaScriptFromString:rsplashjs];
        
        NSString *mainJSPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
        NSString *mainjs = [NSString stringWithContentsOfFile:mainJSPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *mainCSSPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"css"];
        NSString *maincss = [NSString stringWithContentsOfFile:mainCSSPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *escapedcss = [maincss stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSString *jsfinal = [mainjs stringByReplacingOccurrencesOfString:@"%%CSS%%" withString:escapedcss];
        
        [self.webView stringByEvaluatingJavaScriptFromString:jsfinal];
//#ifdef IDEA
//        NSRect box = NSMakeRect(0, 0, 800, 600);
//        NSRect screenBox = GKAppDelegate.window.screen.visibleFrame;
//        box.origin.y = screenBox.origin.y + truncf((screenBox.size.height - box.size.height) / 2);
//        box.origin.x = screenBox.origin.x + truncf((screenBox.size.width - box.size.width) / 2);
//        [GKAppDelegate.window setFrame:box display:YES animate:YES];
//#endif
    }
    return nil;
}

/*- (NSURLRequest *)webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource {
    //DLogObject(redirectResponse.URL);
    return request;
    
}

- (void)webView:(WebView *)sender resource:(id)identifier didReceiveResponse:(NSURLResponse *)response fromDataSource:(WebDataSource *)dataSource { 
    //DLogObject(response.URL);
}*/

//- (void)webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource {
//    /*if ([identifier isEqualToString:@"InitialPage"]) { // adjusts splash in signup window size
//     NSString *cleanJSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"js"];
//     NSString *cleanjs = [NSString stringWithContentsOfFile:cleanJSPath encoding:NSUTF8StringEncoding error:nil];
//     
//     NSString *cleanCSSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"css"];
//     NSString *cleancss = [NSString stringWithContentsOfFile:cleanCSSPath encoding:NSUTF8StringEncoding error:nil];
//     
//     NSString *escapedcss = [cleancss stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
//     NSString *jsfinal = [cleanjs stringByReplacingOccurrencesOfString:@"%%CSS%%" withString:escapedcss];
//     
//     NSString *str3 = [sender stringByEvaluatingJavaScriptFromString:jsfinal];
//     //DLogObject(str3);
//     }*/
//    
//    if ([identifier isEqualToString:@"SplashPage"] && GKAppDelegate.prefController.hasLogin) { // disables splash fade away
////        NSString *splashCSSPath = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"css"];
////        NSString *splashCSS = [NSString stringWithContentsOfFile:splashCSSPath encoding:NSUTF8StringEncoding error:nil];
////        NSString *safeCSS = [splashCSS stringByReplacingOccurrencesOfString:@"\n" withString:@""];
////        
////        NSString *splashPath = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"js"];
////        NSString *splashJS = [NSString stringWithContentsOfFile:splashPath encoding:NSUTF8StringEncoding error:nil];
////        NSString *finalJS = [splashJS stringByReplacingOccurrencesOfString:@"%%CSS%%" withString:safeCSS];
////        
////        //DStart(1);
////        NSString *str = [self.webView stringByEvaluatingJavaScriptFromString:finalJS];
//        //DLogObject(str);
//        //DEnd(1);
//    }
//    
//    if ([identifier isEqualToString:@"SigninPage"] && GKAppDelegate.prefController.hasLogin) { // enters login information
//        
//    }
//    
//    //LOG_NETWORK(1, @"aURL: %@", dataSource.request.URL);
//    //NSString *cleanJSPath = [[NSBundle mainBundle] pathForResource:@"clean" ofType:@"js"];
//    //NSString *cleanjs = [NSString stringWithContentsOfFile:cleanJSPath encoding:NSUTF8StringEncoding error:nil];
//    //[sender stringByEvaluatingJavaScriptFromString:cleanjs];
//    
//    
//    
//    
//    //DLogObject(dataSource.request.URL);
//    /*[webView stringByEvaluatingJavaScriptFromString:@"                                                      \
//     if(document.getElementById('pandoriumStyle') == null) {                                            \
//     var style = document.createElement('style');                                                   \
//     style.setAttribute('id','pandoriumStyle');                                                     \
//     style.innerHTML = '#footer {display:none !important;}                                          \
//     #container {height:661px;left:-44px;top:-27px;width:683px;}                 \
//     #enhanced_skin_container {display:none;}                                    \
//     body {background:none !important;}                                          \
//     #advertisement {display:none !important;}                                   \
//     html {overflow: hidden;}                                                    \
//     ';                                                                           \
//     document.body.appendChild(style);                                                              \
//     }                                                                                                  \
//     "];*/
//    //[webView stringByEvaluatingJavaScriptFromString:@" \
//    document.getElementsByName('email')[0].value = 'gauravk92@gmail.com'; \
//    document.getElementsByName('password')[0].value = 'DnjjNe8G2bgHDo'; \
//    document.forms[0].submit(); \
//    "];
//    //DLogObject(dataSource.request.URL);
//}

#pragma mark - WebViewPolicy delegate methods

- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener {
    NSURL *url = [request URL];
    NSString *str = [url absoluteString];
    //DLogObject(url);
    if ([url.host hasSuffix:@"pandora.com"] || url.host.length == 0) {
        if ([str hasPrefix:@"https://www.pandora.com/#!/music"] ||
            [str hasPrefix:@"https://www.pandora.com/#/stations/edit"] ||
            [str hasPrefix:@"https://www.pandora.com/#!/stations/edit"] ||
            [str hasPrefix:@"https://www.pandora.com/#!/genres"]) {
            [listener ignore];
            //[NSApp openURL:url];
            return;
        }
        [listener use];
        return;
    }
    [listener ignore];
}

@end
