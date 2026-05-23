//
//  Table.m
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//


#import "Table.h"

@implementation Table

- (id)initWithRect:(NSRect)rect {
  self = [super init];
  if (self) {
    _playRect = rect;
    _pocketRadius = 24.0;
    _pockets = [[NSMutableArray alloc] init];

    [_pockets addObject:[NSValue valueWithPoint:NSMakePoint(NSMinX(rect), NSMinY(rect))]];
    [_pockets addObject:[NSValue valueWithPoint:NSMakePoint(NSMidX(rect), NSMinY(rect))]];
    [_pockets addObject:[NSValue valueWithPoint:NSMakePoint(NSMaxX(rect), NSMinY(rect))]];

    [_pockets addObject:[NSValue valueWithPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect))]];
    [_pockets addObject:[NSValue valueWithPoint:NSMakePoint(NSMidX(rect), NSMaxY(rect))]];
    [_pockets addObject:[NSValue valueWithPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))]];
  }
  return self;
}

/*
- (void)dealloc {
  [_pockets release];
  [super dealloc];
}
*/

- (NSRect)playRect { return _playRect; }
- (CGFloat)pocketRadius { return _pocketRadius; }
- (NSArray *)pockets { return _pockets; }

@end
