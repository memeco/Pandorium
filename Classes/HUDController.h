//
//  HUDController.h
//  Pandorium
//
//  Created by Gaurav Khanna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//
//  ISHDefaults.h
//  isHUD
//
//  Created by ghawkgu on 11/20/11.
//  Copyright (c) 2011 ghawkgu.
//

#ifndef isHUD_ISHDefaults_h
#define isHUD_ISHDefaults_h

#define HUD_FADE_IN_DURATION    (0.25)
#define HUD_FADE_OUT_DURATION   (0.5)
#define HUD_DISPLAY_DURATION    (1.0)
#define HUD_ALPHA_VALUE         (0.15)
#define HUD_CORNER_RADIUS       (24.0)

#define HUD_HORIZONTAL_MARGIN   (33)
#define HUD_VERTICAL_MARGIN     (76)
#define HUD_HEIGHT              (208)

#endif

#define MEDIA_KEY 1
#define MEDIA_KEY_FONT_SIZE 110

#import <Foundation/Foundation.h>

@interface HUDController : NSObject {
@private
    BOOL fadingOut;
    NSUInteger hotkeySelectInputSource;
}

@property (nonatomic, strong) NSWindow *window;
#ifdef TEXTFIELD
@property (nonatomic, strong) NSTextField *isName;
#else
@property (nonatomic, strong) NSTextView *isName;
#endif
@property (nonatomic, strong) NSMenu *statusMenu;
@property (nonatomic, strong) NSView *panelView;
@property (nonatomic, strong) NSImageView *isImage;
@property (nonatomic, strong) NSStatusItem *myStatusMenu;
@property (nonatomic, strong) NSTimer *timerToFadeOut;
@property (nonatomic, strong) NSTimer *timerForHotKeyDelay;

+ (id)sharedController;

- (void)fadeInHudKey:(GKHotKey*)key;
- (void)fadeInHud;
- (void)fadeOutHud;
- (void)didFadeIn;
- (void)didFadeOut;
- (void)initUIComponents;
- (void)setUpHUD;

@end
