//
//  FSPlayerController.h
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "FSPlayerModel.h"
@interface FSPlayerController : CCLayer
{
    FSPlayerModel* model;
}
@property (readwrite) FSPlayerModel* model;
@end
