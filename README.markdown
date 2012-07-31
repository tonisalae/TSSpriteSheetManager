## TSSpriteSheetManager - Easily manage sprite sheets on Cocos2d

TSSpriteSheetManager is a singleton cocos2d class that allows for easily manage sprite sheets. You just add sprite sheets to the manager and then request a sprite or frame automatically batched for you. The manager will search for the sprite in all the added sprite sheets and if it is not in any of them, it will search for individual files on your project.

More about me at [IndieDevStories.com](http://indiedevstories.com)

## Motivation

I usually start my game projects by prototyping without using sprite sheets from the very beginning of the development process. This allows me to make quick changes by just swapping files.

However, sooner or later you will need to start using sprite sheets on your game (you know, performance). The process to switch to individual images to sprite sheets could be a pain in some circumstances.

On the other hand, it is usually recommended to use sprite sheets with cocos2d batching mechanism. This way, you can take advantage of the fact that all the frames of your game assets are in the same texture (or a few of them). This way, you can reduce considerably the draw calls and, therefore, the overall performance of your game.

So, to solve both problems in one shoot I coded this little singleton class called **TSSpriteSheetManager**.

## Features

TSSpriteSheetManager offers the following **features**:

* **One single method to create `CCSprites` from a sprite sheet or a single image.** This is very useful to switch from individual image files to sprite sheets. You tipically start your protoypes with individual files to test rapidly. TSSpriteSheetManager makes switching to sprite sheets a painless process.
* **Automatic batching.** TSSpriteSheetManager creates automatically `CCSpriteBatchNodes` when necessary. This allows for reducing the draw calls automatically.
* Supports **iPhone, iPhone Retina, iPad and iPad Retina** sprite sheets

## Usage

First, you need to add some sprite sheets. You tipically put this code in the "Loading…" section of your scene.

	[[TSSpriteSheetManager sharedInstance] addSpriteSheetWithFile:@"all_head_spritesheet.plist" andTextureFormat:@"png"];

Then, to add a sprite to a node use this snippet:

	CCSprite *head1 = [[TSSpriteSheetManager sharedInstance] addSpriteWithFileOrFrame:@"chuck_head__1.png" toNode:self autoBatching:YES];
	head1.position = screenCenter;
        
As you can see, the `addSpriteWithFileOrFrame:toNode:autoBatching:` method adds the sprite automatically to the provided node. This is slightly different from the usual cocos2d workflow. However, this is needed to perform the automatic batching of the sprite.

TSSpriteSheetManager offers an additional method:

	-(CCSprite*) spriteWithFileOrFrame:(NSString*)filename;

You may use this method if you prefer to ignore all the automatic batching stuff, but still benefit from transparent loading of `CCSprites` from individual files or sprite sheets (see *Limitations* section below).

As usual, very easy to use ;)

## Adding TSSpriteSheetManager into your Xcode 4 project

To add the TSSpriteSheetManager component to your project you simply need to drag & drop the entire “TSSpriteSheetManager” folder. There are only two files.

## Limitations

* **CCMenu**. Due to the particular nature of `CCMenu` you are not allowed to add `CCSpriteBatchNodes` to it. You can only add `CCSprites` to a `CCMenu`. So you can't use the `addSpriteWithFileOrFrame:toNode:autoBatching:` method. However, you are still allowed to use `spriteWithFileOrFrame:` to just get the `CCSprite` and then add it to your `CCMenu` in the usual way.
* TSSpriteSheetManager uses cocos2d tags to manage the needed nodes for automatic batching. By default, the first `CCSpriteBatchNode` is created with the tag *9999*. Take it into account to avoid collisions with your own nodes. You can change this default value by modifying the value of the constant `kBatchNodesFirstTag` at the top of the `TSSpriteSheetManager.m` file.

## Licence

Copyright (c) 2012 Toni Sala

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.