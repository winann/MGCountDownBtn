//
//  MGViewController.m
//  MGCountDownBtn
//
//  Created by winann on 09/24/2017.
//  Copyright (c) 2017 winann. All rights reserved.
//

#import "MGViewController.h"
#import "MGCountDownBtn-umbrella.h"

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)countDownAction:(UIButton *)sender {
    [sender startTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
