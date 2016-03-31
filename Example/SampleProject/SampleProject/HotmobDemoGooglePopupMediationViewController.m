//
//  HotmobDemoGooglePopupMediationViewController.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 26/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "HotmobDemoGooglePopupMediationViewController.h"

@interface HotmobDemoGooglePopupMediationViewController () <GADInterstitialDelegate>

@end

@implementation HotmobDemoGooglePopupMediationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    self.interstitial = [[DFPInterstitial alloc] initWithAdUnitID:@"/13648685/hotmob_ios_sdk_demo_popup"];
    _interstitial.delegate = self;
    [_interstitial loadRequest:[DFPRequest request]];
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
    self.interstitial = nil;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    // Show immediately!
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
}

@end
