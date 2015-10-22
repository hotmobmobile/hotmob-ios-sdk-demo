###[Hotmob](http://www.hot-mob.com/)
Mobile Advertising with Hotmob, the first and largest mobile ad network in Hong Kong, where monetizes the mobile taffic of the top ranked publishers into revenue and meanwhile connects advertisers to target audience effectively.

### How To Get Started
---
* [Download Hotmob iOS SDK](https://github.com/hotmobmobile/hotmob-ios-sdk/archive/master.zip) and try out the included iPhone example apps
* Read the ["Getting Started" guide](https://github.com/hotmobmobile/hotmob-ios-sdk/wiki/Getting-Started), or [other articles on the Wiki](https://github.com/hotmobmobile/hotmob-ios-sdk/wiki)
* Check out the [documentation](https://github.com/hotmobmobile/hotmob-ios-sdk/wiki) for a comprehensive look at all of the APIs available in Hotmob SDK
* Read the Hotmob SDK 4.0 Migration Guide for an overview of the architectural changes from 3.0 or below

### Integration 
---
1. [Download the Hotmob iOS SDK from Github](https://github.com/hotmobmobile/hotmob-ios-sdk/archive/master.zip) or download link we provided.
2. Drag the HotmobSDK into your project.
3. Make sure `HotmobSDK.a` `HotmobSDK.bundle` `HotmobSDK.h` is added into your project.
4. Set `View controller-based status bar appearance` to `NO` in Project `info.plist`.
5. Add value `-ObjC` to `Other Linker Flags` in your project `Build Settings`.

> If your project is no support the ARC `Automatic Reference Counting`, Please find [Installation guide in wiki](https://github.com/hotmobmobile/hotmob-ios-sdk/wiki/Getting-Started#settings-for-non-arc-projects).


> You can try to implement following code to confirm `HotmobSDK`  is functional in your project.
```
// Add to AppDelegate.h
#import "HotmobManager.h"
// Add to `-(bool)application: didFinishLaunchingWithOptions:` at AppDelegate.m
[HotmobManager setDebug:YES];
[HotmobManager getPopup:nil delegate:nil identifier:@"launch" adCode:@"hotmob_uat_iphone_launch_popup" showWhenResume:YES autoRefresh:YES];
```

> The Popup will show on screen.

### Requirements
---
| HotmobSDK Version     | Minimum iOS Target    | Notes |
| --------              |---------              |-------|
| 4.x                   | iOS 6                 |    Support Video Ads Format|
| 3.x                   | iOS 5.1               |       |

### Basic Usage
---

#### Popup
To create the Hotmob Popup can refercence following step.

1. import the `"HotmobManager.h"` to target ViewController and declare the `HotMobBannerDelegate` protocol.

  ```
  #import "HotmobManager.h"
  ...
  @interface MyViewController : UIViewController <HotmobManagerDelegate> (Optional)
  ```
2. When you call the popup in the `AppDelegate` or first time using in your application. Please using the following code to start the `HotmobManager`

  ```
    [HotmobManager setDebug:NO];
  ```
3. Now you can request the popup by `+getPopup:delegate:identifier:adCode:showWhenResume:autoRefresh:`

  ```
    [HotmobManager getPopup:nil delegate:nil identifier:@"launch" adCode:@"hotmob_uat_iphone_launch_popup" showWhenResume:YES autoRefresh:YES];
  ```
  ---

####  Footer Banner
To create the Hotmob Banner can refercence following step.

1. import the `"HotmobManager.h"` to target ViewController and declare the `HotMobBannerDelegate` protocol.

  ```
  #import "HotmobManager.h"
  ...
  @interface MyViewController : UIViewController <HotmobManagerDelegate>
  ```
2. Create the Banner view and add this banner to ViewController in `- (void)viewWillAppear:(BOOL)animated`

  ```
  - (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect bannerRect = CGRectMake(0, 0, self.view.frame.size.width, 0);
    
    UIView *bannerView = [HotmobManager getBanner:self
                                         delegate:self
                                       identifier:@"MainPageFooterBanner"
                                           adCode:@"hotmob_uat_iphone_image_inapp_banner"
                                             size:bannerRect];

    [self.view addSubview:bannerView];
  }
  ```
3. Resize the UI element and the banner, when the banner is readly
  ```
  #pragma mark - HotmobManagerDelegate
- (void)didLoadBanner:(id)obj {
      UIView *view = obj;
      view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
      self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - view.frame.size.height);
}

- (void)openNoAdCallback:(id)obj {
      UIView *view = obj;
      view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
      self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - view.frame.size.height);
}
  ```
---

#### Banner in TableView
To create the Hotmob banner view and pass banner into UITableView can refercence following step.

1. import the `"HotmobManager.h"` to target ViewController and declare the `HotMobBannerDelegate` protocol.

  ```
  #import "HotmobManager.h"
  ...
  @interface MyViewController : UIViewController <HotmobManagerDelegate>
  ```
2. Identifier which row of UITableView you Want to show the banner in `-(UITableViewCell *)tableView: cellForRowAtIndexPath:`

  ```
  static NSString *cellIdentifier = @"bannerCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        // Configure the cell...
        if (self.bannerView == nil) {
            self.bannerView = [HotmobManager getBanner:self delegate:self identifier:@"bannerViewSample" adCode:@"hotmob_uat_iphone_image_inapp_banner" size:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        }
        
        [HotmobManager transitBanner:_bannerView toCell:cell];
        
        self.bannerViewCell = cell;
        
        return cell;
  ```
3. Set height of banner cell in `- (CGFloat)tableView: heightForRowAtIndexPath:`

  ```
  if (indexPath.row == 11) {
    return _bannerView.frame.size.height;
  } else {
     return 44;
  }
  ```
4. Impelement the delegate methom and resize the banner cell

  ```
  - (void)didShowBanner:(id)obj
  {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]]   withRowAnimation:UITableViewRowAnimationFade];
  }

  - (void)openNoAdCallback:(id)obj
  {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:11 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
  }
  ```
  ---

### Contact
---
Website: [http://www.hot-mob.com](http://www.hot-mob.com/)
