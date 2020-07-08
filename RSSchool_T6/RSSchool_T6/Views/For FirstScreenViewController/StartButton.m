//
//  StartButton.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/24/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
#import "UIColor+task6.h"
#import "StartButton.h"

@implementation StartButton
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.task6Yellow;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont systemFontOfSize:20 weight: UIFontWeightMedium];
        [self setTitle:@"START" forState:UIControlStateNormal];
        [self setTitleColor:UIColor.task6Black forState:UIControlStateNormal];
    }
    return self;
}

@end
