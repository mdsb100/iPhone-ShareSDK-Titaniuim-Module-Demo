/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"

@interface ComBaidaoTestsharesdkModule : TiModule 
{
    @private
    BOOL hasSinaWeibo, hasWechat, hasWechatMoments, hasWechatFavorite, hasTencentWeibo, hasQZone, hasQQ, hasEmail, hasShortMessage;
    BOOL oneKeyShareSinaWeibo, oneKeyShareWechat, oneKeyShareWechatMoments, oneKeyShareWechatFavorite, oneKeyShareTencentWeibo, oneKeyShareQZone, oneKeyShareQQ, oneKeyShareEmail, oneKeyShareShortMessage;
}

-(void)share:(id)args;

@end
