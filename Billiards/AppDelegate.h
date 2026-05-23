//
//  AppDelegate.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@class BilliardsView;

@interface AppDelegate : NSObject {
  NSWindow *_window;
  BilliardsView *_view;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (void)newGame:(id)sender;

@end
