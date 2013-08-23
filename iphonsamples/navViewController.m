//
//  navViewController.m
//  iphonsamples
//
//  Created by Optimind on 8/8/13.
//  Copyright (c) 2013 Optimind. All rights reserved.
//

#import "navViewController.h"

@interface navViewController ()

@end

@implementation navViewController

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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPageCurl target:self action:nil];
    rightButton.title=@"Back";
    self.title=@"qweqw";
    self.navigationItem.title=@"eldriech";
    self.topViewController.title=@"rty";
    self.topViewController.navigationItem.rightBarButtonItem=rightButton;

    NSLog(@"qweqweqwe");
    NSLog(@"%@",self.description);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
