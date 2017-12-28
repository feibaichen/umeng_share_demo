//
//  UMShareTypeViewController.m
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/16/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import "UMShareTypeViewController.h"
#import <UShareUI/UShareUI.h>

#ifdef UM_Swift
#import "UMSocialDemo-Swift.h"
#endif

static NSString* const UMS_Title = @"【演呗】iOS手机客户端";
static NSString* const UMS_Prog_Title = @"【演呗】小程序";
static NSString* const UMS_Text = @"欢迎使用【演呗】iOS客户端，分享生活、分享快乐，精彩内容就在演呗！http://yanbei.anchengxinxi.com/";
//修改分享的文字
static NSString* const UMS_Text_image = @"i欢迎使用【演呗】iOS手机客户端，分享生活、分享快乐，精彩内容就在演呗！http://yanbei.anchengxinxi.com/";
static NSString* const UMS_Web_Desc = @"W欢迎使用【演呗】iOS手机客户端，分享生活、分享快乐，精彩内容就在演呗！";
static NSString* const UMS_Music_Desc = @"M欢迎使用【演呗】iOS手机客户端，分享生活、分享快乐，精彩内容就在演呗！";
static NSString* const UMS_Video_Desc = @"V欢迎使用【演呗】iOS手机客户端，分享生活、分享快乐，精彩内容就在演呗！";

//需要修改分享的网络图片
static NSString* const UMS_THUMB_IMAGE = @"http://yanbei.anchengxinxi.com/Public/Home/images/index_2.png";
static NSString* const UMS_IMAGE = @"http://yanbei.anchengxinxi.com/Public/Home/images/index_2.png";
//修改需要链接的网站
static NSString* const UMS_WebLink = @"http://yanbei.anchengxinxi.com/";//https://bbs.umeng.com/

static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";

typedef NS_ENUM(NSUInteger, UMS_SHARE_TYPE)
{
    UMS_SHARE_TYPE_TEXT,
    UMS_SHARE_TYPE_IMAGE,
    UMS_SHARE_TYPE_IMAGE_URL,
    UMS_SHARE_TYPE_TEXT_IMAGE,
    UMS_SHARE_TYPE_WEB_LINK,
    UMS_SHARE_TYPE_MUSIC_LINK,
    UMS_SHARE_TYPE_MUSIC,
    UMS_SHARE_TYPE_VIDEO_LINK,
    UMS_SHARE_TYPE_VIDEO,
    UMS_SHARE_TYPE_EMOTION,
    UMS_SHARE_TYPE_FILE,
    UMS_SHARE_TYPE_MINI_PROGRAM
};

@interface UMShareTypeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UMSocialPlatformType platform;

@property (nonatomic, strong) NSDictionary *platfomrSupportTypeDict;

@end


@implementation UMShareTypeViewController

- (instancetype)initWithType:(UMSocialPlatformType)type
{
    if (self = [super init]) {
        self.platform = type;
        [self initPlatfomrSupportType];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *platformName = nil;
    NSString *iconName = nil;
    [UMSocialUIUtility configWithPlatformType:self.platform withImageName:&iconName withPlatformName:&platformName];
    self.titleString = [NSString stringWithFormat:@"分享到%@", platformName];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UMS_SHARE_TBL_CELL];

    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.bounds;
}

- (void)initPlatfomrSupportType
{
    self.platfomrSupportTypeDict =
    @{
      @(UMSocialPlatformType_WechatSession): @[@(UMS_SHARE_TYPE_MINI_PROGRAM), @(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_EMOTION), @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_WechatTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_WechatFavorite): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_Sina): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_QQ): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Qzone): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Tim): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_AlipaySession): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_DingDing): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK)],
      
      @(UMSocialPlatformType_LaiWangSession): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_LaiWangTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_YixinSession): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_YixinTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_YixinFavorite): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Douban): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Renren): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_TencentWb): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Linkedin): @[@(UMS_SHARE_TYPE_TEXT), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Facebook): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Twitter): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Instagram): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_KakaoTalk): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Line): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Tumblr): @[@(UMS_SHARE_TYPE_TEXT)],
      
      @(UMSocialPlatformType_Pinterest): @[@(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_Whatsapp): @[@(UMS_SHARE_TYPE_TEXT), @(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_Flickr): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_Sms): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Email): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_FILE)],
      @(UMSocialPlatformType_YouDaoNote): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_FILE)],
      @(UMSocialPlatformType_EverNote): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK),  @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_GooglePlus): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      @(UMSocialPlatformType_Pocket): @[@(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
       @(UMSocialPlatformType_DropBox): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE),@(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK),@(UMS_SHARE_TYPE_FILE)],
      @(UMSocialPlatformType_VKontakte): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE),@(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_FaceBookMessenger): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL),  @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      };
}

