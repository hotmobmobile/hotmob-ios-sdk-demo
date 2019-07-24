### [Hotmob](http://www.hot-mob.com/)
Mobile Advertising with Hotmob, the first and largest mobile ad network in Hong Kong, where monetizes the mobile taffic of the top ranked publishers into revenue and meanwhile connects advertisers to target audience effectively.

Visit http://www.hot-mob.com/ for more details.

### Requirements
---
* Swift 4+
* iOS 9.0+
* Xcode 10.2+

### Installation
---
CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `HotmobiOSSDK` by adding it to your `Podfile`:

```
pod 'HotmobiOSSDK'
```

### Usage
---

#### Initialization
To integrate SDK should init `HotmobiOSSDK` in `AppDelegate.swift` class. Please using the following code to start the `HotmobiOSSDK`.
```
import HotmobiOSSDK
...
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    HotmobiOSSDK.startSDK()
    ...
    return true
}
```

#### Popup
To Create the Hotmob Popup can refercence following step:
1.  Import the `HotmobiOSSDK` to the target AppDelegate and declare the `HotmobControllerDelegate` protocol.
```
import HotmobiOSSDK
...
class AppDelegate: UIResponder, UIApplicationDelegate, HotmobControllerDelegate {
```
2.  When you call the popup in the AppDelegate or first time using in your application. Please using the following code to start the HotmobManager

```
HotmobiOSSDK.startSDK()
HotmobiOSSDK.getHotmobPopup(adCode: "hotmob_ios_popup_inapp", delegate: self)
```
3. Implement the delegate method.
```
func didLoadBanner(_ banner: UIView){
}
    
func didDisplayBanner(_ banner: UIView){
}
    
func willDisplayBanner(_ banner: UIView){
}
    
func willHideBanner(_ banner: UIView){
}
    
func didHideBanner(_ banner: UIView){
}
    
func didLoadFailed(){
}
    
func openInternalCallback(url: String){
}
    
func didResizeBanner(_ banner: UIView) {
}

func videoAdMute() {
}

func videoAdUnmute() {
}
```

#### Banner
To Create the Hotmob Banner can refercence following step:
1.  Import the `HotmobiOSSDK` to the target ViewController and declare the `HotmobControllerDelegate` protocol.
```
import HotmobiOSSDK
...
class ViewController: UIViewController, HotmobControllerDelegate {
```

2. Create the banner view and add the banner to ViewController in `func viewDidLoad()`.
```
override func viewDidLoad() {
    super.viewDidLoad()
    
        let adCode = "hotmob_ios_banner_standard"
        let identifier = "custom"
        let con = HotmobiOSSDK.getHotmobBannerController(adCode, needAutoReload: true, delegate: self, identifier: identifier)
        self.bannerView = con.returnDisplayView()
        self.adContainerView.addSubview(self.bannerView!)
}
```

3. Implement the delegate method.
```
func didLoadBanner(_ banner: UIView){
}
    
func didDisplayBanner(_ banner: UIView){
    self.adContainerView.frame.size.height = banner.frame.size.height
}
    
func willDisplayBanner(_ banner: UIView){
}
    
func willHideBanner(_ banner: UIView){
}
    
func didHideBanner(_ banner: UIView){
    self.adContainerView.frame.size.height = 0
}
    
func didLoadFailed(){
    self.adContainerView.frame.size.height = 0
}
    
func openInternalCallback(url: String){
}
    
func didResizeBanner(_ banner: UIView) {
    self.adContainerView.frame.size.height = banner.frame.size.height
}

func videoAdMute() {
}

func videoAdUnmute() {
}
```

#### Banner in TableView
To Create the Hotmob Banner can refercence following step:
1.  Import the `HotmobiOSSDK` to the target ViewController and declare the `HotmobControllerDelegate` protocol.
```
import HotmobiOSSDK
...
class ViewController: UIViewController, HotmobControllerDelegate {
```

2. Identifier which row of UITableView you Want to show the banner in `func tableView(_:cellForRowAt:)`
```
let cell = tableView.dequeueReusableCell(withIdentifier: self.ItemCellID)
cell?.backgroundColor = .black
self.bannerView?.removeFromSuperview()
if self.bannerView == nil {
    let adCode: String = "hotmob_ios_videobanner_inapp"
    let con = HotmobiOSSDK.getHotmobBannerController(adCode, needAutoReload: true, delegate: self, identifier: "videoBanner")
    self.con = con
    self.bannerView = con.returnDisplayView()
}
cell?.addSubview(self.bannerView!)
self.bannerCell = cell
            
return cell!
```

3. Set height of banner cell in `func tableView(_:heightForRowAt:)`
```
if indexPath.row == 5{
    if (self.bannerView != nil) {
          return (self.bannerView?.frame.size.height)!
    }else{
        return 0
    }
}
return 50
```

4. Implement the delegate method.
```
func didLoadBanner(_ banner: UIView){
}
    
func didDisplayBanner(_ banner: UIView){
    let indexPath: IndexPath = IndexPath(row: 5, section: 0)
    self.mainTableView.reloadRows(at: [indexPath], with: .fade)
    HotmobiOSSDK.calculateBannerPositionWithView(scrollView: self.mainTableView, cellItems: self.mainTableView.visibleCells, bannerCell: self.bannerCell!, banner: self.bannerView!, con: con!)
}
    
func willDisplayBanner(_ banner: UIView){
}
    
func willHideBanner(_ banner: UIView){
}
    
func didHideBanner(_ banner: UIView){
    let indexPath: IndexPath = IndexPath(row: 5, section: 0)
    self.mainTableView.reloadRows(at: [indexPath], with: .fade)
}
    
func didLoadFailed(){
}
    
func openInternalCallback(url: String){
}
    
func didResizeBanner(_ banner: UIView) {
    let indexPath: IndexPath = IndexPath(row: 5, section: 0)
    self.mainTableView.reloadRows(at: [indexPath], with: .fade)
    HotmobiOSSDK.calculateBannerPositionWithView(scrollView: self.mainTableView, cellItems: self.mainTableView.visibleCells, bannerCell: self.bannerCell!, banner: self.bannerView!, con: con!)
}

func videoAdMute() {
}

func videoAdUnmute() {
}
```
5. Additional Coding for Native Video Ad (optional)
To support banner visible <50% pause and visible >50% play when the banner scoll-off or scoll-on screen. 
```
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (self.bannerCell != nil) && (self.bannerView != nil){
        HotmobiOSSDK.calculateBannerPositionWithView(scrollView: self.mainTableView, cellItems: self.mainTableView.visibleCells, bannerCell: self.bannerCell!, banner: self.bannerView!, con: con!)
    }
}
```

---
### Contact
---
Website: [http://www.hot-mob.com](http://www.hot-mob.com/)
