//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDKPlugin.h>

/**
 *	@brief	分享内容实体
 */
@interface SSGooglePlusShareContentEntity : NSObject <ISSPlatformShareContentEntity,
                                                      NSCoding>
{
@private
    NSMutableDictionary *_dict;
}

/**
 *	@brief	内容
 */
@property (nonatomic,copy) NSString *text;

/**
 *	@brief	图片
 */
@property (nonatomic,copy) id<ISSCAttachment> image;

/**
 *	@brief	链接
 */
@property (nonatomic,copy) NSString *url;

/**
 *	@brief	深链接描述
 */
@property (nonatomic,copy) NSString *description;

/**
 *	@brief	深链接标题
 */
@property (nonatomic,copy) NSString *title;

/**
 *	@brief	缩略图
 */
@property (nonatomic,retain) NSString *thumbnail;

/**
 *	@brief	深链接ID
 */
@property (nonatomic,copy) NSString *deepLinkId;

/**
 *	@brief	通过分享内容解析实体数据
 *
 *	@param 	content 	分享内容
 */
- (void)parseWithContent:(id<ISSContent>)content;

@end
