//
//  FocusMenuBar.h
//  FocusMenuBar
//
//  Created by Tam on 26/11/12.
//  Copyright (c) 2012 Knorex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FocusMenuBar;

@protocol FocusMenuBarDataSource <NSObject>
@required
- (NSInteger) numberOfMenuItems:(FocusMenuBar *) menu;
- (NSString *) menu:(FocusMenuBar *) menu titleForMenuItemAtIndex: (NSInteger) idx;
@end

@protocol FocusMenuBarDelegate <NSObject>
- (void) menu: (FocusMenuBar *) menuBar itemFocusedAtIndex: (NSInteger) idx;
@end

@interface FocusMenuBar : UIView <UIScrollViewDelegate>
{
    NSInteger numItems;
    NSInteger activeIndex;
}
- (void) reloadData;
@property (nonatomic) IBOutlet id<FocusMenuBarDataSource> dataSource;
@property (nonatomic) IBOutlet id<FocusMenuBarDelegate> focusMenuDelegate;
@property (nonatomic) NSInteger itemFontSize;
@property (nonatomic) NSInteger indicatorFontSize;
@property (nonatomic) UIColor   *focusColor;
@property (nonatomic) UIColor   *normalColor;
@property (nonatomic) UIColor   *indicatorColor;
@end
