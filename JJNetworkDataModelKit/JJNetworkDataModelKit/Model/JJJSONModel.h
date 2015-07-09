//
//  JJJSONModel.h
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 6/18/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JSONModel.h"

#import "JJModelDelegate.h"

@interface JJJSONModel : JSONModel <JJModelDelegate>
{
    NSString<Optional> *_identityID;
}

@property (nonatomic, copy) NSString<Optional> *identityID;
@property (nonatomic, strong) NSDictionary<Optional> *httpParams;

@end
