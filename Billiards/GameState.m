//
//  GameState.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import "GameState.h"
#import "Ball.h"

@implementation GameState

- (id)init {
  self = [super init];
  if (self) {
    _balls = [[NSMutableArray alloc] init];
    _currentPlayer = 1;
    _ballsInMotion = NO;
    _aiming = NO;
  }
  return self;
}

/*
- (void)dealloc {
  [_balls release];
  [super dealloc];
}
*/

- (NSMutableArray *)balls { return _balls; }

- (Ball *)cueBall {
  for (Ball *b in _balls) {
    if ([b isCueBall]) return b;
  }
  return nil;
}

- (NSInteger)currentPlayer { return _currentPlayer; }
- (void)setCurrentPlayer:(NSInteger)p { _currentPlayer = p; }

- (BOOL)ballsInMotion { return _ballsInMotion; }
- (void)setBallsInMotion:(BOOL)m { _ballsInMotion = m; }

- (BOOL)isAiming { return _aiming; }
- (void)setAiming:(BOOL)a { _aiming = a; }

- (Vec2)aimStart { return _aimStart; }
- (void)setAimStart:(Vec2)v { _aimStart = v; }

- (Vec2)aimCurrent { return _aimCurrent; }
- (void)setAimCurrent:(Vec2)v { _aimCurrent = v; }

@end
