//
//  NoteDetalViewController.m
//  WeatherNote
//
//  Created by APPLE on 13-9-26.
//  Copyright (c) 2013年 yujiang. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "WeatherViewController.h"

@interface NoteDetailViewController () <UIActionSheetDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIBarButtonItem *actionButton;
@property (strong, nonatomic) UIBarButtonItem *cameraButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

- (void)actionTapped;
- (void)cameraTapped;
- (void)doneTapped;

@end

@implementation NoteDetailViewController

- (void)actionTapped
{
    NSString *titleString = [NSString stringWithFormat:@"%@", self.textView.text];
    
    NSArray *items = @[titleString];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)userInfo
{
    self.navigationItem.rightBarButtonItems = @[self.cameraButton, self.actionButton];
}

- (void)keyboardWillShow:(NSNotification *)userInfo
{
    self.navigationItem.rightBarButtonItems = @[self.doneButton, self.actionButton];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doneTapped
{
    if (self.textView.isFirstResponder)
    {
        [self.textView resignFirstResponder];
    }
    
    self.note.notes = self.textView.text;
}

- (void)cameraTapped
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionTapped)];
    self.cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraTapped)];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped)];
    
    self.navigationItem.rightBarButtonItems = @[self.cameraButton, self.actionButton];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_sand"]]];
    self.dateAndWeatherLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"dateAndWeather"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self doneTapped];
    
    [self saveNote];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveNote{
    NSMutableArray *dataMutableArray = [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"note"];
    [dataMutableArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.textView.text,@"notes",self.dateAndWeatherLabel.text,@"dateAndWeather", nil]];
}

@end
