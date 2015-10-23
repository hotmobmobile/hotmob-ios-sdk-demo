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
    // Load popup
    [HotmobManager getPopup:self delegate:self identifier:@"popViewNormalBanner" adCode:[@"hotmob_uat_iphone_image_inapp_popup" stringByReplacingOccurrencesOfString:@"iphone" withString:@"iphone5"] showWhenResume:NO];
}

- (IBAction)videoPopupClick:(id)sender {
    // Load popup
    [HotmobManager getPopup:self delegate:self identifier:@"popViewVideoBanner" adCode:[@"hotmob_uat_iphone_videoads_inapp_popup" stringByReplacingOccurrencesOfString:@"iphone" withString:@"iphone5"] showWhenResume:NO];
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
