//
//  HotmobDemoGoogleBannerMediationViewController.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 26/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "HotmobDemoGoogleBannerMediationViewController.h"

@interface HotmobDemoGoogleBannerMediationViewController ()<GADBannerViewDelegate, GADAdSizeDelegate>

@property (nonatomic, strong) UITextView *logTextView;

@end

@implementation HotmobDemoGoogleBannerMediationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    self.bannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:CGPointMake(0, 0)];
    _bannerView.delegate = self;
    _bannerView.adSizeDelegate = self;
    
    _bannerView.adUnitID = @"/13648685/hotmob_ios_sdk_demo_banner";
    _bannerView.rootViewController = self;
    [_bannerView loadRequest:[DFPRequest request]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HotmobManager setCurrentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.bannerView = nil;
}

#pragma mark - Interface orientations
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"adViewDidReceived:");
    if ([bannerView.adNetworkClassName isEqual:@"GADMAdapterCustomEvents"]) {
        // Tune size
        //        bannerView.mediatedAdView
        [self.view addSubview:bannerView.mediatedAdView];
    } else {
        [self.view addSubview:bannerView];
    }
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"adView:didFailToReceiveAdWithError:");
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillPresentScreen:");
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillDismissScreen:");
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewDidDismissScreen");
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillLeaveApplication");
}

#pragma mark - GADAdSizeDelegate
- (void)adView:(GADBannerView *)bannerView willChangeAdSizeTo:(GADAdSize)size
{
    NSLog(@"adView:willChangeAdSizeTo:");
}

@end
