//
//  AGGetUserInfoViewController.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-4-24.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AGGetUserInfoViewController.h"
#import <AGCommon/UIImage+Common.h>
#import <AGCommon/UIDevice+Common.h>
#import <AGCommon/UINavigationBar+Common.h>
#import "IIViewDeckController.h"
#import "AGUserInfoViewController.h"
#import <AGCommon/NSString+Common.h>

#define LEFT_PADDING 10.0
#define RIGHT_PADDING 10.0
#define HORIZONTAL_GAP 10.0
#define VERTICAL_GAP 10.0

@implementation AGGetUserInfoViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png" bundleName:BUNDLE_NAME]
                           forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
        leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
        [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
        
        if ([UIDevice currentDevice].isPad || [[UIDevice currentDevice].systemVersion versionStringCompare:@"7.0"] != NSOrderedAscending)
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.shadowColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:22];
            self.navigationItem.titleView = label;
            [label release];
        }
        
        self.title = @"获取用户信息";
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    ((UILabel *)self.navigationItem.titleView).text = title;
    [self.navigationItem.titleView sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([[UIDevice currentDevice].systemVersion versionStringCompare:@"7.0"] != NSOrderedAscending)
    {
        [self setExtendedLayoutIncludesOpaqueBars:NO];
        [self setEdgesForExtendedLayout:SSRectEdgeBottom | SSRectEdgeLeft | SSRectEdgeRight];
    }
    
    CGFloat top = VERTICAL_GAP;
    CGFloat buttonW = (self.view.width - LEFT_PADDING - RIGHT_PADDING - HORIZONTAL_GAP) / 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height)];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"新浪微博" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showSinaWeiboUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"腾讯微博" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showTencentWeiboUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"搜狐微博" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showSohuWeiboUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"网易微博" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(show163WeiboUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"豆瓣社区" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showDoubanUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"QQ空间" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showQZoneUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"人人网" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showRenrenUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"开心网" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showKaixinUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"Instapaper" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showInstapaperUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"有道云笔记" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showYoudaoNoteUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"Facebook" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showFacebookUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"Twitter" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showTwitterUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"搜狐随身看" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showSohuKanUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"Google+" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING + buttonW + HORIZONTAL_GAP, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showGooglePlusUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    top += button.height + VERTICAL_GAP;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"LinkedIn" forState:UIControlStateNormal];
    button.frame = CGRectMake(LEFT_PADDING, top, buttonW, 45.0);
    [button addTarget:self action:@selector(showLinkedInUserClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    scrollView.contentSize = CGSizeMake(self.view.width, top += button.height + VERTICAL_GAP);
    [self.view addSubview:scrollView];
    [scrollView release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self layoutView:self.interfaceOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(BOOL)shouldAutorotate
{
    //iOS6下旋屏方法
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //iOS6下旋屏方法
    return SSInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutView:toInterfaceOrientation];
}

- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)layoutPortrait
{
    UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    btn.frame = CGRectMake(btn.left, btn.top, 55.0, 32.0);
    [btn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png"
                                     bundleName:BUNDLE_NAME]
                   forState:UIControlStateNormal];
    
    if ([UIDevice currentDevice].isPad)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadNavigationBarBG.png"]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];
    }
}

- (void)layoutLandscape
{
    if (![UIDevice currentDevice].isPad)
    {
        //iPhone
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        btn.frame = CGRectMake(btn.left, btn.top, 48.0, 24.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"Common_Landscape/NavigationButtonBG.png"
                                         bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
        
        if ([[UIDevice currentDevice] isPhone5])
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG-568h.png"]];
        }
        else
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG.png"]];
        }
    }
    else
    {
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        btn.frame = CGRectMake(btn.left, btn.top, 55.0, 32.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png"
                                         bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadLandscapeNavigationBarBG.png"]];
    }
}

- (void)layoutView:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        [self layoutLandscape];
    }
    else
    {
        [self layoutPortrait];
    }
}

#pragma mark - 获取用户信息接口

- (void)showSinaWeiboUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeSinaWeibo];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showTencentWeiboUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeTencentWeibo];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showSohuWeiboUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeSohuWeibo];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)show163WeiboUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareType163Weibo];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showDoubanUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeDouBan];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showQZoneUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeQQSpace];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showRenrenUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeRenren];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showKaixinUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeKaixin];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showInstapaperUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeInstapaper];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showYoudaoNoteUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeYouDaoNote];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showFacebookUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeFacebook];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showTwitterUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeTwitter];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showSohuKanUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeSohuKan];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showGooglePlusUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeGooglePlus];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

- (void)showLinkedInUserClickHandler:(id)sender
{
    AGUserInfoViewController *vc = [[AGUserInfoViewController alloc] initWithType:ShareTypeLinkedIn];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self presentModalViewController:nvc animated:YES];
    [vc release];
}

@end
