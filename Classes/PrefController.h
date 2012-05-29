//
//  PrefController.h
//  Pandorium
//
//  Created by Gaurav Khanna on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GKHotKeyView.h"
#import "HUDController.h"

@class SSKeychain, GKHotKeyView;

@interface PrefController : NSObject <NSAnimationDelegate, NSWindowDelegate>

@property (nonatomic, strong) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *userField;
@property (weak) IBOutlet NSSecureTextField *passField;
@property (weak) IBOutlet NSButton *logoutButton;

@property (weak) IBOutlet GKHotKeyView *showHideView;
@property (weak) IBOutlet GKHotKeyView *playPauseView;
@property (weak) IBOutlet GKHotKeyView *nextTrackView;
//@property (weak) IBOutlet GKHotKeyView *nextStationView;
@property (weak) IBOutlet GKHotKeyView *thumbsUpView;
@property (weak) IBOutlet GKHotKeyView *thumbsDownView;

@property (nonatomic, assign, getter=hasLogin) BOOL login;

@property (nonatomic, strong) GKHotKey *showHideKey;
@property (nonatomic, strong) GKHotKey *playPauseKey;
@property (nonatomic, strong) GKHotKey *nextTrackKey;
@property (nonatomic, strong) GKHotKey *thumbsUpKey;
@property (nonatomic, strong) GKHotKey *thumbsDownKey;

+ (NSString*)localStoragePath;
+ (NSString*)databasePath;

- (void)registerHotKeys;
- (IBAction)activateWindow:(id)sender;
- (IBAction)logoutButtonActivation:(id)sender;

@end
