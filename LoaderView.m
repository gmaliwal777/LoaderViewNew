//
//  LoaderView.m
//  Boku
//
//  Created by Ghanshyam on 8/12/15.
//  Copyright (c) 2015 Plural Voice. All rights reserved.
//

#import "LoaderView.h"
#import "AppDelegate.h"

@implementation LoaderView

#pragma mark - Super Class Methods 

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"LoaderView" owner:self options:nil] lastObject];
        retainCount = 0;
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    self.frame = [UIScreen mainScreen].bounds;
}

#pragma mark - Instance methods


/**
 *  Used to show loader view on main window and it increase retaincount for its ownership
 */
- (void)show {
    
    UIViewController *viewController = nil;
    
    UIWindow *window = [APPDELEGATE window];
    
    if ([APPDELEGATE.containerController isKindOfClass:[UINavigationController class]]) {
        
        viewController = [(UINavigationController*)APPDELEGATE.containerController topViewController];
        
    }else if ([APPDELEGATE.containerController isKindOfClass:[UITabBarController class]]) {
        
        UINavigationController *navController = (UINavigationController*)[(UITabBarController*)APPDELEGATE.containerController selectedViewController];
        
        viewController = [navController topViewController];
    }
    
    float width = 0.f;
    
    if (viewController != nil) {

        if ([viewController.navigationItem.leftBarButtonItems count] != 0) {
            
            for (UIBarButtonItem *item in viewController.navigationItem.leftBarButtonItems) {
                
                if (item.customView != nil) {
                    width += item.customView.frame.size.width;
                }else {
                    width += item.width;
                }
            }
        }else if (viewController.navigationItem.leftBarButtonItem != nil) {
            if (viewController.navigationItem.leftBarButtonItem.customView != nil) {
                width = viewController.navigationItem.leftBarButtonItem.customView.frame.size.width;
            }else {
                width = viewController.navigationItem.leftBarButtonItem.width;
            }
        }else if (viewController.navigationItem.backBarButtonItem != nil) {
            if (viewController.navigationItem.backBarButtonItem.customView != nil) {
                width = viewController.navigationItem.backBarButtonItem.customView.frame.size.width;
            }else {
                width = viewController.navigationItem.backBarButtonItem.width;
            }
        }

    }else {
        width = 10.f;
    }
    
    leftConstraint.constant = width+10.f;
    topConstraint.constant = 32.0f;
    
    [self layoutIfNeeded];

    
    
    //Ghanshyam code
    
    if (retainCount == 0) {
        [_activity startAnimating];
        [window addSubview:self];
    }
    [window bringSubviewToFront:self];
    
    retainCount++;
    
    NSLog(@"retain count in Show is == %d",retainCount);
    
}

/**
 *  Used to show Activity Indicator at specified position
 */
-(void)showAtPosition:(CGPoint)position{
    
    UIViewController *viewController = nil;
    
    UIWindow *window = [APPDELEGATE window];
    
    if ([APPDELEGATE.containerController isKindOfClass:[UINavigationController class]]) {
        
        viewController = [(UINavigationController*)APPDELEGATE.containerController topViewController];
        
    }else if ([APPDELEGATE.containerController isKindOfClass:[UITabBarController class]]) {
        
        UINavigationController *navController = (UINavigationController*)[(UITabBarController*)APPDELEGATE.containerController selectedViewController];
        
        viewController = [navController topViewController];
    }
    
    if (viewController.navigationItem.leftBarButtonItems.count>0) {
        [self show];
        return;
    }
    
    leftConstraint.constant = position.x+10.f;
    topConstraint.constant = position.y;
    [self layoutIfNeeded];
    
    
    
    //Ghanshyam code
    
    if (retainCount == 0) {
        [_activity startAnimating];
        [window addSubview:self];
    }
    [window bringSubviewToFront:self];
    
    retainCount++;
    
    NSLog(@"retain count in Show is == %d",retainCount);
    
}

/**
 *  Used to show loader view on main window and it increase retaincount for its ownership
 */
-(void)hide{
    if (retainCount>0) {
        retainCount--;
        if (retainCount == 0) {
            [_activity stopAnimating];
            [self removeFromSuperview];
            NSLog(@"removed loader");
        }
    }

    NSLog(@"retain count in hide is == %d",retainCount);
    
}

@end
