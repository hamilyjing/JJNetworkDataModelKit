# JJNetworkDataModelKit

JJNetworkDataModelKit是HTTP数据请求的通用框架，使用者只需创建模型，协议和具体的操作类，即可完成HTTP数据请求中，数据的请求，获取，合并和保存。

# 使用

* 创建模型类

创建新模型，继承JJModel类。JJNetworkDataModelKit内部使用Mantle开源库，你需要实现"JSONKeyPathsByPropertyKey"方法。
```objc
@interface JJWeatherModel : JJModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) NSInteger cityid;
@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *WD;
@property (nonatomic, strong) NSString *WS;
@property (nonatomic, strong) NSString *SD;
@property (nonatomic, strong) NSString *WSE;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) BOOL isRadar;
@property (nonatomic, strong) NSString *Radar;
@property (nonatomic, strong) NSString *njd;
@property (nonatomic, strong) NSString *qy;

@end
```
```objc
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"city": @"city",
             @"cityid": @"cityid",
             @"temp": @"temp",
             @"WD": @"WD",
             @"WS": @"WS",
             @"SD": @"SD",
             @"WSE": @"WSE",
             @"time": @"time",
             @"isRadar": @"isRadar",
             @"Radar": @"Radar",
             @"njd": @"njd",
             @"qy": @"qy",
             };
}
```

* 创建协议类

协议类集成JJProtocol，将HTTP应答数据解码成对应的model。
```objc
- (id)decode:(NSDictionary *)content
{
    NSError *error;
    JJWeatherModel *weatherModel = [MTLJSONAdapter modelOfClass:JJWeatherModel.class fromJSONDictionary:content[@"weatherinfo"] error:&error];
    if (nil == weatherModel)
    {
        return error;
    }
    
    return weatherModel;
}
```

* 创建操作类

操作类集成JJOperation。操作类保存模型，默认archiver的格式，并且决定如何合并两次应答数据。

* 将新建模型和协议写在字典里
```objc
s_modelToOperationDic = @{@"JJWeatherModel": @"JJWeatherOperation",};
```

* 使用API
```objc
id object = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherModel")];
NSLog(@"%@", object);
    
NSString *urlString = @"http://www.weather.com.cn/adat/sk/101010100.html";
[[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherProtocol") resultBlock:^(JJIndexType index, BOOL success, id object)
{
    NSLog(@"object: %@", object);
}];
```

# License

JJSkin is released under the MIT license. See
[LICENSE](https://github.com/hamilyjing/JJNetworkDataModelKit/blob/master/LICENSE).

# More Info

Have a question? Please [open an issue](https://github.com/hamilyjing/JJNetworkDataModelKit/issues)!