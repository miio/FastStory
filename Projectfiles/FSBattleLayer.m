//
//  FSBattleLayer.m
//  FastStory
//
//  バトル関係のLayer
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
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

        // マジックポインタレイヤーを生成
        magicPointerLayer = [[FSBattleUIMagicPointerLayer alloc] init];
        [self addChild:magicPointerLayer];

		// play sound with CocosDenshion's SimpleAudioEngine
        
        // ステージの音をならしてみる
        // 暫定的にたわしさんの音楽を拝借w
        // refs: http://www.kawaz.org/commons/816/
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"TTN-STGBRAST!-prot.mp3"];
        

	}
    
	return self;
}

/**
 * 初期化メソッド
 */
-(void) ready
{
    // プレーヤの状態を初期化
    [self initPlayerStatus];
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
    
    // ポインター初期化
    [self createPointer];
    
    [self initSkillStatus];
}

/**
 * 魔法ポインタを作成する
 */
-(void) createPointer
{
    magicPointer =  [NSMutableArray array];
    for (int i = 0; i < ([magicCommand.magicPointer count]); i++) {
        CCSprite* backdrop = [CCSprite spriteWithFile: @"unselect.png"];
        
        CGPoint p = [[magicCommand.magicPointer objectAtIndex:i] CGPointValue];
        [backdrop setPosition:ccp(p.x + (MAGIC_AREA / 2), p.y + (MAGIC_AREA / 2))];
        [magicPointer addObject:backdrop];
        [self addChild:[magicPointer objectAtIndex:[magicPointer count]-1]];
    }   
}

-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    // TODO: タッチイベントに関していえば、完全にControllerに丸投げするのがきっと理想な気がする
    // Controllerで適切に判定し、Layer側のエフェクトメソッドを叩くのが正解な気がします
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
            currentCommand+=1;
            [self enterTouchMarker:p];

            if(currentCommand > [magicCommand.magicPointer count]-1) {
                //最終要素なら攻撃！
                // 攻撃によるパラメータ変更
                // TODO: ここはViewよりもControllerのお仕事のため、このあたりはリファクタリングしたほうがいいと思う
                // MPを消費する
                player.mp -= magicCommand.useMp;

                // パラメータ変更が入ったのでViewのユーザステータスを更新
                [self updatePlayerStatus];

                // 攻撃エフェクト
                [self enterAttack];

            }


        }
    }

    
}

/**
 * マジックポインタをタッチしたときのアクションを行う
 * @param   CGPoint p   タッチ位置情報
 */
-(void) enterTouchMarker:(CGPoint) p
{
    // タップエフェクトとして！
    CCParticleSystemQuad *particle = [CCParticleSystemQuad particleWithFile:@"magic_particle.plist"];
    particle.position = ccp(p.x + (MAGIC_AREA /2), p.y + (MAGIC_AREA /2));
    [self addChild:particle];
    
    // SE再生
    // refs: http://www.yen-soft.com/ssse/sound/ta.php#se
    // refs: http://www.yen-soft.com/ssse/sound/se/z/ta_ta_kagayaku01.mp3
    [[SimpleAudioEngine sharedEngine] playEffect:@"ta_ta_kagayaku01.mp3"];
    // マーカー書き換え
    CCSprite* markerCurrent = [CCSprite spriteWithFile: @"selected.png"];
    CCSprite* current = [magicPointer objectAtIndex:currentCommand-1];
    [self removeChild:current cleanup:FALSE];
    [magicPointer replaceObjectAtIndex:currentCommand-1 withObject:markerCurrent];
    [self addChild:markerCurrent];
}

/**
 * 攻撃エフェクト
 * @todo このエフェクトに関してはプレーヤが保持するべきな気がする
 */
