//
//  RectangleView.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/24/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
#import "UIColor+task6.h"
#import "RectangleView.h"

@implementation RectangleView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.task6Blue;
        [self animate];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(0, 0)];
    [trianglePath addLineToPoint:CGPointMake(0, 70)];
    [trianglePath addLineToPoint:CGPointMake(70, 70)];
    [trianglePath addLineToPoint:CGPointMake(70, 0)];
    [UIColor.task6Blue setFill];
    [UIColor.task6Blue setStroke];
    [trianglePath closePath];
    
}

-(void)animate{
    [UIView animateWithDuration:1.0 delay:0 options: (UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
        [self setTransform: CGAffineTransformMakeTranslation(0, 10)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self setTransform: CGAffineTransformMakeTranslation(0, 0)];
            [self animate];
            
        }
    }];
}
@end
