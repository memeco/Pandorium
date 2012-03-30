//
//  PrefController.m
//  Pandorium
//
//  Created by Gaurav Khanna on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrefController.h"

@implementation PrefController

@synthesize window;
@synthesize userField;
@synthesize passField;
@synthesize logoutButton;
@synthesize showHideView;
@synthesize playPauseView;
@synthesize nextTrackView;
//@synthesize nextStationView;
@synthesize thumbsUpView;
@synthesize thumbsDownView;
@synthesize login;

#pragma mark - Object life cycle

+ (NSString*)localStoragePath {
    return [@"~/Library/Application Support/Pandorium" stringByExpandingTildeInPath];
}

+ (NSString*)databasePath {
    return [[PrefController localStoragePath] stringByAppendingString:@"/https_www.pandora.com_0.localstorage"];
}

+ (int)loginStorageLength {
    return 415;
}

- (void)awakeFromNib {
    NSString *defPath = [[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"];
    NSDictionary *defDict = [NSDictionary dictionaryWithContentsOfFile:defPath];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defDict];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(hotKeyViewChange:) name:@"GKHotKeyViewChangeNotification" object:nil];
    
//#ifdef IDEA
    
//    if ([[[NSFileManager defaultManager] subpathsAtPath:[PrefController databasePath]] count] > 0) {
//        // logged in
        // for all the files in dir
        DLogFunc();
        // check
        //isDeletableFileAtPath:
        
        //remove
        //- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error
//    } else {
//        // not
//        DLogFunc();
//    }
//#else
//    NSString *acct = [NSDef objectForKey:@"username"];
//    self.login = acct ? TRUE : FALSE;
//#endif
    
    /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *archiveLocation = [documentsDirectory stringByAppendingPathComponent:@"My.ar"];
    
    GKHotKey *test = [[GKHotKey alloc] initWithKeyCode:49 modifierFlags:195];
    BOOL val = [NSKeyedArchiver archiveRootObject:test toFile:archiveLocation];*/
    
    // TODO: mad refactoring
    GKHotKey *showHide = [NSKeyedUnarchiver unarchiveObjectWithData:[NSDef objectForKey:@"showHideKey"]];
    GKHotKey *playPause = [NSKeyedUnarchiver unarchiveObjectWithData:[NSDef objectForKey:@"playPauseKey"]];
    GKHotKey *nextTrack = [NSKeyedUnarchiver unarchiveObjectWithData:[NSDef objectForKey:@"nextTrackKey"]];
    //GKHotKey *nextStation = [NSKeyedUnarchiver unarchiveObjectWithData:[NSDef objectForKey:@"nextStationKey"]];
    GKHotKey *thumbsUp = [NSKeyedUnarchiver unarchiveObjectWithData:[NSDef objectForKey:@"thumbsUpKey"]];
    GKHotKey *thumbsDown = [NSKeyedUnarchiver unarchiveObjectWithData:[NSDef objectForKey:@"thumbsDownKey"]];
    
    if (showHide)
        self.showHideView.hotkey = showHide;
    if (playPause)
        self.playPauseView.hotkey = playPause;
    if (nextTrack)
        self.nextTrackView.hotkey = nextTrack;
    //if (nextStation)
    //    self.nextStationView.hotkey = nextStation;
    if (thumbsUp)
        self.thumbsUpView.hotkey = thumbsUp;
    if (thumbsDown)
        self.thumbsDownView.hotkey = thumbsDown;
}

#pragma mark - NSWindow life cycle

- (IBAction)activateWindow:(id)sender {
    NSString *path = [PrefController databasePath];
    sqlite3 *db;
    BOOL log;
    if ([NSMgr fileExistsAtPath:path]) {
        if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
            const char *sql = [@"SELECT * FROM \"ItemTable\" WHERE key='jStorage'" UTF8String];
            sqlite3_stmt *statement;
            int bytes;
            
            if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) == SQLITE_OK) {
                int result = sqlite3_step(statement);
                if (result == SQLITE_ROW) {
                    sqlite3_column_text(statement, 1);
                    bytes = sqlite3_column_bytes(statement, 1);
                    log = bytes > [PrefController loginStorageLength];
                } else
                    log = NO;
            }
            sqlite3_finalize(statement);
        } else {
            // TODO: failure, delete and try again
        }
    } else
        log = NO;
    sqlite3_close(db);
    
    self.login = log;
    self.logoutButton.enabled = log;
    [self.window makeKeyAndOrderFront:nil];
}

#pragma mark - NSWindow delegate methods

- (void)windowDidBecomeMain:(NSNotification *)notification {
    [self.userField becomeFirstResponder];
}

#ifndef LOGIN

#pragma mark - Login management

- (IBAction)logoutButtonActivation:(id)sender {
    NSString *path = [PrefController localStoragePath];
    if ([NSMgr fileExistsAtPath:path] && [NSMgr isDeletableFileAtPath:path]) {
        NSError *err;
        [NSMgr removeItemAtPath:path error:&err];
        if (err) {
            // TODO: maybe alert an error occured
        }
    }
    [GKAppDelegate.webController.webView reloadFromOrigin:nil];
}

