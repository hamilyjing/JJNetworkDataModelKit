//
//  JSONValueTransformer+JJ.m
//  BaiduBrowser
//
//  Created by hamilyjing on 6/18/15.
//  Copyright (c) 2015 Baidu Inc. All rights reserved.
//

#import "JSONValueTransformer+JJ.h"

static NSDateFormatter *s_jjDateFormatter;

@implementation JSONValueTransformer (JJ)

- (NSDate *)NSDateFromNSString:(NSString*)string
{
    static NSDateFormatter *formatter;
    if (!formatter)
    {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *date = [formatter dateFromString:string];
    return date;
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date
{
    static NSDateFormatter *formatter;
    if (!formatter)
    {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *str = [formatter stringFromDate:date];
    return str;
}

@end
