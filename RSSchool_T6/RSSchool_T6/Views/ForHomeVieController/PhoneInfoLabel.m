//
//  PhoneInfoLabel.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/4/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "PhoneInfoLabel.h"
#import "UIColor+task6.h"
@implementation PhoneInfoLabel
-(instancetype)init:(NSDate *) date{
    self = [super init];
    
        self.font = [UIFont systemFontOfSize:17 weight: UIFontWeightRegular];
        self.textColor = UIColor.task6Black;
       
        self.textAlignment = NSTextAlignmentLeft;
    
    return self;
}

@end
