//
//  NSDictionary+weather_package.m
//  City
//
//  Created by APPLE on 13-9-24.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "NSDictionary+weather_package.h"

@implementation NSDictionary (weather_package)

- (NSDictionary *)weatherInfo
{
    return self[@"weatherinfo"];
}

@end