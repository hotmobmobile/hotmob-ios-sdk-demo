//
//  multipleBannerViewController.m
//  SampleProject
//
//  Created by Choi Wing Chiu on 16/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import "multipleBannerViewController.h"
#import "HotmobManager.h"

@interface multipleBannerViewController () <HotmobManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation multipleBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 51;
    
    self.bannerViewsArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HotmobManager setCurrentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bannerViewsArray removeAllObjects];
    self.bannerViewsArray = nil;
    self.tableView = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 8 == 2) {
        NSString *cellIdentifier = [NSString stringWithFormat:@"bannerCell_%ld", (long)indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        // Configure the cell...
        UIView *bannerView = nil;
        
        for (UIView *_bannerView in _bannerViewsArray) {
            if ([[HotmobManager getIdentifier:_bannerView] isEqualToString:cellIdentifier]) {
                bannerView = _bannerView;
                break;
            }
        }
        
        NSString *adCode = @"hotmob_iphone_sample_dynamic";
        
        if (bannerView == nil) {
            bannerView = [HotmobManager getBanner:self delegate:self identifier:cellIdentifier adCode:adCode size:CGRectMake(0, 0, self.view.frame.size.width, 0)];
            [_bannerViewsArray insertObject:bannerView atIndex:indexPath.row];
        }
        
        [HotmobManager transitBanner:bannerView toCell:cell];
        
        return cell;
    } else {
        static NSString *cellIdentifier = @"normalCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        // Configure the cell...
        cell.textLabel.text = [NSString stringWithFormat:@"Item #%ld", (long)indexPath.row];
        
        // Search for items. if exists, don't add.
        @try {
            if (![[_bannerViewsArray objectAtIndex:indexPath.row] isEqual:[NSNull null]]) {
                [_bannerViewsArray insertObject:[NSNull null] atIndex:indexPath.row];
            }
        }
        @catch (NSException *exception) {
            [_bannerViewsArray insertObject:[NSNull null] atIndex:indexPath.row];
        }
        @finally {
            //NULL
        }
        
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
    if (indexPath.row % 8 == 2) {
        // Get Banner
        UIView *bannerView = nil;
        NSString *identifier = [NSString stringWithFormat:@"bannerCell_%ld", indexPath.row];
        
        for (UIView *_bannerView in _bannerViewsArray) {
            if ([[HotmobManager getIdentifier:_bannerView] isEqualToString:identifier]) {
                bannerView = _bannerView;
                
                break;
            }
        }
        
        if (bannerView != nil) {
            return bannerView.frame.size.height;
        } else {
            return 0;
        }
    } else {
        return 44;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%@ - scrollViewDidEndDragging", NSStringFromClass(self.class));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_bannerViewsArray != nil) {
        
        @try {
            for (int i = 0; i < _bannerViewsArray.count; i++) {
                UIView *bannerView = [_bannerViewsArray objectAtIndex:i];
                UITableViewCell *bannerViewCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                [HotmobManager calculateBannerPositionWithView:scrollView cellItems:self.tableView.visibleCells forVideoAdsBannerCell:bannerViewCell andBanner:bannerView];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
}

#pragma mark - HotmobManagerDelegate
- (void)didShowBanner:(id)obj
{
    // Get Banner position in a table view.
    NSUInteger countId = [_bannerViewsArray indexOfObject:obj];
    NSLog(@"countId: %ld", countId);
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:countId inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
