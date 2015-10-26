//
//  BannerViewController.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 15/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "BannerViewController.h"
#import "HotmobManager.h"

@interface BannerViewController () <HotmobManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, weak) UIView *bannerView;
@property (nonatomic, weak) UITableViewCell *bannerViewCell;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableView = nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 11) {
        static NSString *cellIdentifier = @"bannerCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        // Configure the cell...
        if (self.bannerView == nil) {
            self.bannerView = [HotmobManager getBanner:self delegate:self identifier:@"bannerViewSample" adCode:@"hotmob_iphone_sample_dynamic" size:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        }
        
        [HotmobManager transitBanner:_bannerView toCell:cell];
        
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
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 11) {
        return _bannerView.frame.size.height;
    } else {
        return 44;
    }
}

#pragma mark - HotmobManagerDelegate
- (void)didShowBanner:(id)obj
{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)openNoAdCallback:(id)obj
{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

@end
