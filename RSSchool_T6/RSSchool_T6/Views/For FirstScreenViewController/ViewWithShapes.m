//
//  ViewWithShapes.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
#import "TriangleView.h"
#import "CircleView.h"
#import "ViewWithShapes.h"
#import "RectangleView.h"
#import "UIColor+task6.h"
@interface ViewWithShapes()

@end

@implementation ViewWithShapes

-(instancetype)init{
    self = [super init];
    if (self){
        [self createShapes];
        [self layoutShapes];
    }
    return self;
}

//-------------------------------------------------------------------------------------------------
-(void)createShapes{
    self.circleView = [[CircleView alloc] init];
    self.triangleView = [[TriangleView alloc] init];
    self.rectangleView = [[RectangleView alloc] init];
    
}
//-------------------------------------------------------------------------------------------------
-(void) layoutShapes{
    self.backgroundColor = UIColor.task6White;
    
    [self addArrangedSubview:self.circleView];
    [self addArrangedSubview:self.rectangleView];
    [self addArrangedSubview:self.triangleView];
    
    [self makeConstraints];
    
    self.axis = UILayoutConstraintAxisHorizontal;
    self.alignment = UIStackViewAlignmentCenter;
    self.distribution = UIStackViewDistributionFill;
    self.spacing = 20;
    
}

//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    self.circleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.triangleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rectangleView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.circleView.widthAnchor constraintEqualToConstant:70],
        [self.circleView.heightAnchor constraintEqualToConstant:70],
        [self.triangleView.widthAnchor constraintEqualToConstant:70],
        [self.triangleView.heightAnchor constraintEqualToConstant:70],
        [self.rectangleView.widthAnchor constraintEqualToConstant:70],
        [self.rectangleView.heightAnchor constraintEqualToConstant:70],
    ]];
}
//-------------------------------------------------------------------------------------------------
-(void)animate{
    [self.triangleView animate];
    [self.circleView animate];
    [self.rectangleView animate];
}
@end
