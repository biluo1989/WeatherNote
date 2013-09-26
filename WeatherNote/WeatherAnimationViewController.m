//
//  WeatherAnimationViewController.m
//  WeatherNote
//
//  Created by APPLE on 13-9-26.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "WeatherAnimationViewController.h"

@interface WeatherAnimationViewController ()

@end

@implementation WeatherAnimationViewController

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
    self.navigationController.toolbarHidden = NO;
	// Do any additional setup after loading the view.
    
    [self pulseImageView:[self cloudy]];
}

-(void)pulseImageView:(UIImageView *)iv{
    
    
    
    [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         iv.transform = CGAffineTransformScale(iv.transform, 2, 2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseIn
                                          animations:^{
                                              iv.transform = CGAffineTransformScale(iv.transform, .5, .5);
                                          }
                                          completion:^(BOOL finished) {
                                              if(finished)
                                                  [self pulseImageView:iv];
                                          }];
                     }];
}



-(UIImageView *)cloudy{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud"]];
    imageView.center = CGPointMake(160,125);
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView bringSubviewToFront:imageView];
    return imageView;
}


@end
