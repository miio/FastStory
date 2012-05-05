//
//  FSPlayerController.m
//  FastStory
//
//  Created by miio mitani on 12/05/05.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FSPlayerController.h"
#import "FSPlayerModel.h"
@implementation FSPlayerController
@synthesize model;
-(id) init
{
    if ((self = [super init]))
    {
        FSPlayerModel* modelObj = [[FSPlayerModel alloc] init];
        self.model = modelObj;
    }
    return self;
}

@end
