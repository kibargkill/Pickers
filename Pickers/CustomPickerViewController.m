//
//  CustomPickerViewController.m
//  Pickers
//
//  Created by Администратор on 9/22/12.
//  Copyright (c) 2012 Администратор. All rights reserved.
//

#import "CustomPickerViewController.h"

@interface CustomPickerViewController ()

@end

@implementation CustomPickerViewController
@synthesize  picker;
@synthesize winLabel;
@synthesize column1;
@synthesize column2;
@synthesize column3;
@synthesize column4;
@synthesize column5;

-(IBAction)spin{
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i<5; i++){
        int newValue = random() % [self.column1 count];
        if (newValue == lastVal)
            numInRow++;
        else
            numInRow = 1;
        
        lastVal = newValue;
        [picker selectRow:newValue inComponent:i animated:YES];
        [picker reloadComponent:i];
        if (numInRow >= 3)
            win = YES;
        
    }
    if (win)
        winLabel.text = @"WIN!";
    else
        winLabel.text = @"";
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
    // Do any additional setup after loading the view from its nib.
    UIImage *seven = [UIImage imageNamed:@"seven.png"];
    UIImage *bar = [UIImage imageNamed:@"bar.png"];
    UIImage *crown = [UIImage imageNamed:@"crown.png"];
    UIImage *cherry = [UIImage imageNamed:@"cherry.png"];
    UIImage *lemon = [UIImage imageNamed:@"lemon.png"];
    UIImage *apple = [UIImage imageNamed:@"apple.png"];
    
    for (int i = 1; i <= 5; i++){
        UIImageView *sevenView = [[UIImageView alloc]initWithImage:seven];
        UIImageView *barVieew = [[UIImageView alloc] initWithImage:bar];
        UIImageView *crownView = [[UIImageView alloc] initWithImage:crown];
        UIImageView *cherryView = [[UIImageView alloc] initWithImage:cherry];
        UIImageView *lemonView = [[UIImageView alloc] initWithImage:lemon];
        UIImageView *appleView = [[UIImageView alloc] initWithImage:apple];
        
        NSArray *imageViewArray = [[NSArray alloc] initWithObjects:sevenView, barVieew, crownView, cherryView, lemonView, appleView, nil];
        
        NSString *fieldName = [[NSString alloc] initWithFormat:@"column%d", i];
        [self setValue:imageViewArray forKey:fieldName];
        
    }
    srandom(time(NULL));
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.picker = nil;
    self.winLabel = nil;
    self.column1 = nil;
    self.column2 = nil;
    self.column3 = nil;
    self.column4 = nil;
    self.column5 = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma  mark Picker Data Source Vethods

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [self.column1 count];
}

#pragma mark Picker Delegate Methods
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *arrayName = [[NSString alloc] initWithFormat:@"column%d", component+1];
    NSArray *array = [self valueForKey:arrayName];
    return  [array objectAtIndex:row];
}

@end
