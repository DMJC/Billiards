//
//  Ball.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//


#import "Ball.h"

@implementation Ball

- (id)initWithNumber:(int)number position:(Vec2)position radius:(CGFloat)radius {
  self = [super init];
  if (self) {
    _number = number;
    _position = position;
    _velocity = Vec2Make(0, 0);
    _radius = radius;
    _pocketed = NO;
    _cueBall = NO;
  }
  return self;
}

- (int)number { return _number; }
- (void)setNumber:(int)n { _number = n; }

- (Vec2)position { return _position; }
- (void)setPosition:(Vec2)p { _position = p; }

- (Vec2)velocity { return _velocity; }
- (void)setVelocity:(Vec2)v { _velocity = v; }

- (CGFloat)radius { return _radius; }
- (void)setRadius:(CGFloat)r { _radius = r; }

- (BOOL)isPocketed { return _pocketed; }
- (void)setPocketed:(BOOL)p { _pocketed = p; }

- (BOOL)isCueBall { return _cueBall; }
- (void)setCueBall:(BOOL)c { _cueBall = c; }

@end