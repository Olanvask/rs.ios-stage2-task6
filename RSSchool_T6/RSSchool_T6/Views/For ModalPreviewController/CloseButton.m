//
//  CloseButton.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/30/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "CloseButton.h"
#import "UIColor+task6.h"
@implementation CloseButton

-(instancetype)init{
    self = [super init];
    if (self){
        self.backgroundColor = UIColor.task6White;
        self.titleLabel.textColor = UIColor.task6Black;
        self.titleLabel.font = [UIFont systemFontOfSize:18 weight: UIFontWeightMedium];
        [self setTitleColor:UIColor.task6Black forState:UIControlStateNormal];
        [self setTitle:@"X" forState:UIControlStateNormal];
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.task6Black.CGColor;
        self.layer.cornerRadius = 20;
        
    }
    return self;
}

@end
