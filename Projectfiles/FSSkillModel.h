//
//  FSSkillModel.h
//  FastStory
//
//  Created by miio mitani on 12/05/06.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSSkillModel : NSObject
{
    int skillType;                  // スキル属性
    int skillLevel;                 // スキルレベル
    int attackPoint;                // 基礎攻撃力
    int useMp;                      // 使用MP量
    NSString* skillName;            // スキル名
    NSString* skillDetail;          // スキル情報
    NSMutableArray* magicPointer;   // スキルを発動するためのマジックポインタ情報

}

@property (readwrite) int skillType;
@property (readwrite) int skillLevel;
@property (readwrite) int attackPoint;
@property (readwrite) int useMp;
@property (readwrite) NSString* skillName;
@property (readwrite) NSString* skillDetail;
@property (readwrite) NSMutableArray* magicPointer;
@end
