//
//  LoaderView.h
//  Boku
//
//  Created by Ghanshyam on 8/12/15.
//  Copyright (c) 2015 Plural Voice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoaderView : UIView{
    /**
     *  Identifier to track how much strongly refered these LoaderView in App and how many relinquished ownership for this loader.
     */
    int retainCount;
    
    /// Reference to left constraint of activity
    IBOutlet NSLayoutConstraint *leftConstraint;
    
    IBOutlet NSLayoutConstraint *topConstraint;
}

@property (nonatomic,weak)  IBOutlet    UIActivityIndicatorView     *activity;

/**
 *  Used to show Activity Indicator at specified position
 */
-(void)showAtPosition:(CGPoint)position;

/**
 *  Used to show loader view on main window and it increase retaincount for its ownership
 */
-(void)show;


/**
 *  Used to show loader view on main window and it increase retaincount for its ownership
 */
-(void)hide;

@end
