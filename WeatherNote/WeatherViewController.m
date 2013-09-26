//
//  WeatherViewController.m
//  WeatherNote
//
//  Created by APPLE on 13-9-24.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "WeatherViewController.h"
#import "CityPickerViewController.h"
#import "NSDictionary+weather_package.h"
#import "NSDictionary+Weather.h"
#import "AFNetworking.h"
#import "WeatherAnimationViewController.h"

NSString *const BaseURLStringOfFutureWeather = @"http://m.weather.com.cn/data/";
NSString *const BaseURLStringOfCurrentWeather = @"http://www.weather.com.cn/data/sk/";
NSString *const tailString = @".html";

@interface WeatherViewController ()

@property (nonatomic, strong) NSDictionary *weatherData;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSString *selectedCondition;

@property (nonatomic, strong) Weather *weather1;
@property (nonatomic, strong) Weather *weather2;
@property (nonatomic, strong) Weather *weather3;

@end

@implementation WeatherViewController {
    NSString *_city;
    NSDictionary *_cityDict;
    NSArray *_letters;
    NSArray *todayWeather;
    NSArray *tomorrowWeather;
    NSArray *theDayAfterTomorrowWeather;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_sand"]]];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;

}

- (void)refresh
{
    [self getWeather:self.cityId];
    [self.refreshControl endRefreshing];
}

/*
- (NSString *)getCityId:(NSString *)city
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    _cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _letters = [[_cityDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    
}
*/

- (void)getWeather:(NSString *)cityId
{
    NSString *currentWeatherURL = [NSString stringWithFormat:@"%@%@%@",BaseURLStringOfFutureWeather,self.cityId,tailString];
    NSURL *url = [NSURL URLWithString:currentWeatherURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        
                                                        self.weatherData = (NSDictionary *)JSON;
                                                        
                                                       self.weather1 = [[Weather alloc] initWithdate:self.weatherData.weatherInfo.date
                                                                                     andTempreature:self.weatherData.weatherInfo.temperature1
                                                                                       andCondition:self.weatherData.weatherInfo.weather1];
                                                        todayWeather = @[self.weather1.date, [NSString stringWithFormat:@"%@  %@",self.weather1.temperature, self.weather1.condition]];
                                                                         
                                                        self.weather2 = [[Weather alloc] initWithdate:@"明天" andTempreature:self.weatherData.weatherInfo.temperature2 andCondition:self.weatherData.weatherInfo.weather2];
                                                        
                                                        tomorrowWeather = @[self.weather2.date, [NSString stringWithFormat:@"%@  %@",self.weather2.temperature, self.weather2.condition]];
                                                                         
                                                        self.weather3 = [[Weather alloc] initWithdate:@"后天" andTempreature:self.weatherData.weatherInfo.temperature3 andCondition:self.weatherData.weatherInfo.weather3];
                                                                            
                                                        theDayAfterTomorrowWeather = @[self.weather3.date, [NSString stringWithFormat:@"%@  %@",self.weather3.temperature, self.weather3.condition]];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ , %@", self.weather1.date, self.weather1.condition] forKey:@"dateAndWeather"];
                                                        
                                                        [self.tableView reloadData];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [av show];
                                                    }];
    
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURLRequest *)requestWithBaseURLString:(NSString *)baseURLString andCityID:(NSString *)cityID
{
    NSString *weatherURL = [NSString stringWithFormat:@"%@%@%@", baseURLString, cityID, tailString];
    NSURL *url = [NSURL URLWithString:weatherURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"WeatherCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString * entry;
    
    if (indexPath.section == 0) {
        entry = todayWeather[indexPath.row];
    } else if(indexPath.section == 1){
        entry = tomorrowWeather[indexPath.row];
    } else {
        entry = theDayAfterTomorrowWeather[indexPath.row];
    }
    
    cell.textLabel.text = entry;
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"%@", self.city];
    } else {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            self.selectedCondition = self.weather1.condition;
        case 1:
            self.selectedCondition = self.weather2.condition;
        case 2:
            self.selectedCondition = self.weather3.condition;
    }
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAnimation"])
    {
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        WeatherAnimationViewController *weatherAnimation = segue.destinationViewController;
        
        switch (indexPath.section) {
            case 0:
                weatherAnimation.weatherCondition = self.weather1.condition;
            case 1:
                weatherAnimation.weatherCondition = self.weather2.condition;
            case 2:
                weatherAnimation.weatherCondition = self.weather3.condition;
        }
    }
}

#pragma mark - unwind segue

- (IBAction)cancel:(UIStoryboardSegue *)segue {}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    CityPickerViewController *controller = segue.sourceViewController;
    if (controller.city) {
        self.city = controller.city;
        self.cityId = controller.cityId;
        
        [self getWeather:self.cityId];
        
        [self.tableView reloadData];
        
    }
}

- (IBAction)backFromAnimation:(UIStoryboardSegue *)segue {}

@end
