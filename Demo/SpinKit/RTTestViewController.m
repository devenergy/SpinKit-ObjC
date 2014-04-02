//
//  RTTestViewController.m
//  SpinKit
//
//  Created by Ramon Torres on 1/1/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTTestViewController.h"
#import "RTSpinKitView.h"

@interface RTTestViewController ()

@end

@implementation RTTestViewController

-(void)insertSpinner:(RTSpinKitViewStyle)style
             atIndex:(NSInteger)index
     backgroundColor:(UIColor*)backgroundColor
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
    UIView *panel = [[UIView alloc] initWithFrame:CGRectOffset(screenBounds, screenWidth * index, 0.0)];
    panel.backgroundColor = backgroundColor;
  
    [RTSpinKitView showIn:panel withStyle:style]; // or you can use showIn:(UIView*)view withStyle:(RTSpinKitViewStyle)style andColor:(UIColor*) color

    UIScrollView *scrollView = (UIScrollView*)self.view;
    [scrollView addSubview:panel];
}

-(void)loadView {
    // you can set params with Appearance proxy
    // [RTSpinKitView appearance].style for cross application spinner
    [RTSpinKitView appearance].color = [UIColor whiteColor];
  
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.backgroundColor = [UIColor darkGrayColor];
    self.view = scrollView;

    [self insertSpinner:RTSpinKitViewStylePlane
                atIndex:0
        backgroundColor:[UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1.0]];

    [self insertSpinner:RTSpinKitViewStyleBounce
                atIndex:1
        backgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1.0]];

    [self insertSpinner:RTSpinKitViewStyleWave
                atIndex:2
        backgroundColor:[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.0]];

    [self insertSpinner:RTSpinKitViewStyleWanderingCubes
                atIndex:3
        backgroundColor:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1.0]];

    [self insertSpinner:RTSpinKitViewStylePulse
                atIndex:4
        backgroundColor:[UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1.0]];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    scrollView.contentSize = CGSizeMake(5 * CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
