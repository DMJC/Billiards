//
//  Table.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//


#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface Table : NSObject {
  NSRect _playRect;
  CGFloat _pocketRadius;
  NSMutableArray *_pockets;
}

- (id)initWithRect:(NSRect)rect;
- (NSRect)playRect;
- (CGFloat)pocketRadius;
- (NSArray *)pockets;

@end