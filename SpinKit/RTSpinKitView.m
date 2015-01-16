//
// RTSpinKitView.m
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

#import "RTSpinKitView.h"
#import "RTSpinKitUtils.h"

#include <tgmath.h>

static const CGFloat kRTSpinKitViewDefaultSpinnerSize = 37.0;

static int SPIN_OVERLAY_TAG = 1111;

@implementation RTSpinKitView

// show overlay with specific alpha, getting color and style from appearance proxy
+(instancetype)showOverlay:(float)alpha {
  if (![RTSpinKitView appearance].color) [RTSpinKitView appearance].color = [UIColor blackColor];
  return [RTSpinKitView showOverlay:alpha withStyle:[RTSpinKitView appearance].style andColor:[RTSpinKitView appearance].color];
}

// show overlay with specific alpha, colored and styled spinner as subview
+(instancetype)showOverlay:(float)alpha withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color {
  UIWindow* window = [[UIApplication sharedApplication] keyWindow];
  UIView* overlay = [UIView new];
  overlay.tag = SPIN_OVERLAY_TAG;
  overlay.frame = window.frame;
  overlay.alpha = alpha;
  UIColor* overlayColor = [RTSpinKitView appearance].overlayColor;
  if (!overlayColor) overlayColor = [UIColor blackColor];
  // get color from appearance proxy 
  overlay.backgroundColor = overlayColor;
  [window addSubview:overlay];
  // add as window child to prevent alpha influence
  return [RTSpinKitView showIn:window];
}

// show with settings, which you can set withing appearance proxy
// fe [RTSpinKitView appearance].style = RTSpinKitViewStyleBounce;
//    [RTSpinKitView appearance].color = [UIColor whiteColor];
+(instancetype)showIn:(UIView*)view {
  if (![RTSpinKitView appearance].color) [RTSpinKitView appearance].color = [UIColor blackColor];
  return [RTSpinKitView showIn:view
                     withStyle:[RTSpinKitView appearance].style
                      andColor:[RTSpinKitView appearance].color];
}

// show with color settings, which you can set withing appearance proxy
// fe [RTSpinKitView appearance].color = [UIColor whiteColor];
+(instancetype)showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style {
  if (![RTSpinKitView appearance].color) [RTSpinKitView appearance].color = [UIColor blackColor];
  return [RTSpinKitView showIn:view
                     withStyle:style
                      andColor:[RTSpinKitView appearance].color];
}

// create and show spinner in specific view
+(instancetype)showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color {
  RTSpinKitView* spinner = [[RTSpinKitView alloc] initWithStyle:style color:color];
  // show spinner in the superview center
  spinner.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
  spinner.hidesWhenStopped = YES;
  [spinner startAnimating];
  [view addSubview:spinner];
  return spinner;
}

// hide overlay view with spinner
+(void)hideOverlay {
  UIWindow* window = [[UIApplication sharedApplication] keyWindow];
  for (UIView* sub in window.subviews) {
    if (sub.tag == SPIN_OVERLAY_TAG || [sub isKindOfClass:[RTSpinKitView class]]) {
      [sub removeFromSuperview];
    }
  }
}

// find and hide spinner in specific view
+(void)hideIn:(UIView*) view {
  for (UIView* sub in view.subviews) {
    if ([sub isKindOfClass:[RTSpinKitView class]]) {
      [sub removeFromSuperview];
    }
  }
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style {
    return [self initWithStyle:style color:[UIColor grayColor]];
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor *)color {
    return [self initWithStyle:style color:color spinnerSize:kRTSpinKitViewDefaultSpinnerSize];
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color spinnerSize:(CGFloat)spinnerSize {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, spinnerSize, spinnerSize)];
    if (self) {
        _style = style;
        [self setColor:color];
        _color = color;
        _spinnerSize = spinnerSize;
        _hidesWhenStopped = YES;
        [self applyAnimation];
        [self sizeToFit];
    }
    return self;
}

-(void)setStyle:(RTSpinKitViewStyle)style {
    _style = style;
    [self applyAnimation];
}

-(void)setSpinnerSize:(CGFloat)spinnerSize {
    _spinnerSize = spinnerSize;
    [self applyAnimation];
    [self invalidateIntrinsicContentSize];
}

#pragma mark - Animation

-(void)applyAnimation {
    // Remove any sublayer.
    self.layer.sublayers = nil;

    CGSize size = CGSizeMake(self.spinnerSize, self.spinnerSize);
    NSObject<RTSpinKitAnimating> *animation = RTSpinKitAnimationFromStyle(self.style);
    [animation setupSpinKitAnimationInLayer:self.layer withSize:size color:self.color];
}

#pragma mark - Hooks

-(void)applicationWillEnterForeground {
    if (self.stopped) {
        [self pauseLayers];
    } else {
        [self resumeLayers];
    }
}

-(void)applicationDidEnterBackground {
    [self pauseLayers];
}

-(BOOL)isAnimating {
    return !self.isStopped;
}

-(void)startAnimating {
    if (self.isStopped) {
        self.hidden = NO;
        self.stopped = NO;
        [self resumeLayers];
    }
}

-(void)stopAnimating {
    if ([self isAnimating]) {
        if (self.hidesWhenStopped) {
            self.hidden = YES;
        }
        
        self.stopped = YES;
        [self pauseLayers];
    }
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(self.spinnerSize, self.spinnerSize);
}

-(CGSize)intrinsicContentSize {
    return CGSizeMake(self.spinnerSize, self.spinnerSize);
}

-(void)setColor:(UIColor *)color {
    _color = color;
    for (CALayer *l in self.layer.sublayers) {
        l.backgroundColor = color.CGColor;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
