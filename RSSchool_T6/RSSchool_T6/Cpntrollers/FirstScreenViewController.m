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
@interface FirstScreenViewController()

@property (nonatomic, strong) UIStackView *verticalStackView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) HeaderLabelForFirstScreen *label;
@property (nonatomic,strong) ViewWithShapes *viewWithShapes;
@end

@implementation FirstScreenViewController
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = UIColor.task6White;
    
    [self createSubviews];
    
    [self.view addSubview:self.verticalStackView];
    
    [self adjustStackView];
    
    [self makeConstraints];
    
    self.startButton.layer.cornerRadius = 25;
    [self.startButton addTarget:self action:@selector(startButonTapped) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)adjustStackView{
    [self.verticalStackView addArrangedSubview:self.label];
    [self.verticalStackView addArrangedSubview:self.viewWithShapes];
    [self.verticalStackView addArrangedSubview:self.startButton];
    self.verticalStackView.axis = UILayoutConstraintAxisVertical;
    self.verticalStackView.alignment = UIStackViewAlignmentCenter;
    self.verticalStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.verticalStackView.spacing = 20;
}

-(void)createSubviews{
    self.verticalStackView = [[UIStackView alloc] init];
    self.viewWithShapes = [[ViewWithShapes alloc] init];
    self.startButton = [StartButton new];
    self.label = [HeaderLabelForFirstScreen new];
}

-(void)makeConstraints{
    self.verticalStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewWithShapes.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.verticalStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.verticalStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.verticalStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: 100],
        [self.verticalStackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-100],
        [self.startButton.heightAnchor constraintGreaterThanOrEqualToConstant:55],
        [self.startButton.widthAnchor constraintGreaterThanOrEqualToConstant:200],
        [self.viewWithShapes.heightAnchor constraintEqualToConstant:75],
    ]];}

- (void)startButonTapped {
    PHAuthorizationStatus code = [PHPhotoLibrary authorizationStatus];
    switch (code) {
        case PHAuthorizationStatusNotDetermined:
            [self requestAuthorization];
            break;
            
        case PHAuthorizationStatusAuthorized:
            [self callController];
            break;
        default:
            break;
    }
}

-(void)callController{
    GalleryViewController *galleryController = [[GalleryViewController alloc] init];
    [self.navigationController pushViewController:galleryController animated: YES];
}

- (void) requestAuthorization {
    __weak typeof(self) weakSelf = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            
            [weakSelf callController];
            
        }
    }];
}
@end
