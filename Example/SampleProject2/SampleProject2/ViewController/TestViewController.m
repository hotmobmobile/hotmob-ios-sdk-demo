//
//  TestViewController.m
//  SampleProject2
//
//  Created by ChoiWing Chiu on 25/1/2016.
//  Copyright © 2016 Hotmob. All rights reserved.
//

#import "TestViewController.h"
#import "HotmobManager.h"

@interface TestViewController () <HotmobManagerDelegate>

@property (nonatomic, weak) UIView *bannerView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect bannerRect = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 0);
    self.bannerView = [HotmobManager getBanner:self
                                        delegate:self
                                      identifier:@"FooterBanner"
                                          adCode:@"hm_chiu_dynamic"
                                            size:bannerRect];
    [self.view addSubview:_bannerView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HotmobManager setCurrentViewController:self];
    [HotmobManager setHotmobBannerDelegate:self];
    [self reloadBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadBanner{
    [HotmobManager refreshBanner:self.bannerView];
}


#pragma mark - HotmobManagerDelegate
- (void)didLoadBanner:(id)obj {
    /*
     when banner object return.
     this delegate will be call
     Publisher should resize the layout to fit the banner view
     */
    NSLog(@"TestViewController - didShowBanner");
    UIView *view = obj;
    view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
}

- (void)openNoAdCallback:(id)obj {
    /*
     when banner object return.
     this delegate will be call
     Publisher should resize the layout to fit the banner view
     */
    NSLog(@"TestViewController - openNoAdCallback");
    UIView *view = obj;
    view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
}

@end
