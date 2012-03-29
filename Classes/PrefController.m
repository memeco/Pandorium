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

+ (NSString*)databasePath {
    return [@"~/Library/Application Support/Pandorium" stringByExpandingTildeInPath];
}

- (void)awakeFromNib {
    NSString *defPath = [[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"];
    NSDictionary *defDict = [NSDictionary dictionaryWithContentsOfFile:defPath];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defDict];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(hotKeyViewChange:) name:@"GKHotKeyViewChangeNotification" object:nil];
    
//#ifdef IDEA
    NSError *err;
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[PrefController databasePath] error:&err];
    if (err) {
        // handle failure
        return;
    }
    self.login = [arr count] > 3;
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
    [self.window orderFront:self];
    [self.window makeKeyAndOrderFront:nil];
}

#pragma mark - NSWindow delegate methods

- (void)windowDidBecomeMain:(NSNotification *)notification {
    [self.userField becomeFirstResponder];
}

#pragma mark - Login management

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
