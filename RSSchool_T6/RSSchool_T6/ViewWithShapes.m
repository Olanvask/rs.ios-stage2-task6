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
@interface ViewWithShapes()

@end

@implementation ViewWithShapes

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self layoutShapes];
    }
    return self;
}
-(void) layoutShapes{
    self.backgroundColor = UIColor.whiteColor;
    UIStackView *stackView = [UIStackView new];
    [NSLayoutConstraint activateConstraints:@[
        [stackView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    CircleView *circleView = [CircleView new];
    TriangleView *triangleView = [TriangleView new];
    [stackView addArrangedSubview:circleView];
    [stackView addArrangedSubview:triangleView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
