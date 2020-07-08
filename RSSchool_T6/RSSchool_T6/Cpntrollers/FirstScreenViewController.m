//
//  FirstScreenViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "FirstScreenViewController.h"
#import "GalleryViewController.h"
#import "HeaderLabelForFirstScreen.h"
#import "UIColor+task6.h"
#import "Photos/Photos.h"
#import "ViewWithShapes.h"
#import "StartButton.h"
#import "TabBarControllerViewController.h"

const int OFFSET_FOR_VERTICAL_STACK_FIRSTVC = 70;
const int START_BUTTON_WIDTH = 200;
const int START_BUTTON_HEIGHT = 55;
const int SHAPE_SIZE = 70;
const int VIEW_IN_STACK_WIDTH = 200;
const int VIEW_IN_STACK_HEIGHT = 100;

@interface FirstScreenViewController()
@property (nonatomic, strong) UIStackView *verticalStackView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) HeaderLabelForFirstScreen *label;
@property (nonatomic, strong) ViewWithShapes *viewWithShapes;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIView *labelView;
@end

@implementation FirstScreenViewController
//-------------------------------------------------------------------------------------------------
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark - Create subviews
//-------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = UIColor.task6White;
    
    [self createSubviews];
    
    [self.view addSubview:self.verticalStackView];
    
    [self adjustStackView];
    
    [self makeConstraints];
    
    self.startButton.layer.cornerRadius = START_BUTTON_HEIGHT / 2;
    [self.startButton addTarget:self action:@selector(startButonTapped) forControlEvents:UIControlEventTouchUpInside];
}

//-------------------------------------------------------------------------------------------------
-(void)adjustStackView{
    
    [self.verticalStackView addArrangedSubview:self.labelView];
    [self.verticalStackView addArrangedSubview:self.viewWithShapes];
    [self.verticalStackView addArrangedSubview:self.buttonView];
    
    self.verticalStackView.axis = UILayoutConstraintAxisVertical;
    self.verticalStackView.alignment = UIStackViewAlignmentCenter;
    self.verticalStackView.distribution = UIStackViewDistributionFillEqually;
}

//-------------------------------------------------------------------------------------------------
-(void)createSubviews{
    
    self.verticalStackView = [UIStackView new];
    self.buttonView = [UIView new];
    self.labelView = [UIView new];
    self.viewWithShapes = [ViewWithShapes new];
    self.startButton = [StartButton new];
    self.label = [HeaderLabelForFirstScreen new];
    
    [self.labelView addSubview:self.label];
    [self.buttonView addSubview:self.startButton];
}
#pragma mark - Setup constraints
//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.verticalStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewWithShapes.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.verticalStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.verticalStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.verticalStackView.topAnchor constraintLessThanOrEqualToAnchor:self.view.topAnchor constant: OFFSET_FOR_VERTICAL_STACK_FIRSTVC],
        [self.verticalStackView.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.view.bottomAnchor constant:-OFFSET_FOR_VERTICAL_STACK_FIRSTVC],
        
        [self.startButton.heightAnchor constraintEqualToConstant:START_BUTTON_HEIGHT],
        [self.startButton.widthAnchor constraintEqualToConstant:START_BUTTON_WIDTH],
        [self.startButton.centerXAnchor constraintEqualToAnchor:self.buttonView.centerXAnchor],
        [self.startButton.centerYAnchor constraintEqualToAnchor:self.buttonView.centerYAnchor],
        
        [self.label.centerXAnchor constraintEqualToAnchor:self.labelView.centerXAnchor],
        [self.label.centerYAnchor constraintEqualToAnchor:self.labelView.centerYAnchor],
        
        [self.viewWithShapes.heightAnchor constraintEqualToConstant: SHAPE_SIZE],
        [self.viewWithShapes.circleView.heightAnchor constraintEqualToConstant: SHAPE_SIZE],
        [self.viewWithShapes.circleView.widthAnchor constraintEqualToConstant: SHAPE_SIZE],
        [self.viewWithShapes.triangleView.heightAnchor constraintEqualToConstant: SHAPE_SIZE],
        [self.viewWithShapes.triangleView.widthAnchor constraintEqualToConstant: SHAPE_SIZE],
        [self.viewWithShapes.rectangleView.heightAnchor constraintEqualToConstant: SHAPE_SIZE],
        [self.viewWithShapes.rectangleView.widthAnchor constraintEqualToConstant: SHAPE_SIZE],
        
        [self.labelView.heightAnchor constraintEqualToConstant:VIEW_IN_STACK_HEIGHT],
        [self.labelView.widthAnchor constraintEqualToConstant:VIEW_IN_STACK_WIDTH],
        
        [self.buttonView.heightAnchor constraintEqualToConstant:VIEW_IN_STACK_HEIGHT],
        [self.buttonView.widthAnchor constraintEqualToConstant:VIEW_IN_STACK_WIDTH],
    ]];

}
#pragma mark - Button action
//-------------------------------------------------------------------------------------------------
- (void)startButonTapped {
    
  TabBarControllerViewController *tabBarController = [TabBarControllerViewController new];
  self.view.window.rootViewController = tabBarController;
}

@end
