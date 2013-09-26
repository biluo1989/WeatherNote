//
//  Weather.m
//  WeatherNote
//
//  Created by APPLE on 13-9-26.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (Weather *)initWithdate:(NSString *)date andTempreature:(NSString *)temperature andCondition:(NSString *)condition
{
    self.date = date;
    self.temperature = temperature;
    self.condition = condition;
    return self;
}

@end
