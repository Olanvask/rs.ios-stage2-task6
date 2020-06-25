//
//  HeaderLabelForCollectionViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "HeaderLabelForCollectionViewController.h"
#import "UIColor+task6.h"
@implementation HeaderLabelForCollectionViewController

-(instancetype)init{
    self = [super init];
    if (self){
        self.font = [UIFont systemFontOfSize:24 weight: UIFontWeightMedium];
        self.textColor = UIColor.task6Black;
        self.text = @"Gallery";
        self.backgroundColor = UIColor.task6Yellow;
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
@end
