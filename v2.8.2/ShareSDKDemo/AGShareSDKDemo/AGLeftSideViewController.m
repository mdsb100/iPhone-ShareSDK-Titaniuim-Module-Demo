//
//  AGLeftSideViewController.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-1-30.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AGLeftSideViewController.h"
#import "AGAppDelegate.h"
#import <AGCommon/UIColor+Common.h>
#import <ShareSDK/ShareSDK.h>
#import "SVWebViewController.h"
#import "AGApiViewController.h"
#import "AGAuthViewController.h"
#import "QQDemoViewController.h"
#import "AGViewController.h"
#import "AGLeftSideTableCell.h"
#import "AGCustomViewController.h"
#import "AGAppDelegate.h"
#import "AGSinaWeiboViewController.h"
#import "AGGetUserInfoViewController.h"
#import "AGGetCredentialViewController.h"
#import "AGCallAPIViewController.h"
#import <AGCommon/NSString+Common.h>

#define TABLE_CELL @"tableCell"

@interface AGLeftSideViewController ()

@end

@implementation AGLeftSideViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        _appDelegate = (AGAppDelegate *)[UIApplication sharedApplication].delegate;
        
        // Custom initialization
        
        _sectionView = [[AGSectionView alloc] initWithFrame:CGRectZero];
        _sectionView.titleLabel.text = @"更多";
    }
    return self;
}

