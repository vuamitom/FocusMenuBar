//
//  FocusMenuBar.m
//  FocusMenuBar
//
//  Created by Tam on 26/11/12.
//  Copyright (c) 2012 Knorex. All rights reserved.
//

#import "FocusMenuBar.h"
#define kMenuLeftPadding 5
#define kMenuRightPadding 5 
#define kMaxMenuItemWidth 120
@interface FocusMenuBar ()
@property (nonatomic) UIScrollView *sv;
@property (nonatomic) UIButton *leftItem;
@property (nonatomic) UIButton *rightItem;
@end

@implementation FocusMenuBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void) awakeFromNib
{
    numItems = 0;
    self.itemFontSize = 12;
    activeIndex = 0;
    
    self.normalColor     = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    self.focusColor      = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
    self.indicatorColor  = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
    
    
    self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
    self.sv.bounces = YES;
	self.sv.scrollEnabled = YES;
    self.sv.pagingEnabled = YES;
    self.sv.alwaysBounceHorizontal = YES;
    self.sv.alwaysBounceVertical = NO;
    self.sv.showsHorizontalScrollIndicator = NO;
    self.sv.showsVerticalScrollIndicator = NO;
    [self addSubview:self.sv];
    
    self.leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.leftItem.frame = CGRectMake(kMenuLeftPadding, 0, 100, 30);
    //[self.leftItem setTitle:@"Left" forState:UIControlStateNormal];
    [self.leftItem setTitleColor:self.indicatorColor forState:UIControlStateNormal];
    [self addSubview:self.leftItem];
    self.rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.rightItem.frame = CGRectMake(self.frame.size.width - kMenuRightPadding -100, 0, 100,30);
    //[self.rightItem setTitle:@"right" forState:UIControlStateNormal];
    [self.rightItem setTitleColor:self.indicatorColor forState:UIControlStateNormal ];
    [self addSubview:self.rightItem];
    //self.sv = self;
    //self.sv = self;
    
    self.sv.delegate = self;
}



- (void) reloadData
{
    
    
    
    numItems          = [self.dataSource numberOfMenuItems:self];
    self.backgroundColor    = [UIColor blackColor];
    self.sv.backgroundColor = [UIColor redColor];
    //self.selectedImage      = [self.n selectedItemImageForMenu:self];
    UIFont *buttonFont      = [UIFont boldSystemFontOfSize:self.itemFontSize];

	self.sv.contentSize = CGSizeMake(numItems * self.frame.size.width, self.frame.size.height);
    //int hw =self.frame.size.width/2;
    //int xOffset = hw;
    
    for(int i = 0 ; i < numItems; i ++)
    {
        NSString *title = [self.dataSource menu:self titleForMenuItemAtIndex:i];
		UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton setTitle:title forState:UIControlStateNormal];
        menuButton.titleLabel.font = buttonFont;
        
        [menuButton setTitleColor:self.normalColor forState:UIControlStateNormal];
        [menuButton setTitleColor:self.focusColor forState:UIControlStateSelected];
        

        float buttonWidth = [self buttonWidthForText:title WithFont:menuButton.titleLabel.font];
        
		//menuButton.frame = CGRectMake(0,0, 100,20);
		menuButton.frame = CGRectMake(i * self.frame.size.width + (self.frame.size.width - buttonWidth)/2, 0, buttonWidth , self.frame.size.height);
        //menuButton.frame = CGRectMake(xOffset - buttonWidth/2, 7, buttonWidth, 20);
        [self.sv addSubview:menuButton];
        //xOffset += hw;
	}
    //xOffset += hw;
    //self.contentSize = CGSizeMake(xOffset, 35);
    
    [self showOrHideIndicator];
    
    [self layoutSubviews];
    [self.sv layoutSubviews];
    

}


- (CGFloat) buttonWidthForText: (NSString *) text WithFont:(UIFont *) font
{
    return [text sizeWithFont:font
             constrainedToSize:CGSizeMake(kMaxMenuItemWidth, self.frame.size.height)
                 lineBreakMode:NSLineBreakByClipping].width;
}

- (void) showOrHideIndicator
{
    if(activeIndex == 0)
        self.leftItem.hidden = YES;
    else{
        self.leftItem.hidden = NO;
        //update left item
        NSString *prev = [self.dataSource menu:self titleForMenuItemAtIndex:(activeIndex -1)];
        [self.leftItem setTitle:prev forState:UIControlStateNormal];
        float w= [self buttonWidthForText:prev WithFont:self.leftItem.titleLabel.font];
        self.leftItem.frame = CGRectMake(kMenuLeftPadding, 0, w, self.frame.size.height);
    }
    if(activeIndex == numItems - 1)
        self.rightItem.hidden = YES;
    else{
        self.rightItem.hidden = NO;
        //update right item
        NSString *next = [self.dataSource menu:self titleForMenuItemAtIndex:(activeIndex + 1)];
        [self.rightItem setTitle:next forState:UIControlStateNormal];
        float w= [self buttonWidthForText:next WithFont:self.rightItem.titleLabel.font];
        self.rightItem.frame = CGRectMake(self.frame.size.width - kMenuRightPadding - w, 0, w, self.frame.size.height);
    }
}


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //update active index
    float x = self.sv.contentOffset.x;
    activeIndex = x / self.frame.size.width;
    //load the next item
    [self showOrHideIndicator];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.leftItem.hidden = YES;
    self.rightItem.hidden = YES;
}

@end
