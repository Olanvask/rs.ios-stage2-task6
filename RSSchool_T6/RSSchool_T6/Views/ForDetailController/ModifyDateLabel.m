//
//  ModifyDateLabel.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/3/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "ModifyDateLabel.h"
#import "UIColor+task6.h"

@implementation ModifyDateLabel


-(instancetype)initWithDate:(NSDate *) date{
    self = [super init];
    if (self){
        self.font = [UIFont systemFontOfSize:17 weight: UIFontWeightRegular];
        self.textColor = UIColor.task6Black;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
          [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
        
        self.text = [NSString stringWithFormat:@"%@ %@", @"Modification date: ",[formatter stringFromDate:date]];
       
        NSMutableAttributedString *dateFromString = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
        [dateFromString addAttribute:NSForegroundColorAttributeName
                              value:UIColor.task6Gray
                     range:NSMakeRange(0, 13)];
        [self setAttributedText:dateFromString];
        self.textAlignment = NSTextAlignmentLeft;
        self.lineBreakMode = NSLineBreakByClipping;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
