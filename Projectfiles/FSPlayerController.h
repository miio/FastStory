//
//  FSPlayerController.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 Kawaz. All rights reserved.
//

#import "CCLayer.h"
#import "FSPlayerModel.h"
@interface FSPlayerController : CCLayer
{
    FSPlayerModel* model;   // プレーヤ情報
}
@property (readwrite) FSPlayerModel* model;
@end
