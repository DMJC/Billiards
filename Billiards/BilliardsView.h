//
//  BilliardsView.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import <AppKit/AppKit.h>

@class GameState;
@class Table;
@class PhysicsEngine;
@class GameRules;

@interface BilliardsView : NSView {
  GameState *_state;
  Table *_table;
  PhysicsEngine *_physics;
  GameRules *_rules;
  NSImage *_tableImage;
  NSTimer *_timer;
  BOOL _wasMoving;
}

- (void)newGame;

@end
