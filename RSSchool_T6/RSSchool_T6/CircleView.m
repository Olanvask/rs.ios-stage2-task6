//
//  CircleView.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

-(id)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = UIColor.whiteColor;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.frame];
    [UIColor.redColor setFill];
    [circlePath fill];
}

@end