#else

#pragma mark NSTextField delegate methods (login)
- (void)controlTextDidEndEditing:(NSNotification *)aNotification {
    NSString *username = self.userField.stringValue;
    NSString *password = self.passField.stringValue;
    
    if (!([username length] && [password length]))
        return;
    
    [NSDef setObject:username forKey:@"username"];
    [SSKeychain setPassword:password forService:SERVICE_NAME account:username];
    self.login = TRUE;

    [self.userField setEnabled:NO];
    [self.passField setEnabled:NO];
    [self.passField setHidden:TRUE withFade:TRUE delegate:self];
    
    // TODO: concurrent start moving window, and setup pandora window
    
    /*NSDictionary *fadeWindow = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.window, NSViewAnimationTargetKey,
                                NSViewAnimationFadeOutEffect, NSViewAnimationEffectKey,
                                nil];
    
    NSRect frm = NSMakeRect(0, 0, 500, 300);
    NSDictionary *resizeWindow = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.window, NSViewAnimationTargetKey,
                                  [NSValue valueWithRect:frm], NSViewAnimationEndFrameKey,
                                  nil];
    
    NSArray *animations;
    animations = [NSArray arrayWithObjects: fadeWindow, resizeWindow, nil];
    
    NSViewAnimation *animation;
    animation = [[NSViewAnimation alloc] initWithViewAnimations: animations];
    
    [animation setAnimationBlockingMode: NSAnimationBlocking];
    [animation setDuration: 3];
    
    [animation startAnimation];*/
    
    [GKAppDelegate.webController activateWindow:nil];
    
    NSRect startFrame = self.window.frame;
    NSRect frame = startFrame;
    int newWindowWidth = GKAppDelegate.window.frame.size.width;
    int spacing = 15;
    frame.origin.x = startFrame.origin.x - round(startFrame.size.width/2) - (spacing + round(newWindowWidth/2));
    
    NSDictionary *resize = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.window, NSViewAnimationTargetKey,
                            [NSValue valueWithRect:frame], NSViewAnimationEndFrameKey, nil];
    
    NSArray *anims = [NSArray arrayWithObject:resize];
    
    NSViewAnimation *vAnim = [[NSViewAnimation alloc] initWithViewAnimations:anims];
    
    [vAnim setAnimationBlockingMode:NSAnimationNonblocking];
    [vAnim setAnimationCurve:NSAnimationEaseInOut];
    [vAnim setDuration:.5];
    [vAnim startAnimation];
    [self.window makeKeyAndOrderFront:nil];
}

#pragma mark Logout button action
- (IBAction)logoutButtonActivation:(id)sender {
    NSString *username = [NSDef objectForKey:@"username"];
    
    [SSKeychain deletePasswordForService:SERVICE_NAME account:username];
    [NSDef setObject:@"" forKey:@"username"];
    self.login = FALSE;
    
    [self.userField setEnabled:YES];
    [self.passField setEnabled:YES];
    [self.logoutButton setHidden:TRUE withFade:TRUE delegate:self];
}

#pragma mark NSAnimation delegate methods

- (void)animationDidEnd:(NSViewAnimation *)animation {
    NSDictionary *anims = [animation.viewAnimations objectAtIndex:0];
    id target = [anims objectForKey:NSViewAnimationTargetKey];
    
    if (target == self.passField && self.logoutButton.isHidden 
        && [anims objectForKey:NSViewAnimationEffectKey] == NSViewAnimationFadeOutEffect) { 
        [self.logoutButton setHidden:FALSE withFade:TRUE delegate:self];
        return;
    }
    if (target == self.logoutButton && self.passField.isHidden 
        && [anims objectForKey:NSViewAnimationEffectKey] == NSViewAnimationFadeOutEffect) {
        [self.passField setHidden:FALSE withFade:TRUE delegate:self];
        return;
    }
}
#endif

#pragma mark - GKHotKey change notification

- (void)anonConv:(NSString*)str view:(GKHotKeyView*)view {
    if (view.hotkey)
        [NSDef setObject:[NSKeyedArchiver archivedDataWithRootObject:view.hotkey] forKey:str];
    else
        [NSDef removeObjectForKey:str];
}

- (void)hotKeyViewChange:(NSNotification*)notif {
    GKHotKeyView *view = notif.object;
    if ([view isEqual:self.showHideView]) {
        [self anonConv:@"showHideKey" view:view];
    }
    if ([view isEqual:self.playPauseView]) {
        [self anonConv:@"playPauseKey" view:view];
    }
    if ([view isEqual:self.nextTrackView]) {
        [self anonConv:@"nextTrackKey" view:view];
    }
    //if ([view isEqual:self.nextStationView]) {
    //    [NSDef setObject:[NSKeyedArchiver archivedDataWithRootObject:view.hotkey] forKey:@"nextStationKey"];
    //}
    if ([view isEqual:self.thumbsUpView]) {
        [self anonConv:@"thumbsUpKey" view:view];
    }
    if ([view isEqual:self.thumbsDownView]) {
        [self anonConv:@"thumbsDownKey" view:view];
    }
}

@end
