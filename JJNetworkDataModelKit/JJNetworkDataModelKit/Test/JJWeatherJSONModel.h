//
//  JJWeatherJSONModel.h
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 6/17/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JSONModel.h"

#import "JJModelDelegate.h"

@interface JJWeatherJSONModel : JSONModel <JJModelDelegate>

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

@property (nonatomic, copy) NSString<Ignore> *identityID;

@end
