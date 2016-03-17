//
//  TestCollectionViewController.m
//  SampleProject2
//
//  Created by ChoiWing Chiu on 25/1/2016.
//  Copyright © 2016 Hotmob. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "HotmobManager.h"

@interface TestCollectionViewController () <HotmobManagerDelegate>
@property (nonatomic) NSArray *moodArray;
@property (nonatomic) NSArray *backgroundPhotoNameArray;
@property (nonatomic) NSArray *photoNameArray;

@property (nonatomic) NSUInteger count;
@property (nonatomic, weak) UIView *bannerView;
@property (nonatomic, weak) UICollectionViewCell *bannerViewCell;

@property (nonatomic, weak) UIView *bannerView2;
@property (nonatomic, weak) UICollectionViewCell *bannerViewCell2;

@end

@implementation TestCollectionViewController

static NSString * const reuseIdentifier = @"normalCell";

static NSString * const reuseVideoBannerIdentifier = @"videoVannerCell";

static NSString * const reuseImageBannerIdentifier = @"imageVannerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 50;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseVideoBannerIdentifier];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseImageBannerIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [HotmobManager setCurrentViewController:self];
}

- (void)dealloc{
    self.bannerView = nil;
    self.bannerViewCell = nil;
    
    self.bannerView2 = nil;
    self.bannerViewCell2 = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseVideoBannerIdentifier forIndexPath:indexPath];
        
        if (self.bannerView == nil) {
            self.bannerView = [HotmobManager getBanner:self delegate:self identifier:@"hotmob_iphone_sample_video_banner" adCode:@"hotmob_iphone_sample_video_banner" size:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        }
        
        [HotmobManager transitBanner:_bannerView toCell:cell];
        
        self.bannerViewCell = cell;
        
        return cell;
    }else if (indexPath.row == 13){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseImageBannerIdentifier forIndexPath:indexPath];
        
        if (self.bannerView2 == nil) {
            self.bannerView2 = [HotmobManager getBanner:self delegate:self identifier:@"hotmob_iphone_sample_dynamic" adCode:@"hotmob_iphone_sample_dynamic" size:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        }
        
        [HotmobManager transitBanner:_bannerView2 toCell:cell];
        
        self.bannerViewCell2 = cell;
        
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor redColor]];
        return cell;
    }
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return CGSizeMake(self.view.frame.size.width, self.bannerView.frame.size.height);
    }else if (indexPath.row == 13){
        return CGSizeMake(self.view.frame.size.width, self.bannerView2.frame.size.height);
    }else{
        long deviceWidth = self.view.frame.size.width;
        CGSize retval = CGSizeMake(deviceWidth/3 - 5, deviceWidth/3 - 5);
        return retval;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 6;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [HotmobManager calculateBannerPositionWithView:scrollView cellItems:self.collectionView.visibleCells forVideoAdsBannerCell:_bannerViewCell andBanner:_bannerView];
}

#pragma mark - HotmobManagerDelegate

- (void)didShowBanner:(id)obj
{
    NSLog(@"TestCollectionViewController - didShowBanner");
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]]];
    [HotmobManager calculateBannerPositionWithView:self.collectionView cellItems:self.collectionView.visibleCells forVideoAdsBannerCell:_bannerViewCell andBanner:_bannerView];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:13 inSection:0]]];
    [HotmobManager calculateBannerPositionWithView:self.collectionView cellItems:self.collectionView.visibleCells forVideoAdsBannerCell:_bannerViewCell2 andBanner:_bannerView2];
}

- (void)hotmobBanner:(id)obj isReadyChangeSoundSettings:(BOOL)isSoundEnable{
    NSLog(@"TestCollectionViewController - hotmobBanner:isReadyChangeSoundSettings:");
}

- (void)didHideBanner:(id)obj{
    NSLog(@"TestCollectionViewController - didHideBanner");
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]]];
    [HotmobManager calculateBannerPositionWithView:self.collectionView cellItems:self.collectionView.visibleCells forVideoAdsBannerCell:_bannerViewCell andBanner:_bannerView];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:13 inSection:0]]];
    [HotmobManager calculateBannerPositionWithView:self.collectionView cellItems:self.collectionView.visibleCells forVideoAdsBannerCell:_bannerViewCell2 andBanner:_bannerView2];
}

- (void)openNoAdCallback:(id)obj{
    NSLog(@"TestCollectionViewController - hotmobBanner:openNoAdCallback:");
    
}

@end
