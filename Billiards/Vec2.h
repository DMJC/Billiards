//
//  Vec2.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <math.h>

typedef struct {
  CGFloat x;
  CGFloat y;
} Vec2;

static inline Vec2 Vec2Make(CGFloat x, CGFloat y) {
  return (Vec2){x, y};
}

static inline Vec2 Vec2Add(Vec2 a, Vec2 b) {
  return Vec2Make(a.x + b.x, a.y + b.y);
}

static inline Vec2 Vec2Sub(Vec2 a, Vec2 b) {
  return Vec2Make(a.x - b.x, a.y - b.y);
}

static inline Vec2 Vec2Mul(Vec2 a, CGFloat s) {
  return Vec2Make(a.x * s, a.y * s);
}

static inline CGFloat Vec2Dot(Vec2 a, Vec2 b) {
  return a.x * b.x + a.y * b.y;
}

static inline CGFloat Vec2Len(Vec2 a) {
  return sqrt(Vec2Dot(a, a));
}

static inline Vec2 Vec2Normalize(Vec2 a) {
  CGFloat len = Vec2Len(a);
  if (len < 0.0001) return Vec2Make(0, 0);
  return Vec2Mul(a, 1.0 / len);
}
