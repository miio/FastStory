//
//  FSBattleLayer.m
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "FSPlayerModel.h"
#import "FSBattleLayer.h"
#import "SimpleAudioEngine.h"

@implementation FSBattleLayer
@synthesize player;
// 魔法コマンドタッチエリアの大きさ
int const MAGIC_AREA = 50;
-(id) init
{
	if ((self = [super init]))
	{
		CCLOG(@"%@ init", NSStringFromClass([self class]));
        // タッチを有効化
		self.isTouchEnabled = YES;
		//CCDirector* director = [CCDirector sharedDirector];

        // バトル背景
        CCSprite* backdrop = [CCSprite spriteWithFile: @"Battle1.jpg"];
        [backdrop setPosition:ccp(500,400)];
        [self addChild:backdrop];
		// 敵画像
		CCSprite* enemy = [CCSprite spriteWithFile:@"enemy.png"];
		//sprite.position = director.screenCenter;
		enemy.scale = 0.5f;
        enemy.position = ccp(500, 300);
        enemy.atlasIndex = 0;
		[self addChild:enemy];
        
        // 攻撃ボタン
		CCSprite* sprite = [CCSprite spriteWithFile:@"ship.png"];
		//sprite.position = director.screenCenter;
		//sprite.scale = 0;
        sprite.position = ccp(900, 600);
		[self addChild:sprite];

        // プレーヤの状態を初期化
        [self updatePlayerStatus];
		// play sound with CocosDenshion's SimpleAudioEngine
		//[[SimpleAudioEngine sharedEngine] playEffect:@"Pow.caf"];
        

	}
    
	return self;
}
-(void) ready
{
    // とりあえず仮に魔法コマンドの配列を作る
    // 暫定0
    magicCommand = [player.skill.hasSkill objectAtIndex:0];
    currentCommand = 0;
    // とりあえず敵出現エフェクトとして
    CCParticleExplosion *particle = [[CCParticleExplosion alloc]init];
    particle.texture = [[CCTextureCache sharedTextureCache] addImage:@"ship.png"];
    particle.position = ccp(450, 300);
    particle.speed = 500;
    [self addChild:particle];
    
    // マーカー初期化
    magicPointer =  [NSMutableArray array];
    for (int i = 0; i < ([magicCommand.magicPointer count]); i++) {
        CCSprite* backdrop = [CCSprite spriteWithFile: @"unselect.png"];
        
        CGPoint p = [[magicCommand.magicPointer objectAtIndex:i] CGPointValue];
        [backdrop setPosition:ccp(p.x + (MAGIC_AREA / 2), p.y + (MAGIC_AREA / 2))];
        [magicPointer addObject:backdrop];
        [self addChild:[magicPointer objectAtIndex:[magicPointer count]-1]];
    }  
}
//-(void) draw
//{
//
//    
//    // 魔法コマンド用のポインタを作成する  
//    glEnable(GL_LINE_SMOOTH);
//    
//    
//    
//    glLineWidth(2);
//    //for (id object in magicCommand) {
//    for (int i = 0; i <= ([magicCommand count]-1); i++) {
//        CGPoint p = [[magicCommand objectAtIndex:i] CGPointValue];
//        CGPoint vertices2[] = { 
//            ccp(p.x + MAGIC_AREA, p.y + 0),
//            ccp(p.x + MAGIC_AREA, p.y + MAGIC_AREA),
//            ccp(p.x + 0, p.y + MAGIC_AREA),
//            ccp(p.x + 0, p.y + 0) 
//        };
//        
//        if (currentCommand < i+1) {
//            glColor4ub(255, 0, 255, 255);
//        } else {
//            glColor4ub(255, 255, 255, 255); 
//        }
//        ccDrawPoly(vertices2, 4, YES);
//
//    }
//    
//}

