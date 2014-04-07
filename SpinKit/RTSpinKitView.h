//
//  RTSpinKitView.h
//  SpinKit
//
//  Created by Ramon Torres on 1/1/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RTSpinKitViewStyle) {
    RTSpinKitViewStylePlane,
    RTSpinKitViewStyleBounce,
    RTSpinKitViewStyleWave,
    RTSpinKitViewStyleWanderingCubes,
    RTSpinKitViewStylePulse,
};

@interface RTSpinKitView : UIView

@property (nonatomic, strong) UIColor *color UI_APPEARANCE_SELECTOR;
// this property is using through appearance proxy only 
@property (nonatomic, strong) UIColor *overlayColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) RTSpinKitViewStyle style UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL hidesWhenStopped;

// show overlay with specific alpha, getting color and style from appearance proxy
+(instancetype)showOverlay:(float)alpha;

// show overlay with specific alpha, colored and styled spinner as subview
+(instancetype)showOverlay:(float)alpha withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color;

// hide overlay view with spinner
+(void)hideOverlay;

// show with settings, which you can set withing appearance proxy
// fe [RTSpinKitView appearance].style = RTSpinKitViewStyleBounce;
//    [RTSpinKitView appearance].color = [UIColor whiteColor];
+(instancetype)showIn:(UIView*)view;

// show with color settings, which you can set withing appearance proxy
// fe [RTSpinKitView appearance].color = [UIColor whiteColor];
+(instancetype)showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style;

// create and show spinner in specific view
+(instancetype)showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color;

// find and hide spinner in specific view
+(void)hideIn:(UIView*)view;

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style;
-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color;

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;

@end
