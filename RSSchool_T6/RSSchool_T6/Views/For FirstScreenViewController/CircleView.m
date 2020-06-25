//
//  CircleView.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "CircleView.h"
#import "UIColor+task6.h"
@implementation CircleView

-(instancetype)init{
   self = [super init];
    if (self){
        self.backgroundColor = UIColor.task6White;
        [self animate];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [ circlePath addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2 startAngle:0 endAngle:3.14159*2 clockwise:YES];
    [UIColor.task6Red setFill];
    [circlePath fill];
}

-(void)animate{
    [UIView animateWithDuration:1.0 delay:0 options: (UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
        [self setTransform: CGAffineTransformMakeScale(1.2, 1.2)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self setTransform: CGAffineTransformMakeScale(1, 1)];
            [self animate];
        }
    }];
}

@end
