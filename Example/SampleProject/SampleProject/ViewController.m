//
//  ViewController.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 15/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "ViewController.h"
#import "HotmobManager.h"

#import "HotmobDemoGoogleBannerMediationViewController.h"
#import "HotmobDemoGooglePopupMediationViewController.h"

@interface ViewController () <HotmobManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemsArray = @[@"Banner", @"Popups", @"Video Ads Banner", @"Multiple Banners", @"Mediation Banner", @"Mediation Popup"];
    
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [self createBanner];
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
    self.itemsArray = nil;
    self.tableView = nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"normalCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    cell.textLabel.text = [_itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        default:
        case 0:
            [self performSegueWithIdentifier:@"pushToBannerView" sender:self.view];
            break;
        case 1:
            [self performSegueWithIdentifier:@"pushToPopupView" sender:self.view];
            break;
        case 2:
            [self performSegueWithIdentifier:@"pushToVideoBannerView" sender:self.view];
            break;
        case 3:
            [self performSegueWithIdentifier:@"pushToMultipleBannerView" sender:self.view];
            break;
        case 4:{
            HotmobDemoGoogleBannerMediationViewController *controller = [[HotmobDemoGoogleBannerMediationViewController alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 5:{
            HotmobDemoGooglePopupMediationViewController *controller = [[HotmobDemoGooglePopupMediationViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - Create Hotmob Banner method

- (void) createBanner{
    /*
     set the banner width
     */
    CGRect bannerRect = CGRectMake(0, 0, self.view.frame.size.width, 0);
    
    /*
     create banner object
     adCode "hotmob_uat_iphone_image_inapp_banner", the identifier let hotmob  know the banner position
     identifier "mainPageFooterBanner"     , the identifier let hotmob sdk to reuse banner object
     */
    UIView *bannerView = [HotmobManager getBanner:self
                                         delegate:self
                                       identifier:@"MainPageFooterBanner"
                                           adCode:@"hotmob_iphone_sample_dynamic"
                                             size:bannerRect];
    /*
     add the banner to current view
     */
    [self.view addSubview:bannerView];
}

#pragma mark - HotmobManagerDelegate
- (void)willShowBanner:(id)obj {
    /*
     when banner object return.
     this delegate will be call
     Publisher should resize the layout to fit the banner view
     */
    UIView *view = obj;
    int offset = 0;
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets newSafeArea = self.view.safeAreaInsets;
        offset = newSafeArea.bottom;
    }
#endif
    view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame) - offset, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - view.frame.size.height - offset);
}

- (void)didHideBanner:(id)obj {
    /*
     when banner dismiss.
     this delegate will be call
     Publisher should resize the layout to fit the banner view
     */
    UIView *view = obj;
    int offset = 0;
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets newSafeArea = self.view.safeAreaInsets;
        offset = newSafeArea.bottom;
    }
#endif
    view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame) - offset, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - view.frame.size.height - offset);
}

- (void)openNoAdCallback:(id)obj {
    /*
     when banner object return.
     this delegate will be call
     Publisher should resize the layout to fit the banner view
     */
    UIView *view = obj;
    int offset = 0;
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets newSafeArea = self.view.safeAreaInsets;
        offset = newSafeArea.bottom;
    }
#endif
    view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame) - offset, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - view.frame.size.height - offset);
}

@end
