//
//  GameRules.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import "GameRules.h"
#import "GameState.h"
#import "Table.h"
#import "Ball.h"
#import "Vec2.h"

@implementation GameRules

- (void)beginNewRack:(GameState *)state table:(Table *)table {
  [[state balls] removeAllObjects];

  CGFloat r = 16.0;
  NSRect rect = [table playRect];

  Ball *cue = [[Ball alloc] initWithNumber:0
                                  position:Vec2Make(NSMidX(rect) - 220, NSMidY(rect))
                                    radius:r];
  [cue setCueBall:YES];
  [[state balls] addObject:cue];
  // [cue release];

  int number = 1;
  CGFloat startX = NSMidX(rect) + 160;
  CGFloat startY = NSMidY(rect);

  for (int row = 0; row < 5; row++) {
    for (int col = 0; col <= row; col++) {
      Vec2 p = Vec2Make(startX + row * r * 1.8,
                        startY + (col - row / 2.0) * r * 2.15);

      Ball *ball = [[Ball alloc] initWithNumber:number++
                                       position:p
                                         radius:r];
      [[state balls] addObject:ball];
      // [ball release];
    }
  }

  [state setCurrentPlayer:1];
}

- (void)shotEnded:(GameState *)state {
  if ([state currentPlayer] == 1) {
    [state setCurrentPlayer:2];
  } else {
    [state setCurrentPlayer:1];
  }
}

- (BOOL)isGameOver:(GameState *)state {
  for (Ball *b in [state balls]) {
    if (![b isCueBall] && ![b isPocketed]) {
      return NO;
    }
  }
  return YES;
}

@end
