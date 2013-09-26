//
//  ViewController.m
//  WeatherNote
//
//  Created by APPLE on 13-9-25.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "WeatherViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityId;

@end

@implementation ViewController {
    NSString *_city;
    NSDictionary *_cityDict;
    CLLocationManager *_locationManager;
    CLLocation *_location;
    
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    BOOL performingReverseGeocoding;
    NSError *lastGeocodingError;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self getLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _locationManager = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

- (void)getLocation
{
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	CLLocation *lastLocation = [locations lastObject];
    _location = lastLocation;
    
    if (!performingReverseGeocoding) {
        
        performingReverseGeocoding = YES;
        [geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            lastGeocodingError = error;
            
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
            } else {
                placemark = nil;
            }
            
            if (placemark.locality) {
                self.city = placemark.locality;
            } else {
                self.city = placemark.administrativeArea;
            }
            
            performingReverseGeocoding = NO;
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowWeather"])
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict1" ofType:@"plist"];
        _cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        self.cityId = _cityDict[self.city];
        
        UITabBarController *tabbarViewController = segue.destinationViewController;
        UINavigationController *navigationController = tabbarViewController.viewControllers[0];
        WeatherViewController *weatherViewController = navigationController.viewControllers[0];
        weatherViewController.city = self.city;
        weatherViewController.cityId = self.cityId;
        [weatherViewController getWeather:self.cityId];
    }
}

@end