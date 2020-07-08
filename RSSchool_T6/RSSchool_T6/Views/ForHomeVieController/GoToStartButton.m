//
//  GoToStartButton.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/4/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "GoToStartButton.h"
#import "UIColor+task6.h"

@implementation GoToStartButton
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.task6Red;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont systemFontOfSize:18 weight: UIFontWeightSemibold];
        [self setTitle:@"Go to start!" forState:UIControlStateNormal];
        [self setTitleColor:UIColor.task6White forState:UIControlStateNormal];
        self.clipsToBounds = YES;
    }
    return self;
}

@end
