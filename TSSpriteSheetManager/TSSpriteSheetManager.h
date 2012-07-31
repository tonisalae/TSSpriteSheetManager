//
//  ResourceManager.h
//  ResourceManagerDemo
//
//  Created by Toni Sala Echaurren on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TSSpriteSheetManager : NSObject {
    NSMutableDictionary *spriteSheets;
    int currentTag;
}

#pragma mark - Singleton Methods
+ (TSSpriteSheetManager *) sharedInstance;

#pragma mark - Public Methods

-(void) addSpriteSheetWithFile:(NSString*)spriteSheetFilename andTextureFormat:(NSString*)textureFormat;
-(CCSprite*) spriteWithFileOrFrame:(NSString*)filename;
-(CCSprite*) addSpriteWithFileOrFrame:(NSString*)filename toNode:(CCNode*)parentNode autoBatching:(BOOL)autoBatching;

@end