//
//  AppDelegate.h
//  Pandorium
//
//  Created by Gaurav Khanna on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet WebView *webView;
@property (nonatomic, strong) IBOutlet NSMenu *statusMenu;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) PandoraController *pandoraController;
@property (nonatomic, strong) IBOutlet NSWindow *prefWindow;

- (IBAction)showPandorium:(id)sender;
- (IBAction)quitPandorium:(id)sender;
- (IBAction)activatePrefWindow:(id)sender;

@end
