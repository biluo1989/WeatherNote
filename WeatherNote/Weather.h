//
//  Weather.h
//  WeatherNote
//
//  Created by APPLE on 13-9-26.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *condition;

- (Weather *)initWithdate:(NSString *)date andTempreature:(NSString *)temperature andCondition:(NSString *)condition;

@end
