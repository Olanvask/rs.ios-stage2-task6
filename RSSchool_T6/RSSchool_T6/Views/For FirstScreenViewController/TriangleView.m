//
//  TriangleView.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
#import "UIColor+task6.h"
#import "TriangleView.h"

@implementation TriangleView

-(instancetype)init{
   self = [super init];
    if (self){
        self.backgroundColor = UIColor.task6Green;
        [self animate];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(35, 0)];
    [trianglePath addLineToPoint:CGPointMake(70, 70)];
    [trianglePath addLineToPoint:CGPointMake(0, 70)];
    [trianglePath closePath];
    [UIColor.task6Green setFill];
    [UIColor.task6Green setStroke];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = trianglePath.CGPath;
    [self.layer addSublayer:shapeLayer];
    self.layer.mask = shapeLayer;
}
-(void)animate{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setTransform:CGAffineTransformRotate(self.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished) {
            [self animate];
        }
    }];
}

@end
