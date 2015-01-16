//
// RTSpinKitView.h
// SpinKit
//
// Copyright (c) 2014 Ramon Torres
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RTSpinKitViewStyle) {
    RTSpinKitViewStylePlane,
    RTSpinKitViewStyleCircleFlip,
    RTSpinKitViewStyleBounce,
    RTSpinKitViewStyleWave,
    RTSpinKitViewStyleWanderingCubes,
    RTSpinKitViewStylePulse,
    RTSpinKitViewStyleChasingDots,
    RTSpinKitViewStyleThreeBounce,
    RTSpinKitViewStyleCircle,
    RTSpinKitViewStyle9CubeGrid,
    RTSpinKitViewStyleWordPress,
    RTSpinKitViewStyleFadingCircle,
    RTSpinKitViewStyleFadingCircleAlt,
    RTSpinKitViewStyleArc,
    RTSpinKitViewStyleArcAlt
};

/**
 The `RTSpinKitView` defines an activity indicator view. It's interface is very similar
 to `UIActivityIndicatorView`.
 */
@interface RTSpinKitView : UIView

/**
 Show overlay with specific alpha, getting color and style from appearance proxy
 */
+(instancetype)showOverlay:(float)alpha;

/**
 Show overlay with specific alpha, colored and styled spinner as subview
 */
+(instancetype)showOverlay:(float)alpha withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color;

/**
 Hide overlay view with spinner
 */
+(void)hideOverlay;

/**
 Show with settings, which you can set withing appearance 
 fe [RTSpinKitView appearance].style = RTSpinKitViewStyleBounce;
    [RTSpinKitView appearance].color = [UIColor whiteColor];
 */
+(instancetype)showIn:(UIView*)view;

/**
 Show with color settings, which you can set withing appearance proxy
 fe [RTSpinKitView appearance].color = [UIColor whiteColor];
 */
+(instancetype)showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style;

/** 
 Create and show spinner in specific view
 */
+(instancetype)showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color;

/**
 Find and hide spinner in specific view
 */
+(void)hideIn:(UIView*)view;

/**
 The color of the activity indicator.
 */
@property (nonatomic, strong) UIColor *color UI_APPEARANCE_SELECTOR;

/**
 Whether or not the receiver should be hidden when not animating.
 */
@property (nonatomic, assign) BOOL hidesWhenStopped;

/**
 If showing spinner in overlay you can specify color for overlay
 */
@property (nonatomic, strong) UIColor *overlayColor UI_APPEARANCE_SELECTOR;

/**
 The style for the activity indicator.

 @see RTSpinKitViewStyle
 */
@property (nonatomic, assign) RTSpinKitViewStyle style UI_APPEARANCE_SELECTOR;

/**
 The size of the spinner. The view will be automatically resized to fit the activity indicator.
 */
@property (nonatomic, assign) CGFloat spinnerSize;

@property (nonatomic, assign, getter = isStopped) BOOL stopped;

/**
 Initializes and returns an activity indicator object.

 @param style The style of the activity indicator.
 
 @return The newly-initialized SpinKit view.
 */
-(instancetype)initWithStyle:(RTSpinKitViewStyle)style;

/**
 Initializes and returns an activity indicator object.

 @param style The style of the activity indicator.
 @param color The color of the activity indicator.

 @return The newly-initialized SpinKit view.
 */
-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color;

/**
 Initializes and returns an activity indicator object.

 Designated initializer.

 @param style The style of the activity indicator.
 @param color The color of the activity indicator.
 @param spinnerSize The size of the spinner.

 @return The newly-initialized SpinKit view.
 */
-(instancetype)initWithStyle:(RTSpinKitViewStyle)style
                       color:(UIColor*)color
                 spinnerSize:(CGFloat)spinnerSize;

/**
 Starts the animation of the activity indicator.
 */
-(void)startAnimating;

/**
 Stops the animation of the activity indicator.
 */
-(void)stopAnimating;

/**
 Returns whether the receiver is animating.

 @return `YES` if the receiver is animating, otherwise `NO`.
 */
-(BOOL)isAnimating;

@end
