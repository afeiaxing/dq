//
//  AXStreamDetailViewController.m
//  QYZY
//
//  Created by 22 on 2024/6/15.
//

#import "AXStreamDetailViewController.h"
#import "ZFAVPlayerManager.h"
#import "ZFPlayerControlView.h"

@interface AXStreamDetailViewController ()

@property (nonatomic ,strong) UIView *statusView;

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFAVPlayerManager *playerManager;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation AXStreamDetailViewController

// MARK: lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.playerManager.player pause];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.playerManager.player play];
}

// MARK: private
- (void)setupSubviews{
    self.fd_prefersNavigationBarHidden = true;
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(StatusBarHeight);
    }];
    
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.statusView.mas_bottom);
        make.height.mas_equalTo(ScreenWidth * 9/16);
    }];
    
    /// 播放器相关
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
}


- (void)handleLandscape{
    self.controlView.fullScreenMode = ZFFullScreenModeLandscape;
    [self.player rotateToOrientation:UIInterfaceOrientationLandscapeRight animated:YES completion:nil];
}

- (void)requestData{
    [self.controlView showTitle:@"视频标题" coverURLString:@"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" fullScreenMode:ZFFullScreenModeLandscape];
    self.playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
}

// MARK: setter & getter
- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = UIColor.blackColor;
    }
    return _statusView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.portraitControlView.slider.hidden = true;
        _controlView.portraitControlView.currentTimeLabel.hidden = true;
        _controlView.portraitControlView.totalTimeLabel.hidden = true;
    }
    return _controlView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

- (ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = [[ZFAVPlayerManager alloc] init];
    }
    return _playerManager;
}

@end
