//
//  TestTableViewController.m
//  SampleProject2
//
//  Created by ChoiWing Chiu on 25/1/2016.
//  Copyright © 2016 Hotmob. All rights reserved.
//

#import "TestTableViewController.h"
#import "HotmobManager.h"

@interface TestTableViewController () <HotmobManagerDelegate>
@property (nonatomic, weak) UIView *bannerView;
@property (nonatomic, weak) UITableViewCell *bannerViewCell;
@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HotmobManager setCurrentViewController:self];
}

- (void)dealloc
{
    self.bannerView = nil;
    self.bannerViewCell = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadBanner{
    [HotmobManager refreshBanner:_bannerView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 11) {
        static NSString *cellIdentifier = @"bannerCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        // Configure the cell...
        if (self.bannerView == nil) {
            self.bannerView = [HotmobManager getBanner:self delegate:self identifier:@"hotmob_iphone_sample_video_banner2" adCode:@"hotmob_iphone_sample_dynamic" size:CGRectMake(0, 0, self.view.frame.size.width, 0)];
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
        return _bannerView.frame.size.height;
    } else {
        return 44;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [HotmobManager calculateBannerPositionWithView:scrollView cellItems:self.tableView.visibleCells forVideoAdsBannerCell:_bannerViewCell andBanner:_bannerView];
}

#pragma mark - HotmobManagerDelegate
- (void)didShowBanner:(id)obj
{
    NSLog(@"TestTableViewController - didShowBanner");
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didHideBanner:(id)obj{
    NSLog(@"TestTableViewController - didHideBanner");
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)openNoAdCallback:(id)obj
{
    NSLog(@"TestTableViewController - openNoAdCallback");
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}


@end
