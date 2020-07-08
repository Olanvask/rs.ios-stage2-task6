//
//  HomeViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/4/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+task6.h"
#import "ViewWithShapes.h"
#import "HeaderLabelForHomeViewController.h"
#import "PhoneInfoLabel.h"
#import "GoToStartButton.h"
#import "GitButton.h"
#import "CircleView.h"
#import "TriangleView.h"
#import "RectangleView.h"
#import "FirstScreenViewController.h"

int const OFFSET_IN_HOMEVC = 10;

int const BUTTON_WIDTH = 200;
int const BUTTON_HEIGHT = 50;

int const HEIGHT_FOR_LABELS = 50;
int const WIDTH_FOR_LABELS = 130;

@interface HomeViewController ()
@property (nonatomic,strong) UIStackView *mainStackView;
@property (nonatomic,strong) UIStackView *phoneStackView;
@property (nonatomic,strong) UIStackView *phoneInfoStackView;
@property (nonatomic,strong) ViewWithShapes *shapeStackView;
@property (nonatomic,strong) UIStackView *buttonStackView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) PhoneInfoLabel *deviceNameLabel;
@property (nonatomic,strong) PhoneInfoLabel *deviceKindLabel;
@property (nonatomic,strong) PhoneInfoLabel *deviceOSLabel;
@property (nonatomic,strong) GitButton *gitHubButton;
@property (nonatomic,strong) GoToStartButton *goToStartButton;
@property (nonatomic,strong) UIView *separatorView;
@property (nonatomic,strong) NSLayoutConstraint *bottomMainStackConstraint;
@property (nonatomic,strong) UIView *bottomSeparatorLine;
@property (nonatomic,strong) UIView *topSeparatorLine;
@property (nonatomic,strong) UIView *buttonsView;
@property (nonatomic,strong) UIView *phoneInfoConainerView;
@property (nonatomic,strong) UIView *shapeViewContainer;
@property (nonatomic,strong) UIView *gitButtonContainerView;
@property (nonatomic,strong) UIView *goToStartButtonContainerView;
@property (nonatomic,strong) NSLayoutConstraint *topMainStackConstraint;
@end

@implementation HomeViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

//-------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.task6White;
    [self setupViews];
    [self makeConstraints];
}

//-------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated{
    [self.shapeStackView animate];
    if (self.view.frame.size.width > self.view.frame.size.height){
        self.buttonStackView.axis = UILayoutConstraintAxisHorizontal;
    }else {
        self.buttonStackView.axis = UILayoutConstraintAxisVertical;
    }
}

#pragma mark - Setup views
//-------------------------------------------------------------------------------------------------
-(void)setupViews{
    
    [self setupPhoneInfoContainerView];
    
    [self setupButtonsView];
    
    [self setupMainSctackView];
    
}
//-------------------------------------------------------------------------------------------------
-(void) viewWillLayoutSubviews{
    
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
            self.buttonStackView.axis = UILayoutConstraintAxisHorizontal;
        }else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)){
            self.buttonStackView.axis = UILayoutConstraintAxisVertical;
        }
}

//-------------------------------------------------------------------------------------------------
-(void) setupPhoneInfoContainerView{
    
    self.deviceNameLabel = [PhoneInfoLabel new];
    self.deviceNameLabel.text = [[UIDevice currentDevice] name];
    self.deviceKindLabel = [PhoneInfoLabel new];
    self.deviceKindLabel.text = [[UIDevice currentDevice] systemName];
    self.deviceOSLabel = [PhoneInfoLabel new];
    self.deviceOSLabel.text = [[UIDevice currentDevice] systemVersion];
    
    self.phoneInfoStackView = [UIStackView new];
    self.phoneInfoStackView.axis = UILayoutConstraintAxisVertical;
    self.phoneInfoStackView.distribution = UIStackViewDistributionFillEqually;
    
    [self.phoneInfoStackView addArrangedSubview:self.deviceNameLabel];
    [self.phoneInfoStackView addArrangedSubview:self.deviceKindLabel];
    [self.phoneInfoStackView addArrangedSubview:self.deviceOSLabel];
    
    self.phoneStackView = [UIStackView new];
    self.phoneStackView.axis = UILayoutConstraintAxisHorizontal;
    self.phoneStackView.distribution = UIStackViewDistributionFill;
    self.phoneStackView.spacing = OFFSET_IN_HOMEVC;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple"]];
   
    [self.phoneStackView addArrangedSubview:self.imageView];
    [self.phoneStackView addArrangedSubview:self.phoneInfoStackView];
    
    self.phoneInfoConainerView = [UIView new];
    [self.phoneInfoConainerView addSubview:self.phoneStackView];
    
}

