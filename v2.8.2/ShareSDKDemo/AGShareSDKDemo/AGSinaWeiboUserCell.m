//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//

#import "AGSinaWeiboUserCell.h"

#define LEFT_PADDING 7.0
#define RIGHT_PADDING 7.0
#define HORIZONTAL_GAG 7.0
#define VERTICAL_GAP 3.0

#define ICON_WIDTH 45.0
#define ICON_HEIGHT 45.0
#define GENDER_ICON_WIDTH 16.0
#define GENDER_ICON_HEIGHT 16.0
#define VIP_ICON_WIDTH 17.0
#define VIP_ICON_HEIGHT 17.0

@implementation AGSinaWeiboUserCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
  imageCacheManager:(CMImageCacheManager *)imageCacheManager
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cacheManager = imageCacheManager;
        
        //头像
        _iconImageView = [[CMImageView alloc] initWithFrame:CGRectMake(LEFT_PADDING,
                                                                       (self.contentView.height - ICON_HEIGHT) / 2,
                                                                       ICON_WIDTH,
                                                                       ICON_HEIGHT)];
        _iconImageView.defaultImage = [UIImage imageNamed:@"defaultAvatar.png"];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView release];
        
        //Loading
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_indicatorView sizeToFit];
        _indicatorView.frame = CGRectMake(_iconImageView.left + (_iconImageView.width - _indicatorView.width) / 2,
                                          _iconImageView.top + (_iconImageView.height - _indicatorView.height) / 2,
                                          _indicatorView.width,
                                          _indicatorView.height);
        [self.contentView addSubview:_indicatorView];
        [_indicatorView release];
        
        //图标
        _vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, VIP_ICON_WIDTH, VIP_ICON_HEIGHT)];
        [self.contentView addSubview:_vipImageView];
        [_vipImageView release];
        
        //昵称
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_nickNameLabel];
        [_nickNameLabel release];
        
        //描述
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_descLabel];
        [_descLabel release];
        
        //性别
        _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, GENDER_ICON_WIDTH, GENDER_ICON_HEIGHT)];
        [self.contentView addSubview:_sexImageView];
        [_sexImageView release];
    }
    return self;
}

- (void)dealloc
{
    [_loader removeAllNotificationWithTarget:self];
    SAFE_RELEASE(_loader);
    
    _iconImageView = nil;
    _vipImageView = nil;
    _nickNameLabel = nil;
    _descLabel = nil;
    _indicatorView = nil;
    _sexImageView = nil;
    _cacheManager = nil;
    
    SAFE_RELEASE(_userInfo);
    
    [super dealloc];
}