- (NSString *)typeNameWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            return @"纯文本";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            return @"本地图片";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            return @"HTTPS网络图片";
        }
            break;
        case UMS_SHARE_TYPE_TEXT_IMAGE:
        {
            if (self.platform == UMSocialPlatformType_Linkedin) {
                return @"文本+HTTPS图片";
            }
            return @"文本+图片";
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            return @"网页链接";
        }
            break;
        case UMS_SHARE_TYPE_MUSIC_LINK:
        {
            return @"音乐链接";
        }
            break;
        case UMS_SHARE_TYPE_MUSIC:
        {
            return @"本地音乐";
        }
            break;
        case UMS_SHARE_TYPE_VIDEO_LINK:
        {
            return @"视频连接";
        }
            break;
        case UMS_SHARE_TYPE_VIDEO:
        {
            return @"本地视频";
        }
            break;
        case UMS_SHARE_TYPE_EMOTION:
        {
            return @"Gif表情";
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            return @"文件";
        }
        case UMS_SHARE_TYPE_MINI_PROGRAM:
        {
            return @"微信小程序";
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)shareWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            [self shareTextToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            [self shareImageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            [self shareImageURLToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_TEXT_IMAGE:
        {
            [self shareImageAndTextToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            [self shareWebPageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MUSIC_LINK:
        {
            [self shareMusicToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MUSIC:
        {
//            [self shareLocalMusicToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_VIDEO_LINK:
        {
            [self shareVedioToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_VIDEO:
        {
//            [self shareLocalVedioToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_EMOTION:
        {
            [self shareEmoticonToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            [self shareFileToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MINI_PROGRAM:
        {
            [self shareMiniProgramToPlatformType:self.platform];
        }
            break;
        default:
            break;
    }
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];
    return typeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UMS_SHARE_TBL_CELL];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.34 green:.35 blue:.3 alpha:1];
    
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];

    cell.textLabel.text = [self typeNameWithType:[typeList[indexPath.row] integerValue]];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:[self resizeImage:[UIImage imageNamed:@"access"]
                                                                         size:CGSizeMake(8.f, 14.f)]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];

    [self shareWithType:[typeList[indexPath.row] integerValue]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}


#pragma mark - share type
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = UMS_Text;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

     
//分享小程序
- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:UMS_Prog_Title descr:UMS_Text thumImage:[UIImage imageNamed:@"icon"]];
    shareObject.webpageUrl = @"http://sdk.umsns.com/download/demo/";
    shareObject.userName = @"gh_3ac2059ac66f";
    shareObject.path = @"pages/page10007/page10007";
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}
  
         
//分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];//icon
    
    [shareObject setShareImage:[UIImage imageNamed:@"shareyanbei.jpg"]];//logo
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

//分享网络图片
- (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = UMS_THUMB_IMAGE;
    
    [shareObject setShareImage:UMS_IMAGE];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

//分享图片和文字
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = UMS_Text_image;
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    if (platformType == UMSocialPlatformType_Linkedin) {
        // linkedin仅支持URL图片
        shareObject.thumbImage = UMS_THUMB_IMAGE;
        [shareObject setShareImage:UMS_IMAGE];
    } else {
        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        shareObject.shareImage = [UIImage imageNamed:@"logo"];
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:UMS_Title descr:UMS_Web_Desc thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = UMS_WebLink;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

//音乐分享
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:UMS_Title descr:UMS_Music_Desc thumImage:thumbURL];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    shareObject.musicDataUrl = @"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
    
}
//视频分享
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:UMS_Title descr:UMS_Video_Desc thumImage:thumbURL];
    //设置视频网页播放地址
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

/*
- (void)shareLocalVedioToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    //设置视频网页播放地址
    //shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"videoviewdemo" withExtension:@"mp4"];
    NSData* videoData = [[NSData alloc] initWithContentsOfURL:bundleURL];
    shareObject.videoData = videoData;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
*/

- (void)shareEmoticonToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareEmotionObject *shareObject = [UMShareEmotionObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6"
                                                         ofType:@"gif"];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    shareObject.emotionData = emoticonData;
    
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    NSLog(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    NSLog(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    NSLog(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

- (void)shareFileToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareFileObject *shareObject = [UMShareFileObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    
    NSString *kFileExtension = @"txt";
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"umengFile"
                                                         ofType:kFileExtension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    shareObject.fileData = fileData;
    shareObject.fileExtension = kFileExtension;
    
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    NSLog(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    NSLog(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    NSLog(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
    
}

#define BUFFER_SIZE 1024 * 100
//微信官方不推荐使用
- (void)shareExternAppToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareExtendObject *shareObject = [UMShareExtendObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    shareObject.url =  @"http://weixin.qq.com";
    shareObject.extInfo = @"<xml>extend info</xml>";
    shareObject.fileData = data;
    
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}



- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    //Share succeed改为：成功
    if (!error) {
        result = [NSString stringWithFormat:@"成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        //Share fail with error code修改为：分享失败错误码
        if (error) {
            result = [NSString stringWithFormat:@"分享失败错误码: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"失败"];//Share succeed改为：失败
        }
    }
    //sure 改为中文确定。share改为分享
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"确定", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}


- (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImage;
}

@end