-(void) enterAttack
{
    CCParticleSystemQuad *particle = [CCParticleSystemQuad particleWithFile:@"magic_success.plist"];
    particle.position = ccp(200, 0);
    [self addChild:particle];
    // SE再生
    // refs: http://www.yen-soft.com/ssse/sound/ta.php#se
    // refs: http://www.yen-soft.com/ssse/sound/se/z/ta_ta_hosikuzu01.mp3
    [[SimpleAudioEngine sharedEngine] playEffect:@"ta_ta_hosikuzu01.mp3"];
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

/**
 * 水属性の攻撃エフェクト
 */
-(void) effectWater
{
    // パーティクルオブジェクトを生成して実行する
    CCParticleSystemQuad *particle2 = [CCParticleSystemQuad particleWithFile:@"magic_water_attack.plist"];
    particle2.position = ccp(450, 300); // @todo 座標はとりあえず決めうちになってる
    [self addChild:particle2];
}

/**
 * ターンを変更する際の画面状態の変更
 */
-(void) changeTurn
{
    [self initPlayerStatus];
    currentCommand=0;
    // 暫定的にかわずたんのターン
    
    // 攻撃によるパラメータ変更
    // TODO: ここはViewよりもControllerのお仕事のため、このあたりはリファクタリングしたほうがいいと思う
    // それっぽくダメージを食らう
    player.hp -= 10;
    
    // パラメータ変更が入ったのでViewのユーザステータスを更新
    [self updatePlayerStatus];
    
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

/**
 * @Deprecated
 */
-(void) damageEffect
{
    CGRect aRect = CGRectMake(
                              (0),
                              (0),
                              (1024),
                              (768)
                              );
}

/**
 * プレーヤの状態の描画を初期化する
 */
-(void) initPlayerStatus
{
    [self updatePlayerStatus];
}

/**
 * プレーヤの状態の描画を更新する
 */
-(void) updatePlayerStatus
{
    [self removeChild:hpLabel cleanup:TRUE];
    [self removeChild:mpLabel cleanup:TRUE];
    [self removeChild:msLabel cleanup:TRUE];
    CCDirector* director = [CCDirector sharedDirector];
    float fontSize = (director.currentDeviceIsIPad) ? 48 : 28;
    // 体力
    NSString* hp = @"HP:";
    hp = [hp stringByAppendingString: [NSString stringWithFormat:@"%d", player.hp]];
    
    hpLabel = [CCLabelTTF labelWithString:hp
                                       fontName:@"Ubuntu-C.ttf" 
                                       fontSize:fontSize];
    hpLabel.position = ccp(100, 650);

    // 魔法ポイント
    NSString* mp = @"Magic:";
    mp = [mp stringByAppendingString: [NSString stringWithFormat:@"%d", player.mp]];
    mpLabel = [CCLabelTTF labelWithString:mp
                                 fontName:@"Ubuntu-C.ttf" 
                                 fontSize:fontSize];
    mpLabel.position = ccp(100, 600);
    // 魔法スロット
    NSString* ms = @"Slot:";
    ms = [ms stringByAppendingString: [NSString stringWithFormat:@"%d", player.ms]];
    msLabel = [CCLabelTTF labelWithString:ms
                                 fontName:@"Ubuntu-C.ttf" 
                                 fontSize:fontSize];
    msLabel.position = ccp(100, 550);
    // 属性
    [self addChild:hpLabel];
    [self addChild:mpLabel];
    [self addChild:msLabel];
}

/**
 * スキル情報の描画を初期化する
 */
-(void) initSkillStatus
{
    [self updateSkillStatus];
}

/**
 * スキル情報の描画を更新する
 */
-(void) updateSkillStatus
{
    [self removeChild:skillTypeLabel cleanup:TRUE];
    [self removeChild:skillNameLabel cleanup:TRUE];
    [self removeChild:skillDetailLabel cleanup:TRUE];
    [self removeChild:attackPointLabel cleanup:TRUE];
    [self removeChild:useMpLabel cleanup:TRUE];
    CCDirector* director = [CCDirector sharedDirector];
    float fontSize = (director.currentDeviceIsIPad) ? 28 : 14;
    // 属性
    NSString* skillType = @"SkillType:";
    skillType = [skillType stringByAppendingString: [NSString stringWithFormat:@"%d", magicCommand.skillType]];

    
    skillTypeLabel = [CCLabelTTF labelWithString:skillType
                                 fontName:@"Ubuntu-C.ttf" 
                                 fontSize:fontSize];
    skillTypeLabel.position = ccp(100, 450);

    // スキル名
    NSString* skillName = @"SkillName:";
    skillName = [skillType stringByAppendingString: magicCommand.skillName];

    
    skillNameLabel = [CCLabelTTF labelWithString:skillName
                                        fontName:@"HiraKakuProN-W3" 
                                        fontSize:fontSize];
    skillNameLabel.position = ccp(100, 400);
    
    // スキル詳細
    NSString* skillDetail = @"SkillDetail:";
    skillDetail = [skillDetail stringByAppendingString: magicCommand.skillDetail];

    
    skillDetailLabel = [CCLabelTTF labelWithString:skillDetail
                                        fontName:@"HiraKakuProN-W3" 
                                        fontSize:fontSize];
    skillDetailLabel.position = ccp(100, 350);
    
    // 攻撃力
    NSString* attackPoint = @"AttackPoint:";
    attackPoint = [attackPoint stringByAppendingString: [NSString stringWithFormat:@"%d", magicCommand.attackPoint]];
    attackPointLabel = [CCLabelTTF labelWithString:attackPoint
                                        fontName:@"Ubuntu-C.ttf" 
                                        fontSize:fontSize];
    attackPointLabel.position = ccp(100, 300);
    
    // 使用MP
    NSString* useMp = @"UseMP:";
    useMp = [useMp stringByAppendingString: [NSString stringWithFormat:@"%d", magicCommand.useMp]];    
    useMpLabel = [CCLabelTTF labelWithString:useMp
                                          fontName:@"Ubuntu-C.ttf" 
                                          fontSize:fontSize];
    useMpLabel.position = ccp(100, 250);
    
    [self addChild:skillTypeLabel];
    [self addChild:skillNameLabel];
    [self addChild:skillDetailLabel];
    [self addChild:attackPointLabel];
    [self addChild:useMpLabel];
}

-(void) updateTurnStatus
{
    // 対象者名
}
@end
