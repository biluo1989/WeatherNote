//
//  NSDictionary+Weather.h
//  City
//
//  Created by APPLE on 13-9-24.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Weather)

- (NSString *)city;
- (NSString *)cityId;
- (NSString *)realTemperature;
- (NSString *)publishTime;

- (NSString *)date;
- (NSString *)week;

- (NSString *)suggestion;

- (NSString *)temperature1;
- (NSString *)temperature2;
- (NSString *)temperature3;
- (NSString *)temperature4;
- (NSString *)temperature5;
- (NSString *)temperature6;

- (NSString *)weather1;
- (NSString *)weather2;
- (NSString *)weather3;
- (NSString *)weather4;
- (NSString *)weather5;
- (NSString *)weather6;

@end
