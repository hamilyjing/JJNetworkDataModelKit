# JJNetworkDataModelKit

JJNetworkDataModelKit是HTTP数据请求的通用框架，使用者只需创建模型，协议和具体的操作类，即可完成HTTP数据请求中，数据的请求，获取，合并和保存。

# 使用

* 创建模型类

创建模型，使用Mantle开源库，继承JJModel类；使用JSONModel开源库，继承JJJSONModel类；自定义模型，需要实现JJModelDelegate协议。
```objc
@interface JJWeatherModel : JJJSONModel

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

* 协议类（不是必须）

协议类集成JJProtocol，将HTTP应答数据解码成对应的model。创建了协议类，需要实现"decode:error:"方法。
```objc
- (id)decode:(NSDictionary *)content error:(NSError **)error
{
    // Convert content to model    
    return nil;
}
```

* 创建操作类

操作类集成JJOperation。操作类保存模型。
子类主要实现"operateWithNewObject:oldObject:updateCount:"，决定如何合并两次应答数据，并返回新合并后数据和更新数量。

建议操作类和模型类前缀名一致，如JJWeatherJSONModel，JJWeatherJSONModelOperation，否则调用"setModelAndOperationNameDictionary:"，传递新创建的模型和操作类名称。

* 使用API
```objc
// 获取模型
id object = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherJSONModel") identityID:nil];
    
// HTTP请求
NSString *urlString = @"http://www.weather.com.cn/adat/sk/101010100.html";
[[JJApplicationLayerManager sharedInstance] httpRequest:urlString modelOrProtocolClass:NSClassFromString(@"JJWeatherJSONModel") identityID:nil httpParams:nil resultBlock:^(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache)
{
    if (object)
    {
        // object is model class
    }
    else
    {
        // object is NSError class
    }
}
}
}];
```

有时请求的URL需要传递参数，如"http://www.weather.com.cn/?country=上海"或"http://www.weather.com.cn/?country=北京"，这两个URL返回的模型是一致的，请求API中增加identityID，对应返回的模型是哪个请求发出。如果URL中没有变化参数，identityID可以传递nil。

# License

JJNetworkDataModelKit is released under the MIT license. See
[LICENSE](https://github.com/hamilyjing/JJNetworkDataModelKit/blob/master/LICENSE).

# More Info

Have a question? Please [open an issue](https://github.com/hamilyjing/JJNetworkDataModelKit/issues)!