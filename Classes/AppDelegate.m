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

@implementation AppDelegate

@synthesize window;
@synthesize webController;
@synthesize prefController;

#pragma mark - Application life cycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
#ifdef DEBUG
    [NSDef registerDefaults:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"WebKitDeveloperExtras"]];
#endif
    
    
    // TODO: Detect and auto ask for password to fix problem...no need to ask
    [GKHotKeyCenter sharedCenter];
    
    // 1. Detect event taps possibility
    //      if false, then use a-scpt to enable with HUD message describing why
    
    // 2. Detect state of account info storage, build appropriate frame
    //      if false, -> signup size
    //      if true,  -> start with window normal size
#if DEBUG
    [NSDef setObject:nil forKey:@"username"];
#endif
    
    if (self.prefController.hasLogin) {
        [self.webController activateWindow:nil];
    } else {
        [self.prefController activateWindow:nil];
    }
    
    
    
    
    
    //NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
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

/*-(void)awakeFromNib{
//    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
//    [_statusItem setMenu:_statusMenu];
//    [_statusItem setImage:[NSImage imageNamed:@"status_icon"]];
//    [_statusItem setAlternateImage:[NSImage imageNamed:@"status_icon_highlighted"]];
//    [_statusItem setHighlightMode:YES];
    DLogFunc();
    
}*/

/*- (IBAction)showPandorium:(id)sender {
    //FIXME: [window makeKeyAndOrderFront:self] doesn't work here for some reason
    [NSApp activateIgnoringOtherApps:TRUE];
}

- (IBAction)quitPandorium:(id)sender {
    [NSApp terminate:self];
}*/

- (void)windowWillClose:(NSNotification *)aNotification {
    //LOOK@: consider adding preference for this
    [NSApp terminate:self];
}

#pragma mark - Preference window delegate methods


#pragma mark - HotKey Actions

- (void)playPauseKeyNotification {
#define SPACE_KEYCODE 49
#define RIGHT_KEYCODE 124
#define PLUS_KEYCODE 24 //Shift?
#define MINUS_KEYCODE 27
#define UP_KEYCODE 126
#define DOWN_KEYCODE 125
    //DLogFunc();
    //[self.webView keyClickWithKeyCode:SPACE_KEYCODE];
}

- (void)nextKeyNotification {
    //[self.webView keyClickWithKeyCode:RIGHT_KEYCODE];
}

- (void)previousKeyNotification {
    //DLogFunc();
}

@end
