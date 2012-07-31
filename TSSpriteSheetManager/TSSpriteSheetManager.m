//
//  ResourceManager.m
//  ResourceManagerDemo
//
//  Created by Toni Sala Echaurren on 24/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSSpriteSheetManager.h"

#define kBatchNodesFirstTag 9999


@implementation TSSpriteSheetManager

#pragma mark -
#pragma mark Singleton Variables
static TSSpriteSheetManager *singletonDelegate = nil;

#pragma mark -
#pragma mark Singleton Methods

+ (TSSpriteSheetManager *)sharedInstance {
	@synchronized(self) {
		if (singletonDelegate == nil) {
			[[self alloc] init]; // assignment not done here
		}
	}
	return singletonDelegate;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (singletonDelegate == nil) {
			singletonDelegate = [super allocWithZone:zone];
			// assignment and return on first allocation
			return singletonDelegate;
		}
	}
	// on subsequent allocation attempts return nil
	return nil;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (id)retain {
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX;  // denotes an object that cannot be released
}

- (oneway void)release {
	//do nothing
}

- (id)autorelease {
	return self;
}

#pragma mark - Init

-(void) dealloc {
    [spriteSheets release];
    spriteSheets = nil;
    
    [super dealloc];
}

- (id)init {
    if (self = [super init]) {
        // Init code here
        spriteSheets = [[NSMutableDictionary alloc] init];
        currentTag = kBatchNodesFirstTag;
    }
    return self;
}

#pragma mark - Public Methods

-(void) addSpriteSheetWithFile:(NSString*)spriteSheetFilename andTextureFormat:(NSString*)textureFormat {
    // Filename considering all iOS devices
    spriteSheetFilename = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:spriteSheetFilename];
    
    // Add the spritesheet to the spriteFrameCache.
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteSheetFilename];
}

-(CCSprite*) spriteWithFileOrFrame:(NSString*)filename {
    CCSprite *sprite;
    
    // Try to get a spriteFrame from the spriteFrameCache with the filename.
    CCSpriteFrame *spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:filename];
    
    // if the texture is in the spriteFrameCache...
    if (spriteFrame) {
        // Get the sprite.
        sprite = [CCSprite spriteWithSpriteFrameName:filename];
        return sprite;
    }
    
    // if the texture is not in any batchnode, add the sprite directly to the current node.
    sprite = [CCSprite spriteWithFile:filename];
    return sprite;
}

-(CCSprite*) addSpriteWithFileOrFrame:(NSString*)filename toNode:(CCNode*)parentNode autoBatching:(BOOL)autoBatching {
    CCSprite *sprite;
    
    // if NO auto batching...
    if (!autoBatching) {
        sprite = [self spriteWithFileOrFrame:filename];
        [parentNode addChild:sprite];
        return sprite;
    }
    
    // if autoBatching...
    
    // Try to get a spriteFrame from the spriteFrameCache with the filename.
    CCSpriteFrame *spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:filename];
    
    // if the texture is in the spriteFrameCache...
    if (spriteFrame) {
        // Get the sprite.
        sprite = [CCSprite spriteWithSpriteFrameName:filename];
        if (sprite) {
            
            // Get batch node with corresponding tag.
            int batchNodeTag = [[spriteSheets objectForKey:spriteFrame.textureFilename] intValue];
            CCNode *batchNode = [parentNode getChildByTag:batchNodeTag];
            
            // if batch node already exists...
            if ( batchNode && [batchNode isKindOfClass:[CCSpriteBatchNode class]] ) {
                // Add the sprite to the batch node
                [batchNode addChild:sprite];
                
            // if batch node doesn't exist...
            } else {
                // Create a batch node with the corresponding tag.
                CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:spriteFrame.textureFilename];
                batchNode.anchorPoint = parentNode.anchorPoint;
                batchNode.tag = currentTag;
                
                // Add the batch node tab to the spritesheets dict.
                [spriteSheets setObject:[NSNumber numberWithInt:currentTag] forKey:spriteFrame.textureFilename];
                
                currentTag++;
                
                [batchNode addChild:sprite]; // add the sprite to the batch node.
                [parentNode addChild:batchNode]; // add the batch node to the parent node.
            }
            return sprite;
        }
    }
    
    // if the texture is not in any spritesheet, add the sprite directly to the parent node.
    sprite = [CCSprite spriteWithFile:filename];
    [parentNode addChild:sprite];
    
    return sprite;
}

@end