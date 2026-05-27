//
//  GameRules.h
//  Billiards
//

#import <Foundation/Foundation.h>
#import "GameType.h"

@class GameState;
@class Table;

@interface GameRules : NSObject

- (void)beginNewRack:(GameState *)state table:(Table *)table;
- (void)shotEnded:(GameState *)state table:(Table *)table;
- (BOOL)isGameOver:(GameState *)state;

@end
