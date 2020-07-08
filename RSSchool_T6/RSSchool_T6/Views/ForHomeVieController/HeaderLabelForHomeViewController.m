//
//  HeaderLabelForHomeViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/4/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "HeaderLabelForHomeViewController.h"
#import "UIColor+task6.h"

@implementation HeaderLabelForHomeViewController
-(instancetype)init{
    self = [super init];
    if (self){
        self.font = [UIFont systemFontOfSize:24 weight: UIFontWeightMedium];
        self.textColor = UIColor.task6Black;
        self.text = @"RSSchool Task 6";
        self.backgroundColor = UIColor.task6Yellow;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
