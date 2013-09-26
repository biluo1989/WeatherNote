//
//  NSDictionary+Weather.m
//  City
//
//  Created by APPLE on 13-9-24.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "NSDictionary+Weather.h"

@implementation NSDictionary (Weather)

- (NSString *)city
{
    return self[@"city"];
}

- (NSString *)cityId
{
    return self[@"cityid"];
}

- (NSString *)realTemperature
{
    return self[@"temp"];
}

- (NSString *)publishTime
{
    return self[@"time"];
}


- (NSString *)date
{
    return self[@"date_y"];
}

- (NSString *)week
{
    return self[@"week"];
}


- (NSString *)suggestion
{
    return self[@"index_d"];
}


- (NSString *)temperature1
{
    return self[@"temp1"];
}

- (NSString *)temperature2
{
    return self[@"temp2"];
}

- (NSString *)temperature3
{
    return self[@"temp3"];
}

- (NSString *)temperature4
{
    return self[@"temp4"];
}

- (NSString *)temperature5
{
    return self[@"temp5"];
}

- (NSString *)temperature6
{
    return self[@"temp6"];
}


- (NSString *)weather1
{
    return self[@"weather1"];
}

- (NSString *)weather2
{
    return self[@"weather2"];
}

- (NSString *)weather3
{
    return self[@"weather3"];
}

- (NSString *)weather4
{
    return self[@"weather4"];
}

- (NSString *)weather5
{
    return self[@"weather5"];
}

- (NSString *)weather6
{
    return self[@"weather6"];
}

@end
