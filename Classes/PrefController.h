//
//  PrefController.h
//  Pandorium
//
//  Created by Gaurav Khanna on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GKHotKeyView.h"

@class SSKeychain, GKHotKeyView;

@interface PrefController : NSObject <NSAnimationDelegate>

@property (nonatomic, strong) IBOutlet NSWindow *prefWindow;
@property (weak) IBOutlet NSTextField *userField;
@property (weak) IBOutlet NSSecureTextField *passField;
@property (weak) IBOutlet NSButton *logoutButton;

@property (nonatomic, assign, getter=hasLogin) BOOL login;

- (IBAction)activateWindow:(id)sender;
- (IBAction)logoutButtonActivation:(id)sender;

- (void)detectLoginAndSetupStartupWindow;

@end
