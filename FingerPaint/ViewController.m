//
//  ViewController.m
//  FingerPaint
//
//  Created by Jun Oh on 2019-01-18.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@property (nonatomic) UISlider* redSlider;
@property (nonatomic) UISlider* greenSlider;
@property (nonatomic) UISlider* blueSlider;
@property (nonatomic) UIView* sampleColorBox;
@property (nonatomic) DrawView* drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DrawView* drawView = [[DrawView alloc] initWithFrame:CGRectZero];
    
    drawView.translatesAutoresizingMaskIntoConstraints = NO;
    drawView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:drawView];
    
    [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0].active = YES;
    
    UISlider* redSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    redSlider.translatesAutoresizingMaskIntoConstraints = NO;
    redSlider.minimumValue = 0.0;
    redSlider.maximumValue = 255.0;
    [self.view addSubview:redSlider];
    [redSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [NSLayoutConstraint constraintWithItem:redSlider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:redSlider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:redSlider attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:redSlider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:drawView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
    UISlider* greenSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    greenSlider.translatesAutoresizingMaskIntoConstraints = NO;
    greenSlider.minimumValue = 0.0;
    greenSlider.maximumValue = 255.0;
    [self.view addSubview:greenSlider];
    [greenSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [NSLayoutConstraint constraintWithItem:greenSlider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redSlider attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:greenSlider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:greenSlider attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:redSlider attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:greenSlider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:redSlider attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
    UISlider* blueSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    blueSlider.translatesAutoresizingMaskIntoConstraints = NO;
    blueSlider.minimumValue = 0.0;
    blueSlider.maximumValue = 255.0;
    [self.view addSubview:blueSlider];
    [blueSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [NSLayoutConstraint constraintWithItem:blueSlider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redSlider attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueSlider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueSlider attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:redSlider attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueSlider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:greenSlider attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
    UIView* sampleBoxView = [[UIView alloc] initWithFrame:CGRectZero];
    sampleBoxView.translatesAutoresizingMaskIntoConstraints = NO;
    sampleBoxView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:sampleBoxView];
    
    [NSLayoutConstraint constraintWithItem:sampleBoxView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0].active = YES;
    [NSLayoutConstraint constraintWithItem:sampleBoxView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:sampleBoxView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:sampleBoxView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:greenSlider attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:sampleBoxView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:greenSlider attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-50.0].active = YES;
    
    self.drawView = drawView;
    self.redSlider = redSlider;
    self.greenSlider = greenSlider;
    self.blueSlider = blueSlider;
    self.sampleColorBox = sampleBoxView;
}

- (void) sliderChanged:(UISlider *)sender {
    self.sampleColorBox.backgroundColor = [UIColor colorWithRed:self.redSlider.value / 255.0 green:self.greenSlider.value / 255.0 blue:self.blueSlider.value / 255.0 alpha:1.0];
    
    self.drawView.inputColor = self.sampleColorBox.backgroundColor;
    
}


@end
