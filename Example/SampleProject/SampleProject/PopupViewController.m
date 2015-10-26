//
//  PopupViewController.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 16/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "PopupViewController.h"
#import "HotmobManager.h"

@interface PopupViewController () <HotmobManagerDelegate>

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)normalPopupClick:(id)sender {
    
    NSString *adcode = @"hotmob_iphone_sample_popup";
    if (!IS_IPHONE_4_OR_LESS) {
        adcode = [adcode stringByReplacingOccurrencesOfString:@"iphone" withString:@"iphone5"];
    }
    
    // Load popup
    [HotmobManager getPopup:self delegate:self identifier:@"popViewNormalBanner" adCode:adcode showWhenResume:NO];
}

- (IBAction)videoPopupClick:(id)sender {
    // Load popup
    [HotmobManager getPopup:self delegate:self identifier:@"popViewVideoBanner" adCode:@"hotmob_iphone_sample_video_popup" showWhenResume:NO];
}

#pragma mark - HotmobManagerDelegate
- (void)didLoadBanner:(id)obj
{
    NSLog(@"didLoadBanner: %@", obj);
}

- (void)openNoAdCallback:(id)obj
{
    NSLog(@"openNoAdCallback: %@", obj);
}

@end
