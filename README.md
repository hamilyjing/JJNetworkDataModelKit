# JJNetworkDataModelKit

JJNetworkDataModelKit is HTTP data request common framework. Users only write model, protocol and operation class, JJNetworkDataModelKit can implement data to request, get, merge and save.

# Usage

* Create model class

Create new model, inherited JJModel for Mantle; inherited JJJSONModel for JSONModel; implement JJModelDelegate protocol for user-defined model.
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

* protocol class (not necessary)

Create new protocol inherited JJProtocol to decode HTTP response data to model.
```objc
- (id)decode:(NSDictionary *)content error:(NSError **)error
{
    // Convert content to model    
    return nil;
}
```

* Create operation class

Create new operation inherited JJOperation. The operation saved model. Subclass implement "operateWithNewObject:oldObject:updateCount:" to merge twice response model, and return new model and update count.

Your model and operation class prefix name should be the same, such as JJWeatherJSONModel，JJWeatherJSONModelOperation.

* Use API
```objc
// get model
id object = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherJSONModel") identityID:nil];
    
// HTTP request
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

Sometimes, URL need parameters, such as, "http://www.weather.com.cn/?country=shanghai"或"http://www.weather.com.cn/?country=beijing", the two url has the same model, so, API add identityID to the model is corresponded with which url. You can set nil for identityID, if url do not variable parameter。

# License

JJNetworkDataModelKit is released under the MIT license. See
[LICENSE](https://github.com/hamilyjing/JJNetworkDataModelKit/blob/master/LICENSE).

# More Info

Have a question? Please [open an issue](https://github.com/hamilyjing/JJNetworkDataModelKit/issues)!



