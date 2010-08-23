//
//  HotKeyController.m
//  Pandorium
//
//  Modified by Gaurav Khanna on 8/17/10.
//  SOURCE: http://github.com/sweetfm/SweetFM/blob/master/Source/HMediaKeys.m
//  SOURCE2: http://stackoverflow.com/questions/2969110/cgeventtapcreate-breaks-down-mysteriously-with-key-down-events
//
//
//  Permission is hereby granted, free of charge, to any person 
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, 
//  merge, publish, distribute, sublicense, and/or sell copies of 
//  the Software, and to permit persons to whom the Software is 
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be 
//  included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
//  ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "HotKeyController.h"

NSString * const MediaKeyPlayPauseNotification = @"MediaKeyPlayPauseNotification";
NSString * const MediaKeyNextNotification = @"MediaKeyNextNotification";
NSString * const MediaKeyPreviousNotification = @"MediaKeyPreviousNotification";

#define NX_KEYSTATE_UP      0x0A
#define NX_KEYSTATE_DOWN    0x0B

@implementation HotKeyController

@synthesize eventPort = _eventPort;

MAKE_SINGLETON(HotKeyController, sharedController)

#define ASSERT(cond) if(!(cond)) return event;

CGEventRef tapEventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    if(type == kCGEventTapDisabledByTimeout)
        CGEventTapEnable([[HotKeyController sharedController] eventPort], TRUE);
    
    ASSERT(type == NX_SYSDEFINED)

	NSEvent *nsEvent = [NSEvent eventWithCGEvent:event];
    
    ASSERT([nsEvent subtype] == 8)
    
    int data = [nsEvent data1];
    int keyCode = (data & 0xFFFF0000) >> 16;
    int keyFlags = (data & 0xFFFF);
    int keyState = (keyFlags & 0xFF00) >> 8;
    BOOL keyIsRepeat = (keyFlags & 0x1) > 0;
    
    ASSERT(!keyIsRepeat)
    
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    switch (keyCode) {
        case NX_KEYTYPE_PLAY:
            if(keyState == NX_KEYSTATE_UP)
                [center postNotificationName:MediaKeyPlayPauseNotification object:(HotKeyController *)refcon];
            if(keyState == NX_KEYSTATE_UP || keyState == NX_KEYSTATE_DOWN)
                return NULL;
        break;
        case NX_KEYTYPE_FAST:
            if(keyState == NX_KEYSTATE_UP)
                [center postNotificationName:MediaKeyNextNotification object:(HotKeyController *)refcon];
            if(keyState == NX_KEYSTATE_UP || keyState == NX_KEYSTATE_DOWN)
                return NULL;
        break;
        case NX_KEYTYPE_REWIND:
            if(keyState == NX_KEYSTATE_UP)
                [center postNotificationName:MediaKeyPreviousNotification object:(HotKeyController *)refcon];
            if(keyState == NX_KEYSTATE_UP || keyState == NX_KEYSTATE_DOWN)
                return NULL;
        break;
    }
    return event;
}

- (id)init {
	if(self = [super init]) {
        CFRunLoopSourceRef eventSrc;
        CFRunLoopRef runLoop;
        
        @try {	
            CGEventTapOptions opts = kCGEventTapOptionDefault;
            
#ifdef TEST
            //opts = kCGEventTapOptionListenOnly;
#endif
            
            _eventPort = CGEventTapCreate(kCGSessionEventTap,
                                          kCGHeadInsertEventTap,
                                          opts,
                                          CGEventMaskBit(NX_SYSDEFINED) | CGEventMaskBit(NX_KEYUP),
                                          tapEventCallback,
                                          self);
            
            if(_eventPort == NULL)
                NSLog(@"Event port is null");
            
            eventSrc = CFMachPortCreateRunLoopSource(kCFAllocatorSystemDefault, _eventPort, 0);
            
            if(eventSrc == NULL)
                NSLog(@"No event run loop source found");
            
            runLoop = CFRunLoopGetCurrent();
            
            if(eventSrc == NULL)
                NSLog(@"No event run loop");
            
            CFRunLoopAddSource(runLoop, eventSrc, kCFRunLoopCommonModes);
            
            //while ([[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
        } @catch (NSException *e) {
            NSLog(@"Exception caught while attempting to create run loop for hotkey: %@", e);
        }
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
