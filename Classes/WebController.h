//
//  WebViewController.h
//  Pandorium
//
//  Created by Gaurav Khanna on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "WebView+GKAdditions.h"

@class SSKeychain;

@interface WebController : NSObject <NSWindowDelegate>

@property (nonatomic, strong) WebView *webView;

- (IBAction)activateWindow:(id)sender;

@end
