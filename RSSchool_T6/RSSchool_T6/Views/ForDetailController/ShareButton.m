//
//  ShareButton.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/4/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "ShareButton.h"
#import "UIColor+task6.h"
@implementation ShareButton

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = UIColor.task6Yellow;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont systemFontOfSize:18 weight: UIFontWeightSemibold];
        
        [self setTitle:@"Share" forState:UIControlStateNormal];
        [self setTitleColor:UIColor.task6Black forState:UIControlStateNormal];
        self.clipsToBounds = YES;
    }
    return self;

}
@end
