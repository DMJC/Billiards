//
//  AppDelegate.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import "AppDelegate.h"
#import "BilliardsView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  NSRect frame = NSMakeRect(100, 100, 900, 520);

  _window = [[NSWindow alloc] initWithContentRect:frame
                                       styleMask:(NSTitledWindowMask |
                                                  NSClosableWindowMask |
                                                  NSMiniaturizableWindowMask |
                                                  NSResizableWindowMask)
                                         backing:NSBackingStoreBuffered
                                           defer:NO];

  [_window setTitle:@"Billiards"];

  _view = [[BilliardsView alloc] initWithFrame:NSMakeRect(0, 0, 900, 520)];
  [_window setContentView:_view];
  [_window makeKeyAndOrderFront:nil];
}

- (void)newGame:(id)sender {
  [_view newGame];
}

/*
- (void)dealloc {
  [_view release];
  [_window release];
  [super dealloc];
}
*/

@end
