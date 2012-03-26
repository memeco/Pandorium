//
//  PrefController.m
//  Pandorium
//
//  Created by Gaurav Khanna on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrefController.h"

@implementation PrefController

@synthesize prefWindow;
@synthesize userField;
@synthesize passField;
@synthesize logoutButton;
@synthesize login;

#pragma mark - Object life cycle

- (void)awakeFromNib {
    NSString *acct = [NSDef stringForKey:@"username"];
    self.login = acct ? TRUE : FALSE;
}

#pragma mark - Window life cycle

- (IBAction)activateWindow:(id)sender {
    //[self.prefWindow makeKeyAndOrderFront:NSApp];
    //[self.userbox becomeFirstResponder];
    [self.prefWindow orderFront:self];
    //[self.userbox becomeFirstResponder];
}

#pragma mark - Login management

#pragma mark NSTextField delegate methods
- (void)controlTextDidEndEditing:(NSNotification *)aNotification {
    // Fade out 
    // says information acquired
    NSString *username = self.userbox.stringValue;
    NSString *password = self.passbox.stringValue;
    DLogObject(username);
    DLogObject(password);
    if (!([username length] > 0 && [password length] > 0))
        return;
    [NSDef setObject:username forKey:@"username"];
    self.login = TRUE;
    // stores in keychain
    [SSKeychain setPassword:password forService:SERVICE_NAME account:username];
    
    //self.passbox.
    
    //[self.passbox unlockFocus];
    [self.userbox setEnabled:NO];
    [self.passbox setEnabled:NO];
    [self.passbox setHidden:TRUE withFade:TRUE delegate:self];
    /*[NSObject scheduleRunAfterDelay:.5 forBlock:^{
     [self.logoutButton setHidden:FALSE withFade:TRUE];
     }];*/
    
    // concurrent start moving window, and setup pandora window
}

#pragma mark NSAnimation delegate methods

- (void)animationDidEnd:(NSViewAnimation *)animation {
    NSDictionary *anims = [animation.viewAnimations objectAtIndex:0];
    id target = [anims objectForKey:NSViewAnimationTargetKey];
    if (target == self.passbox && self.logoutButton.isHidden) {
        [self.logoutButton setHidden:FALSE withFade:TRUE delegate:self];
    }
}

#pragma mark Logout button action

- (IBAction)logoutButtonActivation:(id)sender {
    
}


@end
