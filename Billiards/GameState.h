//
//  GameState.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import <Foundation/Foundation.h>
#import "Vec2.h"
@class Ball;

@interface GameState : NSObject {
  NSMutableArray *_balls;
  NSInteger _currentPlayer;
  BOOL _ballsInMotion;
  BOOL _aiming;
  Vec2 _aimStart;
  Vec2 _aimCurrent;
}

- (NSMutableArray *)balls;
- (Ball *)cueBall;

- (NSInteger)currentPlayer;
- (void)setCurrentPlayer:(NSInteger)p;

- (BOOL)ballsInMotion;
- (void)setBallsInMotion:(BOOL)m;

- (BOOL)isAiming;
- (void)setAiming:(BOOL)a;

- (Vec2)aimStart;
- (void)setAimStart:(Vec2)v;

- (Vec2)aimCurrent;
- (void)setAimCurrent:(Vec2)v;

@end
