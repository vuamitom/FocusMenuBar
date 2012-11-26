//
//  ViewController.m
//  FocusMenuBar
//
//  Created by Tam on 26/11/12.
//  Copyright (c) 2012 Knorex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.menuBar.focusMenuDelegate = self;
    self.menuBar.dataSource = self;
    [self.menuBar reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfMenuItems: (FocusMenuBar *) menu
{
    return 5;
}
- (NSString *) menu: (FocusMenuBar *) menu titleForMenuItemAtIndex: (NSInteger) idx
{
    return @"TestVal";
}
- (void) menu: (FocusMenuBar *) menuBar itemFocusedAtIndex: (NSInteger) idx
{
    //do nothing
}
@end
