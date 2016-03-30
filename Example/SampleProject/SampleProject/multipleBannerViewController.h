//
//  multipleBannerViewController.h
//  SampleProject
//
//  Created by Choi Wing Chiu on 16/10/15.
//  Copyright © 2015 HotmobLtd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface multipleBannerViewController : UIViewController {
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *bannerViewsArray;
@property (nonatomic) NSUInteger count;
@end
