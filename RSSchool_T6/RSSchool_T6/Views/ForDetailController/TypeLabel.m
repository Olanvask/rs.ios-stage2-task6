//
//  TypeLabel.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/3/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "TypeLabel.h"
#import "UIColor+task6.h"

@implementation TypeLabel
-(instancetype)initWithType:(int)assetType{
    self = [super init];
    if (self){
        self.font = [UIFont systemFontOfSize:17 weight: UIFontWeightRegular];
        self.textColor = UIColor.task6Black;
        NSAttributedString *stringOfType;
        switch (assetType) {
            case 0:
                stringOfType = [[NSAttributedString alloc] initWithString: @"Type: Other"];
                break;
            case 1:
                stringOfType = [[NSAttributedString alloc] initWithString: @"Type: Image"];
                break;
            case 2:
                stringOfType = [[NSAttributedString alloc] initWithString: @"Type: Video"];
                break;
            case 3:
                stringOfType = [[NSAttributedString alloc] initWithString: @"Type: Audio"];
                break;
                
                
            default:
                break;
        }
        NSMutableAttributedString *typeFromString = [[NSMutableAttributedString alloc] initWithAttributedString: stringOfType];
        [typeFromString addAttribute:NSForegroundColorAttributeName
                              value:UIColor.task6Black
                     range:NSMakeRange(0, 4)];
        [self setAttributedText:typeFromString];
        self.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

@end
