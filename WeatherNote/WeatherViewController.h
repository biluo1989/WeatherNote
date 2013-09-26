//
//  WeatherViewController.h
//  WeatherNote
//
//  Created by APPLE on 13-9-24.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"


@interface WeatherViewController : UITableViewController

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) IBOutlet UILabel *cityLabel;


- (void)getWeather:(NSString *)cityId;

@end