//-------------------------------------------------------------------------------------------------
-(void)setupButtonsView{
    
    self.gitHubButton = [GitButton new];
    self.gitHubButton.layer.cornerRadius = BUTTON_HEIGHT/2;
    [self.gitHubButton addTarget:self action:@selector(gitHubButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    
    self.goToStartButton = [GoToStartButton new];
    self.goToStartButton.layer.cornerRadius = BUTTON_HEIGHT/2;
    [self.goToStartButton addTarget:self action:@selector(goToStartButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    
    self.goToStartButtonContainerView = [UIView new];
    [self.goToStartButtonContainerView addSubview:self.goToStartButton];
    
    self.gitButtonContainerView = [UIView new];
    [self.gitButtonContainerView addSubview:self.gitHubButton];
    
    
    self.buttonStackView = [UIStackView new];
    self.buttonStackView.spacing = 20;
    self.buttonStackView.axis = UILayoutConstraintAxisVertical;
    self.buttonStackView.distribution = UIStackViewDistributionFillEqually;
    [self.buttonStackView addArrangedSubview:self.gitButtonContainerView];
    [self.buttonStackView addArrangedSubview:self.goToStartButtonContainerView];
    
    self.buttonsView = [UIView new];
    
    [self.buttonsView addSubview:self.buttonStackView];
    
}
//-------------------------------------------------------------------------------------------------
-(void)setupMainSctackView{
    
    self.mainStackView = [UIStackView new];
     self.mainStackView.axis = UILayoutConstraintAxisVertical;
     self.mainStackView.alignment = UIStackViewAlignmentCenter;
     self.mainStackView.distribution = UIStackViewDistributionEqualSpacing;
     self.mainStackView.spacing = 15;
    
     [self.mainStackView addArrangedSubview:self.phoneInfoConainerView];
     
     self.topSeparatorLine = [UIView new];
     self.topSeparatorLine.backgroundColor = UIColor.task6Gray;
     [self.mainStackView addArrangedSubview:self.topSeparatorLine];
     
     self.shapeViewContainer = [UIView new];
     self.shapeStackView = [ViewWithShapes new];
     [self.shapeViewContainer addSubview:self.shapeStackView];
    
     [self.mainStackView addArrangedSubview:self.shapeViewContainer];
     
     
     self.bottomSeparatorLine = [UIView new];
     self.bottomSeparatorLine.backgroundColor = UIColor.task6Gray;
    
     [self.mainStackView addArrangedSubview:self.bottomSeparatorLine];
     
     [self.mainStackView addArrangedSubview:self.buttonsView];
    
    [self.view addSubview:self.mainStackView];
    
}
#pragma mark - Setup constraints
//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomMainStackConstraint = [NSLayoutConstraint new];
    self.bottomMainStackConstraint = [self.mainStackView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant:  - self.view.frame.size.height / 6.5];
    self.topMainStackConstraint = [self.mainStackView.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:  self.view.frame.size.height / 7];
    
    [NSLayoutConstraint activateConstraints:@[
        self.topMainStackConstraint,
        [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant: OFFSET_IN_HOMEVC],
        [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-OFFSET_IN_HOMEVC],
        self.bottomMainStackConstraint,
    ]];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneInfoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.widthAnchor constraintEqualToConstant:70],
        [self.imageView.heightAnchor constraintEqualToConstant:70],
        
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [ self.deviceOSLabel.widthAnchor constraintEqualToConstant:WIDTH_FOR_LABELS],
        [ self.deviceNameLabel.widthAnchor constraintEqualToConstant:WIDTH_FOR_LABELS],
        [ self.deviceKindLabel.widthAnchor constraintEqualToConstant:WIDTH_FOR_LABELS],
        [ self.deviceOSLabel.heightAnchor constraintEqualToConstant:HEIGHT_FOR_LABELS],
        [ self.deviceNameLabel.heightAnchor constraintEqualToConstant:HEIGHT_FOR_LABELS],
        [ self.deviceKindLabel.heightAnchor constraintEqualToConstant:HEIGHT_FOR_LABELS],
    ]];
    
    self.phoneStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.phoneInfoConainerView.widthAnchor constraintEqualToAnchor:self.phoneStackView.widthAnchor],
        [self.phoneInfoConainerView.heightAnchor constraintEqualToAnchor:self.phoneStackView.heightAnchor],
        [self.phoneStackView.centerXAnchor constraintEqualToAnchor:self.phoneInfoConainerView.centerXAnchor],
        [self.phoneStackView.centerYAnchor constraintEqualToAnchor:self.phoneInfoConainerView.centerYAnchor],
        [self.phoneStackView.heightAnchor constraintEqualToConstant:75],
    ]];
    
    self.shapeStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.shapeViewContainer.widthAnchor constraintEqualToAnchor:self.shapeStackView.widthAnchor],
        [self.shapeViewContainer.heightAnchor constraintEqualToAnchor:self.shapeStackView.heightAnchor],
        [self.shapeStackView.centerXAnchor constraintEqualToAnchor:self.shapeViewContainer.centerXAnchor],
        [self.shapeStackView.centerYAnchor constraintEqualToAnchor:self.shapeViewContainer.centerYAnchor],
        [self.shapeStackView.heightAnchor constraintEqualToConstant:75],
    ]];

    [NSLayoutConstraint activateConstraints:@[
        [self.topSeparatorLine.widthAnchor constraintEqualToConstant:self.view.bounds.size.width*0.6],
        [self.topSeparatorLine.heightAnchor constraintEqualToConstant:2],
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.bottomSeparatorLine.widthAnchor constraintEqualToConstant:self.view.bounds.size.width*0.6],
        [self.bottomSeparatorLine.heightAnchor constraintEqualToConstant:2],
    ]];
    
    self.buttonStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.buttonStackView.centerXAnchor constraintEqualToAnchor: self.buttonsView.centerXAnchor],
        [self.buttonStackView.centerYAnchor constraintEqualToAnchor: self.buttonsView.centerYAnchor],
        [self.buttonsView.widthAnchor constraintEqualToAnchor: self.buttonStackView.widthAnchor],
        [self.buttonsView.heightAnchor constraintEqualToAnchor: self.buttonStackView.heightAnchor],
    ]];
    
    self.gitHubButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.goToStartButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.gitButtonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.goToStartButtonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.gitHubButton.widthAnchor constraintEqualToConstant:BUTTON_WIDTH],
        [self.gitHubButton.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT],
        [self.gitHubButton.centerXAnchor constraintEqualToAnchor:self.gitButtonContainerView.centerXAnchor],
        [self.gitHubButton.centerYAnchor constraintEqualToAnchor:self.gitButtonContainerView.centerYAnchor],
        [self.gitButtonContainerView.widthAnchor constraintEqualToConstant:BUTTON_WIDTH],
        [self.gitButtonContainerView.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT],
        
        [self.goToStartButton.widthAnchor constraintEqualToConstant:BUTTON_WIDTH],
        [self.goToStartButton.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT],
        [self.goToStartButton.centerXAnchor constraintEqualToAnchor:self.goToStartButtonContainerView.centerXAnchor],
        [self.goToStartButton.centerYAnchor constraintEqualToAnchor:self.goToStartButtonContainerView.centerYAnchor],
        [self.goToStartButtonContainerView.widthAnchor constraintEqualToConstant:BUTTON_WIDTH],
        [self.goToStartButtonContainerView.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT],
    ]];
}

//-------------------------------------------------------------------------------------------------
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        self.buttonStackView.axis = UILayoutConstraintAxisHorizontal;
    }else if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)){
        self.buttonStackView.axis = UILayoutConstraintAxisVertical;
    }
    
    [NSLayoutConstraint deactivateConstraints:@[
        self.bottomMainStackConstraint,
        self.topMainStackConstraint,
    ]];
    
    self.bottomMainStackConstraint = [self.mainStackView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant:  - size.height / 6.5];
    self.topMainStackConstraint = [self.mainStackView.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:  size.height / 7];
    
    [NSLayoutConstraint activateConstraints:@[
        self.bottomMainStackConstraint,
        self.topMainStackConstraint,
    ]];
        
}
#pragma mark - Button actions
//-------------------------------------------------------------------------------------------------
-(void)goToStartButtonTaped{
    
    FirstScreenViewController *firstScreenViewController = [FirstScreenViewController new];
    [self.view.window setRootViewController:firstScreenViewController];
}

//-------------------------------------------------------------------------------------------------
-(void)gitHubButtonTaped{
    
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:@"https://olanvask.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}
    
@end
