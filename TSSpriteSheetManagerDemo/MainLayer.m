//
//  MainLayer.m
//  TSSpriteSheetManagerDemo
//
//  Created by Toni Sala Echaurren on 31/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "TSSpriteSheetManager.h"

@implementation MainLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    MainLayer *layer = [MainLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		CCDirector* director = [CCDirector sharedDirector];
        CGPoint screenCenter = ccp(director.winSize.width*0.5, director.winSize.height*0.5);
        
        // Add spritesheets to spritesheet manager
        int test = 1;
        
        if (test == 1) {
            // All frames in one spritesheet: draw calls 3
            [[TSSpriteSheetManager sharedInstance] addSpriteSheetWithFile:@"all_head_spritesheet.plist" andTextureFormat:@"png"];
            
        } else if (test == 2) {
            // Frames splitted into two spritesheets: draw calls 4
            [[TSSpriteSheetManager sharedInstance] addSpriteSheetWithFile:@"chuck_head_spritesheet.plist" andTextureFormat:@"png"];
            [[TSSpriteSheetManager sharedInstance] addSpriteSheetWithFile:@"gamera_head_spritesheet.plist" andTextureFormat:@"png"];
        }
        
        // Background. It is not in any sprite sheet. However, the code to add it is the same.
        CCSprite *background = [[TSSpriteSheetManager sharedInstance] addSpriteWithFileOrFrame:@"background.png" toNode:self autoBatching:YES];
        background.position = screenCenter;
        
        /*
         * Play with autoBatching and the node hierarchy to see how the number of draw calls changes.
         */
        
        // Sprites
        CCSprite *head1 = [[TSSpriteSheetManager sharedInstance] addSpriteWithFileOrFrame:@"chuck_head__1.png" toNode:self autoBatching:YES];
        head1.position = screenCenter;
        
        CCSprite *head2 = [[TSSpriteSheetManager sharedInstance] addSpriteWithFileOrFrame:@"gamera_head.png" toNode:self autoBatching:YES];
        head2.position = ccpAdd(screenCenter, ccp(0, head1.contentSize.height));
        
        // Test: add the same texture batched in different nodes.
        CCNode *containerNode = [CCNode node];
        containerNode.anchorPoint = ccp(0.0, 0.0);
        containerNode.position = screenCenter;
        [self addChild:containerNode];
        
        CCSprite *head3 = [[TSSpriteSheetManager sharedInstance] addSpriteWithFileOrFrame:@"chuck_head__2.png" toNode:containerNode autoBatching:YES];
        head3.position = ccp(head3.contentSize.width, 0);
        
    }
    return self;
}

@end