- (void)setUserInfo:(SSSinaWeiboUserInfoReader *)userInfo
{
    [userInfo retain];
    SAFE_RELEASE(_userInfo);
    _userInfo = userInfo;
    
    _iconImageView.image = nil;
    _vipImageView.image = nil;
    
    _needLayout = YES;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_needLayout && _userInfo)
    {
        _needLayout = NO;
        
        [_loader removeAllNotificationWithTarget:self];
        SAFE_RELEASE(_loader);
        
        _loader = [[_cacheManager getImage:_userInfo.avatarLarge cornerRadius:5.0 size:_iconImageView.frame.size] retain];
        if (_loader.state == ImageLoaderStateReady)
        {
            _iconImageView.image = _loader.content;
            [_indicatorView stopAnimating];
        }
        else
        {
            [_indicatorView startAnimating];
            [_loader addNotificationWithName:NOTIF_IMAGE_LOAD_COMPLETE
                                      target:self
                                      action:@selector(iconLoadCompleteHandler:)];
            [_loader addNotificationWithName:NOTIF_IMAGE_LOAD_ERROR
                                      target:self
                                      action:@selector(iconLoadErrorHandler:)];
        }
        
        _iconImageView.frame = CGRectMake(LEFT_PADDING, (self.contentView.height - ICON_HEIGHT) / 2, ICON_WIDTH, ICON_HEIGHT);
        _indicatorView.frame = CGRectMake(_iconImageView.left + (_iconImageView.width - _indicatorView.width) / 2,
                                          _iconImageView.top + (_iconImageView.height - _indicatorView.height) / 2,
                                          _indicatorView.width,
                                          _indicatorView.height);
        
        _nickNameLabel.text = _userInfo.screenName;
        if (!_userInfo.verified)
        {
            _descLabel.text = _userInfo.description;
            if (_userInfo.verifiedType == 220)
            {
                //达人
                _vipImageView.image = [UIImage imageNamed:@"Grassroot.png"];
                _vipImageView.hidden = NO;
            }
            else
            {
                _vipImageView.hidden = YES;
            }
        }
        else
        {
            _descLabel.text = _userInfo.verifiedReason;
            
            switch (_userInfo.verifiedType)
            {
                case 0:
                    //个人认证
                    _vipImageView.image = [UIImage imageNamed:@"Vip.png"];
                    _vipImageView.hidden = NO;
                    break;
                case 5:
                case 2:
                case 3:
                    //企业认证
                    _vipImageView.image = [UIImage imageNamed:@"EnterpriseVip.png"];
                    _vipImageView.hidden = NO;
                    break;
                default:
                    _vipImageView.hidden = YES;
                    break;
            }
        }
        
        _vipImageView.frame = CGRectMake(_iconImageView.right - 2 * _vipImageView.width / 3,
                                         _iconImageView.bottom - 2 * _vipImageView.height / 3,
                                         VIP_ICON_WIDTH,
                                         VIP_ICON_HEIGHT);
        
        [_nickNameLabel sizeToFit];
        [_descLabel sizeToFit];
        
        if ([_userInfo.gender isEqualToString:@"m"])
        {
            _sexImageView.image = [UIImage imageNamed:@"MaleIcon.png"];
            _sexImageView.hidden = NO;
        }
        else if ([_userInfo.gender isEqualToString:@"f"])
        {
            _sexImageView.image = [UIImage imageNamed:@"FemaleIcon.png"];
            _sexImageView.hidden = NO;
        }
        else
        {
            _sexImageView.image = nil;
            _sexImageView.hidden = YES;
        }
        
        CGFloat top = (self.contentView.height - _nickNameLabel.height - _descLabel.height - VERTICAL_GAP) / 2;
        CGFloat width = self.contentView.width - _iconImageView.right - HORIZONTAL_GAG - RIGHT_PADDING;
        CGFloat nickNameWidth = _nickNameLabel.width;
        if (!_sexImageView.hidden)
        {
            if(nickNameWidth + GENDER_ICON_WIDTH > width)
            {
                nickNameWidth = width - GENDER_ICON_WIDTH;
                
            }
        }
        else
        {
            if(nickNameWidth > width)
            {
                nickNameWidth = width;
                
            }
        }
        
        
        _nickNameLabel.frame = CGRectMake(_iconImageView.right + HORIZONTAL_GAG,
                                          top,
                                          nickNameWidth,
                                          _nickNameLabel.height);
        _descLabel.frame = CGRectMake(_iconImageView.right + HORIZONTAL_GAG,
                                      top + _nickNameLabel.height + VERTICAL_GAP,
                                      width,
                                      _descLabel.height);
        _sexImageView.frame = CGRectMake(_nickNameLabel.right,
                                         _nickNameLabel.top + (_nickNameLabel.height - GENDER_ICON_HEIGHT) / 2,
                                         GENDER_ICON_WIDTH,
                                         GENDER_ICON_HEIGHT);
    }
}

#pragma mark - Private

- (void)iconLoadCompleteHandler:(NSNotification *)notif
{
    _iconImageView.image = _loader.content;
    [_indicatorView stopAnimating];
    
    [_loader removeAllNotificationWithTarget:self];
    SAFE_RELEASE(_loader);
}

- (void)iconLoadErrorHandler:(NSNotification *)notif
{
    [_indicatorView stopAnimating];
    
    [_loader removeAllNotificationWithTarget:self];
    SAFE_RELEASE(_loader);
}

@end
