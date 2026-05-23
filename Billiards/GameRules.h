//
//  GameRules.h
//  Billiards
//
//  Created by Gregory Casamento on 5/23/26.
//

#import <Foundation/Foundation.h>

@class GameState;
@class Table;

@interface GameRules : NSObject

- (void)beginNewRack:(GameState *)state table:(Table *)table;
- (void)shotEnded:(GameState *)state;
- (BOOL)isGameOver:(GameState *)state;

@end
