//
//  BilliardsView.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import "BilliardsView.h"
#import "GameState.h"
#import "Table.h"
#import "PhysicsEngine.h"
#import "GameRules.h"
#import "Ball.h"
#import "Vec2.h"

static const CGFloat BilliardsTableImageWidth = 1438.0;
static const CGFloat BilliardsTableImageHeight = 889.0;
static const NSRect BilliardsImagePlayRect = {{95.0, 105.0}, {1249.0, 681.0}};

@implementation BilliardsView

+ (NSSize)preferredViewSize {
  NSImage *image = [NSImage imageNamed:@"billiard_table"];
  if (image) {
    return [image size];
  }

  return NSMakeSize(900, 520);
}

- (NSRect)playRectForBounds:(NSRect)bounds {
  CGFloat xScale = NSWidth(bounds) / BilliardsTableImageWidth;
  CGFloat yScale = NSHeight(bounds) / BilliardsTableImageHeight;

  return NSMakeRect(NSMinX(bounds) + NSMinX(BilliardsImagePlayRect) * xScale,
                    NSMinY(bounds) + NSMinY(BilliardsImagePlayRect) * yScale,
                    NSWidth(BilliardsImagePlayRect) * xScale,
                    NSHeight(BilliardsImagePlayRect) * yScale);
}

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _tableImage = [NSImage imageNamed:@"billiard_table"];

    NSRect play = [self playRectForBounds:[self bounds]];

    _state = [[GameState alloc] init];
    _table = [[Table alloc] initWithRect:play];
    _physics = [[PhysicsEngine alloc] init];
    _rules = [[GameRules alloc] init];

    [_rules beginNewRack:_state table:_table];

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60.0
                                               target:self
                                             selector:@selector(tick:)
                                             userInfo:nil
                                             repeats:YES]; // retain
  }
  return self;
}

- (void)dealloc {
  [_timer invalidate];
    /*
  [_timer release];
  [_state release];
  [_table release];
  [_physics release];
  [_rules release];
     */
  // [super dealloc];
}

- (BOOL)isFlipped {
  return NO;
}

- (void)newGame {
  [_rules beginNewRack:_state table:_table];
  [self setNeedsDisplay:YES];
}

- (void)tick:(NSTimer *)timer {
  [_physics step:1.0 / 60.0 state:_state table:_table];

  if (_wasMoving && ![_state ballsInMotion]) {
    [_rules shotEnded:_state];
  }

  _wasMoving = [_state ballsInMotion];

  [self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)event {
  if ([_state ballsInMotion]) return;

  NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];

  [_state setAiming:YES];
  [_state setAimStart:Vec2Make(p.x, p.y)];
  [_state setAimCurrent:Vec2Make(p.x, p.y)];
}

- (void)mouseDragged:(NSEvent *)event {
  if (![_state isAiming]) return;

  NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
  [_state setAimCurrent:Vec2Make(p.x, p.y)];

  [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
  if (![_state isAiming]) return;

  [_state setAiming:NO];

  Ball *cue = [_state cueBall];
  if (!cue) return;

  Vec2 start = [_state aimStart];
  Vec2 end = [_state aimCurrent];

  Vec2 drag = Vec2Sub(start, end);
  CGFloat power = MIN(Vec2Len(drag), 180.0);
  Vec2 direction = Vec2Normalize(drag);

  [cue setVelocity:Vec2Mul(direction, power * 8.0)];
}

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor colorWithCalibratedWhite:0.12 alpha:1.0] set];
  NSRectFill([self bounds]);

  [self drawTable];
  [self drawBalls];

  if ([_state isAiming]) {
    [self drawAimLine];
  }
}

- (void)drawTable {
  NSRect outer = [self bounds];

  if (_tableImage) {
    [_tableImage drawInRect:outer
                   fromRect:NSZeroRect
                  operation:NSCompositeSourceOver
                   fraction:1.0
             respectFlipped:YES
                      hints:nil];
  } else {
    NSRect play = [_table playRect];

    [[NSColor colorWithCalibratedRed:0.22 green:0.12 blue:0.05 alpha:1.0] set];
    NSBezierPath *wood = [NSBezierPath bezierPathWithRoundedRect:outer
                                                         xRadius:18
                                                         yRadius:18];
    [wood fill];

    [[NSColor colorWithCalibratedRed:0.02 green:0.28 blue:0.10 alpha:1.0] set];
    NSBezierPath *felt = [NSBezierPath bezierPathWithRoundedRect:play
                                                         xRadius:8
                                                         yRadius:8];
    [felt fill];

    [[NSColor blackColor] set];
    for (NSValue *value in [_table pockets]) {
      NSPoint p = [value pointValue];
      CGFloat pr = [_table pocketRadius];

      NSRect pocketRect = NSMakeRect(p.x - pr, p.y - pr, pr * 2, pr * 2);
      [[NSBezierPath bezierPathWithOvalInRect:pocketRect] fill];
    }
  }
}

- (void)drawBalls {
  for (Ball *b in [_state balls]) {
    if ([b isPocketed]) continue;

    Vec2 p = [b position];
    CGFloat r = [b radius];

    NSRect ballRect = NSMakeRect(p.x - r, p.y - r, r * 2, r * 2);

    if ([b isCueBall]) {
      [[NSColor whiteColor] set];
    } else {
      CGFloat hue = ((CGFloat)([b number] % 15)) / 15.0;
      [[NSColor colorWithCalibratedHue:hue
                             saturation:0.85
                             brightness:0.85
                                  alpha:1.0] set];
    }

    [[NSBezierPath bezierPathWithOvalInRect:ballRect] fill];

    if (![b isCueBall]) {
      CGFloat numberRadius = r * 0.52;
      NSRect numberRect = NSMakeRect(p.x - numberRadius,
                                     p.y - numberRadius,
                                     numberRadius * 2,
                                     numberRadius * 2);

      [[NSColor whiteColor] set];
      [[NSBezierPath bezierPathWithOvalInRect:numberRect] fill];

      NSString *number = [NSString stringWithFormat:@"%d", [b number]];
      NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
      [paragraphStyle setAlignment:NSTextAlignmentCenter];

      CGFloat numberFontSize = r * 0.78;
#ifdef GNUSTEP
      numberFontSize = r * 0.68;
#endif

      NSDictionary *attributes = @{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:numberFontSize],
        NSForegroundColorAttributeName: [NSColor blackColor],
        NSParagraphStyleAttributeName: paragraphStyle
      };

      NSSize textSize = [number sizeWithAttributes:attributes];
      NSRect textRect = NSMakeRect(p.x - numberRadius,
                                   p.y - (textSize.height / 2.0),
                                   numberRadius * 2,
                                   textSize.height);
      [number drawInRect:textRect withAttributes:attributes];
    }

    [[NSColor blackColor] set];
    [[NSBezierPath bezierPathWithOvalInRect:ballRect] stroke];
  }
}

- (void)drawAimLine {
  Vec2 a = [_state aimStart];
  Vec2 b = [_state aimCurrent];

  [[NSColor colorWithCalibratedWhite:1.0 alpha:0.55] set];

  NSBezierPath *line = [NSBezierPath bezierPath];
  [line moveToPoint:NSMakePoint(a.x, a.y)];
  [line lineToPoint:NSMakePoint(b.x, b.y)];
  [line setLineWidth:2.0];
  [line stroke];
}

@end
