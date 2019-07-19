//
//  TestMediationTableViewController.m
//  SampleProject2
//
//  Created by ChoiWing Chiu on 26/1/2016.
//  Copyright © 2016 Hotmob. All rights reserved.
//

#import "TestMediationTableViewController.h"

@interface TestMediationTableViewController () <GADBannerViewDelegate, GADAdSizeDelegate>
@property (strong, nonatomic) DFPBannerView *bannerView;
@property (nonatomic, weak) UITableViewCell *bannerViewCell;
@end

@implementation TestMediationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HotmobManager setCurrentViewController:self];
    [self createAdmobBanner];
}

- (void) viewDidDisappear:(BOOL)animated{
    [self.bannerView performSelector:@selector(removeFromSuperview)];
    self.bannerView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createAdmobBanner{
    self.bannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:CGPointMake(0, 0)];
    _bannerView.delegate = self;
    _bannerView.adSizeDelegate = self;
    
    _bannerView.adUnitID = @"/13648685/ios_sdk_videoads_banner_test";
    _bannerView.rootViewController = self;
    [_bannerView loadRequest:[DFPRequest request]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 11) {
        static NSString *cellIdentifier = @"bannerCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if ([_bannerView.adNetworkClassName isEqual:@"GADMAdapterCustomEvents"]){
            [cell.contentView addSubview:self.bannerView.mediatedAdView];
        }else{
            [cell.contentView addSubview:self.bannerView];
        }
        
        
        self.bannerViewCell = cell;
        
        return cell;
    } else {
        static NSString *cellIdentifier = @"normalCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        // Configure the cell...
        cell.textLabel.text = [NSString stringWithFormat:@"Item #%ld", indexPath.row];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 11) {
        if ([_bannerView.adNetworkClassName isEqual:@"GADMAdapterCustomEvents"]){
            return _bannerView.mediatedAdView.frame.size.height;
        }else{
            return _bannerView.frame.size.height;
        }
    } else {
        return 44;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_bannerView.adNetworkClassName isEqual:@"GADMAdapterCustomEvents"]) {
        [HotmobManager calculateBannerPositionWithView:scrollView cellItems:self.tableView.visibleCells forVideoAdsBannerCell:_bannerViewCell andBanner:self.bannerView.mediatedAdView];
    }
}



#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"adViewDidReceived:");
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
