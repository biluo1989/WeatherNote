//
//  CityPickerViewController.h
//  WeatherNote
//
//  Created by APPLE on 13-9-22.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

/*
@class CityPickerViewController;

@protocol CityPickerViewControllerDelegate <NSObject>

- (void)cityPickerViewController:(CityPickerViewController *)controller didSelectCity:(NSString *)city;

@end
*/

#import <UIKit/UIKit.h>

@interface CityPickerViewController : UITableViewController

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityId;

@end
