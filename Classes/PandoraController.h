//
//  PandoraController.h
//  Pandorium
//
//  Created by Gaurav Khanna on 2/23/12.
//  Copyright (c) 2012 GK Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface PandoraController : NSObject

@property (nonatomic, strong) WebView *webView;

- (id)initWithWebView:(WebView*)aWebView;

@end
