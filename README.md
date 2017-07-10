主要是练习Moya的熟练使用，全文涉及到CYLTabBarController搭建简单易用的框架、Swift和OC互相调用、FLEX显示界面层级UI的属性、ObjectMapper解析数据、Kingfisher加载网络图片、MBProgressHUD融合到请求里自动显示与隐藏请求等待、MJRefresh作为刷新简单写了一个类别、SDCycleScrollView显示轮播图、Then的使用,最终实现了一个简单的界面...更加深入技术还在探究中，先放上本文的[Demo](https://github.com/ws1227/swiftLearn)
![示例图片](http://upload-images.jianshu.io/upload_images/1315706-25e6e2eae85abbdd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

既然是介绍Moya的就主要先来介绍它吧，Moya是对 Alamofire的进一步封装,简化了网络请求,方便维护
,方便单元测试,使用Moya项目中网络请求类的部分可能长[这样](https://github.com/ws1227/swiftLearn/blob/master/Tool/ApiManager.swift)，所有的请求集中放在一起，集体化管理很方便

[点击查看官方教程](https://github.com/Moya/Moya/tree/master/docs)

#### Moya发送简单的网络请求
枚举类型需满足TargetType协议

```
public protocol TargetType {
var baseURL: NSURL { get }
var path: String { get }
var method: Moya.Method { get }
var parameters: [String: AnyObject]? { get }
var sampleData: NSData { get }
}
```
实现一个枚举代码如下：


```
import Foundation
import Moya

enum ApiManager {
case getDantangList(String)
case getNewsList
case getMoreNews(String)
case getThemeList
case getThemeDesc(Int)
case getNewsDesc(Int)
case Create(title: String, body: String, userId: Int)
case Login(phone:String,password:String)
case Banner(String)
}

extension ApiManager: TargetType {
/// The target's base `URL`.
var baseURL: URL {
switch self {
case .Create(_,_,_):
return URL.init(string: "http://jsonplaceholder.typicode.com/")!
case .getDantangList,.Banner:
return URL.init(string: "http://api.dantangapp.com/")!
case .Login:
return URL.init(string: "https://api.grtstar.cn")!
default:
return URL.init(string: "http://news-at.zhihu.com/api/")!
}
}

/// The path to be appended to `baseURL` to form the full `URL`.
var path: String {
switch self {
case .getDantangList(let page):
return "v1/channels/\(page)/items"
case .getNewsList:
return "4/news/latest"
case .getMoreNews(let date):
return "4/news/before/" + date
case .getThemeList:
return "4/themes"
case .getThemeDesc(let id):
return "4/theme/\(id)"
case .getNewsDesc(let id):
return "4/news/\(id)"
case .Create(_, _, _):
return "posts"
case .Login:
return "/rest/user/certificate"
case .Banner:
return "v1/banners"

}
}

/// The HTTP method used in the request.
var method: Moya.Method {
switch self {

case .Create(_, _, _):
return .post
case .Login:
return .post
default:
return .get
}

}

/// The parameters to be incoded in the request.
var parameters: [String: Any]? {
switch self {
case .Create(let title, let body, let userId):
return ["title": title, "body": body, "userId": userId]

case .Login(let number, let passwords):
return ["mobile" : number, "password" :  passwords,"deviceId": "12121312323"]
case .Banner(let strin):
return ["channel" :strin]

default:
return nil

}
}

/// The method used for parameter encoding.
var parameterEncoding: ParameterEncoding {
return URLEncoding.default
}

/// Provides stub data for use in testing.
var sampleData: Data {

switch self {
case .Create(_, _, _):
return "Create post successfully".data(using: String.Encoding.utf8)!
default:
return "".data(using: String.Encoding.utf8)!

}
}

var task: Task {
return .request
}

/// Whether or not to perform Alamofire validation. Defaults to `false`.
var validate: Bool {
return false
}
}


```
#### 现在就可以发送简单的网络请求了:

1.定义一个全局变量MoyaProvider


```
let ApiManagerProvider = MoyaProvider<ApiManager>


```
2.发送网络请求
```
ApiManagerProvider.request(.getNewsList) { (result) -> () in
case let .success(response):
break
case let .failure(error):
break  

}
```
#### MoyaProvider的初始化

我们观察下MoyaProvider的初始化方法. MoyaProvider初始化都是有默认值的

```
public init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
plugins: [PluginType] = [],
trackInflights: Bool = false)

```
这些可选参数就是Moya的强大之处了 ，文章主要也是介绍如何使用这些插件的。
#### 参数说明：
- EndpointClosure
可以对请求参数做进一步的修改,如可以修改endpointByAddingParameters endpointByAddingHTTPHeaderFields等
- RequestClosure 你可以在发送请求前，做点手脚. 如修改超时时间，打印一些数据等等
- StubClosure可以设置请求的延迟时间,可以当做模拟慢速网络
- Manager 请求网络请求的方式。默认是Alamofire
- [PluginType]一些插件。回调的位置在发送请求后，接受服务器返回之前

稍后详细介绍这部分内容。

#### RxSwift
Moya也有自己的RxSwift的扩展，不懂RxSwift的童鞋可以看下我们博客中的关于RxSwift库介绍的文章。Moya使用RxSwift很简单，如下所示我们只需要对请求结果进行监听就行了
*使用RxSwift可以这样来请求*

```
let provider = RxMoyaProvider<ApiManager>()//要使用RxMoyaProvider创建provider，暂时不携带任何参数
provider.request(.getNewsList).subscribe { event in
switch event {
case .next(let response):
// do something with the data
case .error(let error):
// handle the error
}
}

```


我们还可以对Observable进行扩展，自定义一些自己流水线操作，比如自动实现json转化Model，定义如下。


```
func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
return self.map { response in
//if response is a dictionary, then use ObjectMapper to map the dictionary
//if not throw an error
guard let dict = response as? [String: Any] else {
throw RxSwiftMoyaError.ParseJSONError
}
guard (dict["code"] as?Int) != nil else{
throw RxSwiftMoyaError.ParseJSONError
}

if let error = self.parseError(response: dict) {
throw error
}


return Mapper<T>().map(JSON: dict)!
}
}
```
下边的方法就需要根据服务器返回数据进行判断了，我常用的逻辑是数据请求成功了才返回再就行界面赋值刷新操作，如果是状态码不成功就直接拦截抛出错误（后台返回的message），比如是登录密码错误提示之类的

```
fileprivate func parseError(response: [String: Any]?) -> NSError? {
var error: NSError?
if let value = response {
var code:Int?

//后台的数据每次会返回code只有是200才会表示逻辑正常执行
if let codes = value["code"] as?Int
{
code = codes

}
if  code != 200 {
var msg = ""
if let message = value["message"] as? String {
msg = message
}
error = NSError(domain: "Network", code: code!, userInfo: [NSLocalizedDescriptionKey: msg])
}
}
return error
}

```
*那么就可以定义一个请求方法了 *

```
func login(phone: String, password:String) -> Observable<UserModel> {
return provider.request(.Login(phone: phone, password: password))
.mapJSON()
.debug() // 打印请求发送中的调试信息

.mapObject(type: UserModel.self)
}
```
如下代码就完成了一次请求

```
let viewModel  = ViewModel(self)
viewModel.login(phone: "156178...." , password: "11111")
.subscribe(onNext: { (userModel: UserModel) in
//do something with posts
print(userModel.user?.nickName ?? "")

})
.addDisposableTo(dispose)
```

Moya也为我们提供了很多Observable的扩展，让我们能更轻松的处理MoyaResponse，常用的如下：

- filter(statusCodes:) 过滤response状态码
- filterSuccessfulStatusCodes() 过滤状态码为请求成功的
- mapJSON() 将请求response转化为JSON格式
- mapString() 将请求response转化为String格式

具体可以参考[官方文档](https://github.com/Moya/Moya/blob/master/docs/RxSwift.md)

---

下边就说说RxMoyaProvider参数吧
#### EndpointClosure
 *没写什么就打印下参数，请求方法，路径..可以核对*

```
private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint<Target> {
print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.parameters)) ")


return MoyaProvider.defaultEndpointMapping(for: target)
}

```


#### manager
*用的是Alamofire请求，这里主要写了一个忽略SSL验证的方法，当然也可以在这里修改请求头等等*
```
public func defaultAlamofireManager() -> Manager {
let configuration = URLSessionConfiguration.default
configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

let policies: [String: ServerTrustPolicy] = [

"ap.dimain.cn": .disableEvaluation
]
let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))

manager.startRequestsImmediately = false
return manager
}

```
最有意思的还是插件了 ，可以自定义各种功能
#### plugins
plugins参数是一个数组的形式，遵循PluginType协议我们先看下PluginType的协议内容

```
public protocol PluginType {
/// Called to modify a request before sending
//请求前可以修改一些request
func prepare(_ request: URLRequest, target: TargetType) -> URLRequest

/// Called immediately before a request is sent over the network (or stubbed).
//开始请求
func willSend(_ request: RequestType, target: TargetType)

/// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
//结束请求
func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType)

/// Called to modify a result before completion
func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError>
}

```

*状态条中的网络加载提示,俗称"菊花加载*
#### networkActivityPlugin

```
let networkActivityPlugin = NetworkActivityPlugin { (change) -> () in


switch(change){

case .ended:

UIApplication.shared.isNetworkActivityIndicatorVisible = false

case .began:

UIApplication.shared.isNetworkActivityIndicatorVisible = true

}
}

```
NetworkActivityPlugin是Moya提供的方法，还是根据PluginType的协议实现的



*请求一般就需要loading了这里用MBProgressHUD实现自动显示隐藏*

```

public final class RequestLoadingPlugin: PluginType {
private let viewController: UIViewController
var HUD:MBProgressHUD
var hide:Bool

init(_ vc: UIViewController,_ hideView:Bool) {
self.viewController = vc
self.hide = hideView
HUD = MBProgressHUD.init()
guard self.hide else {

return
}
HUD = MBProgressHUD.showAdded(to: self.viewController.view, animated: true)

}

public func willSend(_ request: RequestType, target: TargetType) {
print("开始请求\(self.viewController)")

if self.hide  != false  {

HUD.mode = MBProgressHUDMode.indeterminate
HUD.label.text = "加载中"
HUD.bezelView.color = UIColor.lightGray

HUD.removeFromSuperViewOnHide = true
HUD.backgroundView.style = .solidColor //或SolidColor

}
}

public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
print("结束请求")
HUD.hide(animated: true)

}

}

```

*修改请求头想想不该放在插件了实现，应该是在manager里实现，先放出来代码吧*

```
struct AuthPlugin: PluginType {
let token: String

func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
var request = request
request.timeoutInterval = 30
request.addValue(token, forHTTPHeaderField: "token")
request.addValue("ios", forHTTPHeaderField: "platform")
request.addValue("version", forHTTPHeaderField: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
return request
}
}
```
*请求时候遇到逻辑错误或者不满足条件，参数错误等要提示这里用的是Toast*

```
//检测token有效性
final class AccessTokenPlugin: PluginType {
private let viewController: UIViewController

init(_ vc: UIViewController) {
self.viewController = vc
}

public func willSend(_ request: RequestType, target: TargetType) {}
public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
switch result {
case .success(let response):
//请求状态码
guard  response.statusCode == 200   else {
return
}
var json:Dictionary? = try! JSONSerialization.jsonObject(with: response.data,options:.allowFragments) as! [String: Any]
print("请求状态码\(json?["status"] ?? "")")
guard (json?["message"]) != nil  else {
return
}
guard let codeString = json?["status"]else {return}
//请求状态为1时候立即返回不弹出任何提示 否则提示后台返回的错误信息
guard codeString as! Int != 1 else{return}
self.viewController.view .makeToast( json?["message"] as! String)

case .failure(let error):
print("出错了\(error)")

break
}
}
}

```
AccessTokenPlugin这个名字有点问题哈，起初是想在这里判断token不正确就退出登录用的由于没有合适的api就实现了请求结果的状态判断，这就自动实现了逻辑错误的提示了 不用一个请求一个请求的判断了，还是挺方便的

有了这些插件就可以这样初始化RxMoyaProvider

```
let provider :RxMoyaProvider<ApiManager>
provider = RxMoyaProvider<ApiManager>(
endpointClosure: endpointMapping,
manager:defaultAlamofireManager(),
plugins:[RequestLoadingPlugin(self.viewController,true),
AccessTokenPlugin( self.viewController), NetworkLoggerPlugin(verbose: true),
networkActivityPlugin,AuthPlugin(token: "暂时为空")]

```
关于Moya的用法先介绍到这里后续我会继续探究更加灵活全面的用法。

---



#### 下边介绍下[Then](https://github.com/devxoul/Then)的语法棉花糖吧，看例子吧


```
_ = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 50)).then({ (make) in

make.text = "Then的简单用法超赞👍"
make.font = .systemFont(ofSize: 20)
make.textColor = .red
make.textAlignment = .center
self.view.addSubview(make)

})

UserDefaults.standard.do {
$0.set("devxoul", forKey: "username")
$0.set("devxoul@gmail.com", forKey: "email")
$0.synchronize()

let tableView = UITableView().then {
$0.backgroundColor = .clear
$0.separatorStyle = .none
$0.register(MyCell.self, forCellReuseIdentifier: "myCell")
}

}   
```
 
*如果布局这样还不简单那再看下边用[Then](https://github.com/devxoul/Then)和[SnapKit](https://github.com/SnapKit/SnapKit)一起使用的方式*

```
_ = UILabel().then({ (make) in
make.text = "Then的简单用法超赞👍"
make.font = .systemFont(ofSize: 20)
make.textColor = .red
make.textAlignment = .center
self.view.addSubview(make)
make.snp.makeConstraints({ (make) in
make.top.left.right.equalTo(0)
make.height.equalTo(50)

})

})


```
再不满意只能用Xib布局了....


#### 在Swift中用[SDCycleScrollView](https://github.com/gsdios/SDCycleScrollView)轮播图

SDCycleScrollView之前一直在OC中使用觉得很简单又熟悉了所以这次写的Demo依旧搬了过来，但是呢SDCycleScrollView里实现图片下载用的是SDWebImage，而Swift版本提供了Kingfisher那不可能都用了，因为也不想放弃SDCycleScrollView就不得已修改了里边图片下载的方法，在Swift项目里OC类直接调用Swift类是调用不到的，所以我就咨询了下找到一个合适办法，新建Swift里继承SDCycleScrollView然后用Kingfisher实现图片下载，方法比较简单就是给开发者提供一个参考方法


```
import UIKit
import SDCycleScrollView
import Kingfisher
class CustomSDCycleScrollView: SDCycleScrollView  {

//因为之前库里边用的是SDWebImageView 缓存的图片 现在 换了Swift版本的Kingfisher所以 无奈修改了原库的方法 重写了下
open override func imageView(_ imageView: UIImageView!, url: URL!) -> UIImageView! {
let imageView: UIImageView? = imageView
imageView?.kf.setImage(with: url,placeholder:UIImage.init(named: "tab_5th_h"))
return imageView
}
//重写oc代码 删除缓存
override class func clearImagesCache()
{
let cache = KingfisherManager.shared.cache

// 获取硬盘缓存的大小
cache.calculateDiskCacheSize { (size) -> () in
print("磁盘缓存大小： \(size) bytes ")
cache.clearDiskCache()

}
}


}

```
用的时候直接使用CustomSDCycleScrollView即可

#### 项目使用MJRefresh实现刷新
*给UIScrollView写了一个类别比较简单代码如下*

```
import UIKit
import MJRefresh

extension UIScrollView
{
func headerRefresh(block: @escaping () -> ()) -> (){

self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
block()

})


}
func footerRefresh(block: @escaping () -> ()) -> (){

self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
block()

})

}

func endrefresh(){

self.mj_footer.endRefreshing()
self.mj_header.endRefreshing()

}


}


```
用的时候更简单了

```
weak var weakself = self
//上拉刷新
tableView.headerRefresh {
weakself?.loadData()
}
//下拉加载
tableView.footerRefresh{
weakself?.loadData()
}
//结束刷新
self.tableView.endrefresh()

```
值得一提的是[Swift项目如何用OC](http://wangsen.website/posts/28457/)

下班了。。。。后续更新
