# JJNetworkDataModelKit

JJNetworkDataModelKit is HTTP data request common framework. Users only write model, protocol and operation class, JJNetworkDataModelKit can implement data to request, get, merge and save.

# Usage

* Create model class

Create new model inherited JJModel for HTTP response data. We use Mantle, so you should implement "JSONKeyPathsByPropertyKey" function.
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

* Create protocol class

Create new protocol inherited JJProtocol to decode HTTP response data to model.
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

* Create operation class

Create new operation inherited JJOperation. The operation decided how to save the model, such as Database, archiver, and how to merger the old and new model.

* Write dictionary info for model class name and operation class name.
```objc
s_modelToOperationDic = @{@"JJWeatherModel": @"JJWeatherOperation",};
```

* Use API
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



