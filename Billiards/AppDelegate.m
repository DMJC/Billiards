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
  [self setupMainMenu];

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

- (void)setupMainMenu {
  NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@""];

  NSMenuItem *appMenuItem = [[NSMenuItem alloc] initWithTitle:@""
                                                       action:nil
                                                keyEquivalent:@""];
  [mainMenu addItem:appMenuItem];

  NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"Billiards"];

  NSMenuItem *newGameItem = [[NSMenuItem alloc] initWithTitle:@"New Game"
                                                       action:@selector(newGame:)
                                                keyEquivalent:@"n"];
  [newGameItem setTarget:self];
  [appMenu addItem:newGameItem];

  [appMenu addItem:[NSMenuItem separatorItem]];

  NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit Billiards"
                                                    action:@selector(terminate:)
                                             keyEquivalent:@"q"];
  [quitItem setTarget:NSApp];
  [appMenu addItem:quitItem];

  [mainMenu setSubmenu:appMenu forItem:appMenuItem];
  [NSApp setMainMenu:mainMenu];
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
