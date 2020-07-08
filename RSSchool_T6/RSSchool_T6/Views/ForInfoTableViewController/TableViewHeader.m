//
//  TableViewHeader.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/2/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "TableViewHeader.h"
#import "UIColor+task6.h"
@interface TableViewHeader()
@property (nonatomic,strong) UILabel *label;
@end
@implementation TableViewHeader


-(instancetype)init{
    self = [super init];
    if (self) {
        [self setView];
    }
    return self;
}
-(void)setView{
    
    self.label = [UILabel new];
    self.label.font = [UIFont systemFontOfSize:24 weight: UIFontWeightMedium];
    self.label.textColor = UIColor.task6Black;
    self.label.text = @"Info";
    self.label.backgroundColor = UIColor.task6Yellow;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    self.label.translatesAutoresizingMaskIntoConstraints= NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.label.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        
    ]];
}

@end