- (void)dealloc
{
    SAFE_RELEASE(_sectionView);
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if ([[UIDevice currentDevice].systemVersion versionStringCompare:@"7.0"] != NSOrderedAscending)
    {
        [self setExtendedLayoutIncludesOpaqueBars:NO];
        [self setEdgesForExtendedLayout:SSRectEdgeBottom | SSRectEdgeLeft | SSRectEdgeRight];
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.width, self.view.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    [_tableView release];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
        case 1:
            return 5;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL];
    if (cell == nil)
    {
        cell = [[[AGLeftSideTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_CELL] autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
//        cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
        
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        lineView.frame = CGRectMake(0.0, cell.contentView.height - lineView.height , cell.contentView.width, lineView.height);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
        [lineView release];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"接口";
                    break;
                case 1:
                    cell.textLabel.text = @"授权";
                    break;
                case 2:
                    cell.textLabel.text = @"微信";
                    break;
                case 3:
                    cell.textLabel.text = @"QQ";
                    break;
                case 4:
                    cell.textLabel.text = @"新浪微博";
                    break;
                case 5:
                    cell.textLabel.text = @"演示";
                    break;
                case 6:
                    cell.textLabel.text = @"自定义分享界面";
                    break;
                case 7:
                    cell.textLabel.text = @"获取用户信息";
                    break;
                case 8:
                    cell.textLabel.text = @"获取授权信息";
                    break;
                case 9:
                    cell.textLabel.text = @"调用API";
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"关注新浪微博";
                    break;
                case 1:
                    cell.textLabel.text = @"关注腾讯微博";
                    break;
                case 2:
                    cell.textLabel.text = @"关注官方微信";
                    break;
                case 3:
                    cell.textLabel.text = @"访问官方网站";
                    break;
                case 4:
                {
                    NSBundle *bundle = [NSBundle mainBundle];
                    cell.textLabel.text = [NSString stringWithFormat:@"版本 ver%@",[[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
                    break;
                }
                default:
                    break;
            }
        }
        default:
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return @"更多";
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return _sectionView;
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return tableView.sectionHeaderHeight;
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            self.view.userInteractionEnabled = NO;
            switch (indexPath.row)
            {
                case 0:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *apiVC = [[[AGApiViewController alloc] init] autorelease];
                        apiVC.title = @"接口";
                        UINavigationController *navApiVC = [[[UINavigationController alloc] initWithRootViewController:apiVC] autorelease];
                        self.viewDeckController.centerController = navApiVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 1:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *authVC = [[[AGAuthViewController alloc] init] autorelease];
                        authVC.title = @"授权";
                        UINavigationController *navAuthVC = [[[UINavigationController alloc] initWithRootViewController:authVC] autorelease];
                        self.viewDeckController.centerController = navAuthVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 2:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *weixinVC = [[[WeChatViewController alloc] init] autorelease];
                        ((WeChatViewController *)weixinVC).parentController = self.viewDeckController;
                        UINavigationController *navWeiXinVC = [[[UINavigationController alloc] initWithRootViewController:weixinVC] autorelease];

                        self.viewDeckController.centerController = navWeiXinVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 3:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        UIViewController *qqVC = [[[QQDemoViewController alloc] init] autorelease];
                        UINavigationController *navQQVC = [[[UINavigationController alloc] initWithRootViewController:qqVC] autorelease];
                        self.viewDeckController.centerController = navQQVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 4:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *shareVC = [[[AGSinaWeiboViewController alloc] init] autorelease];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:shareVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 5:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *shareVC = [[[AGViewController alloc] init] autorelease];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:shareVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 6:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *shareVC = [[[AGCustomViewController alloc] init] autorelease];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:shareVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 7:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *shareVC = [[[AGGetUserInfoViewController alloc] init] autorelease];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:shareVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 8:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *shareVC = [[[AGGetCredentialViewController alloc] init] autorelease];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:shareVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 9:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        UIViewController *shareVC = [[[AGCallAPIViewController alloc] init] autorelease];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:shareVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                                 allowCallback:YES
                                                                 authViewStyle:SSAuthViewStyleFullScreenPopup
                                                                  viewDelegate:nil
                                                       authManagerViewDelegate:_appDelegate.viewDelegate];
            
            //在授权页面中添加关注官方微博
            [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                            nil]];
            
            switch (indexPath.row)
            {
                case 0:
                {
                    [ShareSDK followUserWithType:ShareTypeSinaWeibo
                                           field:@"ShareSDK"
                                       fieldType:SSUserFieldTypeName
                                     authOptions:authOptions
                                    viewDelegate:_appDelegate.viewDelegate
                                          result:^(SSResponseState state, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                              
                                              NSString *msg = nil;
                                              if (state == SSResponseStateSuccess)
                                              {
                                                  msg = @"关注成功";
                                              }
                                              else if (state == SSResponseStateFail)
                                              {
                                                  switch ([error errorCode])
                                                  {
                                                      case 20506:
                                                          msg = @"已关注";
                                                          break;
                                                          
                                                      default:
                                                          msg = [NSString stringWithFormat:@"关注失败:%@", error.errorDescription];
                                                          break;
                                                  }
                                              }
                                              
                                              if (msg)
                                              {
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                                      message:msg
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"知道了"
                                                                                            otherButtonTitles:nil];
                                                  [alertView show];
                                                  [alertView release];
                                              }
                                          }];
                    break;
                }
                case 1:
                {
                    [ShareSDK followUserWithType:ShareTypeTencentWeibo
                                           field:@"ShareSDK"
                                       fieldType:SSUserFieldTypeName
                                     authOptions:authOptions
                                    viewDelegate:_appDelegate.viewDelegate
                                          result:^(SSResponseState state, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                             
                                              NSString *msg = nil;
                                              if (state == SSResponseStateSuccess)
                                              {
                                                  msg = @"关注成功";
                                              }
                                              else if (state == SSResponseStateFail)
                                              {
                                                  switch ([error errorCode])
                                                  {
                                                      case 80103:
                                                          msg = @"已关注";
                                                          break;
                                                          
                                                      default:
                                                          msg = [NSString stringWithFormat:@"关注失败:%@", error.errorDescription];
                                                          break;
                                                  }
                                              }
                                              
                                              if (msg)
                                              {
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                                      message:msg
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"知道了"
                                                                                            otherButtonTitles:nil];
                                                  [alertView show];
                                                  [alertView release];
                                              }
                                          }];
                    break;
                }
                case 2:
                {
                    [ShareSDK followUserWithType:ShareTypeWeixiSession
                                           field:@"http://weixin.qq.com/r/HHURHl7EjmDxh099nyA4"
                                       fieldType:SSUserFieldTypePath
                                     authOptions:nil
                                    viewDelegate:nil
                                          result:^(SSResponseState state, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                              
                                              NSLog(@"state == %d", state);
                                              
                                          }];
                    break;
                }
                case 3:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        SVWebViewController *vc = [[SVWebViewController alloc] initWithAddress:@"http://shareSDK.cn"];
                        vc.title = @"官方网站";
                        UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
                        [vc release];
                        self.viewDeckController.centerController = navController;
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

@end
