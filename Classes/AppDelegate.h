//
//  AppDelegate.h
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

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "WebView+GKAdditions.h"
#import "SSKeychain.h"

#define GLOBAL_SERVICE_NAME "com.gkapps.Pandorium"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (nonatomic, strong) NSWindow *window;
@property (weak) WebView *webView;

//@property (nonatomic, strong) IBOutlet NSMenu *statusMenu;
@property (nonatomic, strong) IBOutlet NSWindow *prefWindow;

- (IBAction)showPandorium:(id)sender;
- (IBAction)quitPandorium:(id)sender;
- (IBAction)activatePrefWindow:(id)sender;

@end