//-(CGPoint*) getMagicCommandArea:(CGPoint) p{
//    CGPoint vertices[] = { 
//        CGPointMake(p.x + MAGIC_AREA, p.y + 0),
//        CGPointMake(p.x + MAGIC_AREA, p.y + MAGIC_AREA),
//        CGPointMake(p.x + 0, p.y + MAGIC_AREA),
//        CGPointMake(p.x + 0, p.y + 0) 
//    };
//    return vertices;
//}
-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch =[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    location =[[CCDirector sharedDirector] convertToGL:location];
    int offX = location.x;
    int offY = location.y;
    
    NSLog(@"%d %d", offX, offY);
    if(currentCommand <= [magicCommand.magicPointer count]-1) {

    CGPoint p = [[magicCommand.magicPointer objectAtIndex:currentCommand] CGPointValue];
    CGRect aRect = CGRectMake(
                              (p.x),
                              (p.y),
                              (MAGIC_AREA),
                              (MAGIC_AREA)
                              );
    //CGRect スプライトRect = [self rectForSprite:スプライト];
    if(CGRectContainsPoint(aRect, location)) {
        // タップエフェクトとして！
        CCParticleSystemQuad *particle = [CCParticleSystemQuad particleWithFile:@"magic_particle.plist"];
        particle.position = ccp(p.x + (MAGIC_AREA /2), p.y + (MAGIC_AREA /2));
        [self addChild:particle];
        
        // マーカー書き換え
        CCSprite* markerCurrent = [CCSprite spriteWithFile: @"selected.png"];
        CCSprite* current = [magicPointer objectAtIndex:currentCommand];
        [self removeChild:current cleanup:FALSE];
        [magicPointer replaceObjectAtIndex:currentCommand withObject:markerCurrent];
        [self addChild:markerCurrent];
        if(currentCommand >= [magicCommand.magicPointer count]-1) {
            //最終要素なら攻撃！
            CCParticleSystemQuad *particle = [CCParticleSystemQuad particleWithFile:@"magic_success.plist"];
            particle.position = ccp(200, 0);
            [self addChild:particle];
            [self performSelector:@selector(effectWater)
             // パーティクルが終わってから
             // 呼ばれる引数なしメソッドの例
                       withObject:nil // メソッドの引数なし
                       afterDelay:5
             ];

            [self performSelector:@selector(changeTurn)
             // パーティクルが終わってから
             // 呼ばれる引数なしメソッドの例
                       withObject:nil // メソッドの引数なし
                       afterDelay:10
             ];
        }
            currentCommand+=1;

    }
    }

    
}
-(void) effectWater
{
    CCParticleSystemQuad *particle2 = [CCParticleSystemQuad particleWithFile:@"magic_water_attack.plist"];
    particle2.position = ccp(450, 300);
    [self addChild:particle2];
}
-(void) changeTurn
{
    [self updatePlayerStatus];
    currentCommand=0;
    // 暫定的にかわずたんのターン
    CCParticleSystemQuad *particle = [CCParticleSystemQuad particleWithFile:@"magic_reaf_attack.plist"];
    particle.position = ccp(450, 300);
    [self addChild:particle];
    
    // 暫定的に戻す
    // マーカー初期化
    magicPointer =  [NSMutableArray array];
    for (int i = 0; i < ([magicCommand.magicPointer count]); i++) {
        CCSprite* backdrop = [CCSprite spriteWithFile: @"unselect.png"];
        
        CGPoint p = [[magicCommand.magicPointer objectAtIndex:i] CGPointValue];
        [backdrop setPosition:ccp(p.x + (MAGIC_AREA / 2), p.y + (MAGIC_AREA / 2))];
        [magicPointer addObject:backdrop];
        [self addChild:[magicPointer objectAtIndex:[magicPointer count]-1]];
    }
}
-(void) damageEffect
{
    CGRect aRect = CGRectMake(
                              (0),
                              (0),
                              (1024),
                              (768)
                              );
}
-(void) updatePlayerStatus
{
    CCDirector* director = [CCDirector sharedDirector];
    float fontSize = (director.currentDeviceIsIPad) ? 48 : 28;
    // 体力
    NSString* hp = @"HP:100";
    CCLabelTTF* hpLabel = nil;
    
    hpLabel = [CCLabelTTF labelWithString:hp
                                       fontName:@"Ubuntu-C.ttf" 
                                       fontSize:fontSize];
    hpLabel.position = ccp(100, 650);
    [self addChild:hpLabel];
    // 魔法ポイント
    NSString* mp = @"Magic:200";
    CCLabelTTF* mpLabel = nil;
    mpLabel = [CCLabelTTF labelWithString:mp
                                 fontName:@"Ubuntu-C.ttf" 
                                 fontSize:fontSize];
    mpLabel.position = ccp(100, 600);
    [self addChild:mpLabel];
    // 魔法スロット
    NSString* ms = @"Slot:3";
    CCLabelTTF* msLabel = nil;
    msLabel = [CCLabelTTF labelWithString:ms
                                 fontName:@"Ubuntu-C.ttf" 
                                 fontSize:fontSize];
    msLabel.position = ccp(100, 550);
    [self addChild:msLabel];
    // 属性
    
}
-(void) updateTurnStatus
{
    // 対象者名
}
@end
