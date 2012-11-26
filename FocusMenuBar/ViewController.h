//
//  ViewController.h
//  FocusMenuBar
//
//  Created by Tam on 26/11/12.
//  Copyright (c) 2012 Knorex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusMenuBar.h"
@interface ViewController : UIViewController<FocusMenuBarDataSource, FocusMenuBarDelegate>
@property (weak, nonatomic) IBOutlet FocusMenuBar *menuBar;

@end
