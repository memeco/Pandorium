//
//  PandoraController.m
//  Pandorium
//
//  Created by Gaurav Khanna on 2/23/12.
//  Copyright (c) 2012 GK Apps. All rights reserved.
//

#import "PandoraController.h"

@implementation PandoraController

@synthesize webView;

- (id)initWithWebView:(WebView*)aWebView {
    self = [super init];
    if (self) {
        self.webView = aWebView;
        [self.webView setMainFrameURL:@"https://www.pandora.com/#/account/sign-in"];
        [self.webView setFrameLoadDelegate:self];
        [self.webView setResourceLoadDelegate:self];
        [self.webView setShouldUpdateWhileOffscreen:TRUE];
    }
    return self;
}

#pragma mark -
#pragma mark WebView delegate Methods

- (id)webView:(WebView *)sender identifierForInitialRequest:(NSURLRequest *)request fromDataSource:(WebDataSource *)dataSource {
    
    if ([request.URL.description isEqualToString:@"about:blank"]) {
        //DLogObject(request.URL);
        //DLogObject(dataSource.request.URL);
        NSString *controlJSPath = [[NSBundle mainBundle] pathForResource:@"signin" ofType:@"js"];
        NSString *contjs = [NSString stringWithContentsOfFile:controlJSPath encoding:NSUTF8StringEncoding error:nil];
        [sender stringByEvaluatingJavaScriptFromString:contjs];
    }
    
    //LOG_NETWORK(1, @"aURL: %@", request.URL.description);
    
    if ([request.URL.description hasPrefix:@"https://www.pandora.com/radio/xmlrpc"] && [request.URL.description hasSuffix:@"createListener"]) {
        //DLogObject(request.URL);
        //DLogFunc();
        LOG_GENERAL(0, @"main page detected %@", request.URL);
        
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
    
    
    LOG_NETWORK(1, @"aURL: %@", dataSource.request.URL);
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

@end
