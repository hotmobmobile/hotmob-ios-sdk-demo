//
//  ViewController.m
//  SampleProject2
//
//  Created by ChoiWing Chiu on 25/1/2016.
//  Copyright © 2016 Hotmob. All rights reserved.
//

#import "ViewController.h"
#import "HotmobManager.h"

@interface ViewController () <HotmobManagerDelegate>
@property (nonatomic) CAPSPageMenu *pageMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageView];
    [self initPopup];
    self.title = @"HotmobSDK Demo";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor]};
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPageView{
    TestTableViewController *controller1 = [[TestTableViewController alloc]initWithNibName:@"TestTableViewController" bundle:nil];
    controller1.title = @"Table";
    TestCollectionViewController *controller2 = [[TestCollectionViewController alloc]initWithNibName:@"TestCollectionViewController" bundle:nil];
    controller2.title = @"CollectionView";
    TestViewController *controller3 = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    controller3.title = @"View";
    TestMediationTableViewController *controller4 = [[TestMediationTableViewController alloc] init];
    controller4.title = @"Mediation";
    
    NSArray *controllerArray = @[controller1, controller2, controller3, controller4];
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor orangeColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:13.0],
                                 CAPSPageMenuOptionMenuHeight: @(40.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(90.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    [self.view addSubview:_pageMenu.view];
}

- (void)initPopup{
    NSString *adcode = @"hotmob_iphone_sample_popup";
    
    [HotmobManager setDebug:NO];
    
    [HotmobManager getPopup:self delegate:self identifier:@"launch" adCode:adcode showWhenResume:YES autoRefresh:YES];
}

#pragma mark - HotmobManagerDelegate

- (void)didLoadBanner:(id)obj
{
    NSLog(@"ViewController didLoadBanner: %@", obj);
}

- (void)willShowBanner:(id)obj
{
    NSLog(@"ViewController willShowBanner: %@", obj);
}

- (void)didShowBanner:(id)obj
{
    NSLog(@"ViewController didShowBanner: %@", obj);
}

- (void)willHideBanner:(id)obj
{
    NSLog(@"ViewController willHideBanner: %@", obj);
    [[_pageMenu.controllerArray objectAtIndex:_pageMenu.currentPageIndex] viewWillAppear:YES];
}

- (void)didHideBanner:(id)obj
{
    NSLog(@"ViewController didHideBanner: %@", obj);
}

- (void)didLoadFailed:(id)obj
{
    NSLog(@"ViewController didLoadFailed: %@", obj);
}

- (void)didClick:(id)obj
{
    NSLog(@"ViewController didClick: %@", obj);
}

- (void)openNoAdCallback:(id)obj
{
    NSLog(@"ViewController openNoAdCallback: %@", obj);
}

- (void)openInternalCallback:(id)obj
{
    NSLog(@"ViewController openInternalCallback: %@", obj);
}

- (void)willShowInAppBrowser:(id)obj
{
    NSLog(@"ViewController willShowInAppBrowser: %@", obj);
}

- (void)didShowInAppBrowser:(id)obj
{
    NSLog(@"ViewController didShowInAppBrowser: %@", obj);
}

- (void)willCloseInAppBrowser:(id)obj
{
    NSLog(@"ViewController willCloseInAppBrowser: %@", obj);
}

- (void)didCloseInAppBrowser:(id)obj
{
    NSLog(@"ViewController didCloseInAppBrowser: %@", obj);
}
@end
