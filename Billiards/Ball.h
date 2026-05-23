//
//  Ball.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//


#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Vec2.h"

@interface Ball : NSObject {
  int _number;
  Vec2 _position;
  Vec2 _velocity;
  CGFloat _radius;
  BOOL _pocketed;
  BOOL _cueBall;
}

- (id)initWithNumber:(int)number position:(Vec2)position radius:(CGFloat)radius;

- (int)number;
- (void)setNumber:(int)n;

- (Vec2)position;
- (void)setPosition:(Vec2)p;

- (Vec2)velocity;
- (void)setVelocity:(Vec2)v;

- (CGFloat)radius;
- (void)setRadius:(CGFloat)r;

- (BOOL)isPocketed;
- (void)setPocketed:(BOOL)p;

- (BOOL)isCueBall;
- (void)setCueBall:(BOOL)c;

@end