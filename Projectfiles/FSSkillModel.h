//
//  FSSkillModel.h
//  FastStory
//
//  Created by miio mitani on 12/05/06.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSSkillModel : NSObject
{
    int skillType;
    int skillLevel;
    int attackPoint;
    NSString* skillName;
    NSString* skillDetail;
    NSMutableArray* magicPointer;

}

@property (readwrite) int skillType;
@property (readwrite) int skillLevel;
@property (readwrite) int attackPoint;
@property (readwrite) NSString* skillName;
@property (readwrite) NSString* skillDetail;
@property (readwrite) NSMutableArray* magicPointer;
@end
