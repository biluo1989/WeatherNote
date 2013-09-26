//
//  NoteDetalViewController.h
//  WeatherNote
//
//  Created by APPLE on 13-9-26.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *dateAndWeatherLabel;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (nonatomic, strong) Note *note;

@end
