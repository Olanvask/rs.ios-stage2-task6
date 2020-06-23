//
//  TriangleView.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView
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
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(0, 70)];
    [trianglePath addLineToPoint:CGPointMake(70, 70)];
    [trianglePath addLineToPoint:CGPointMake(35, 0)];
    [trianglePath closePath];
    [UIColor.blueColor setFill];
    [trianglePath fill];
}


@end
