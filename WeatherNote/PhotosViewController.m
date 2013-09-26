//
//  PhotosViewController.m
//  WeatherNote
//
//  Created by APPLE on 13-9-26.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotosViewController

#pragma mark - View Lifecycle

- (void)didReceiveMemoryWarning
{
    if ([self.view window] == nil)
    {
        _image = nil;
        _imageView = nil;
        self.view = nil;
    }
    
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.imageView setImage:self.image];
    
    self.view.backgroundColor = [UIColor clearColor];
}

@end
