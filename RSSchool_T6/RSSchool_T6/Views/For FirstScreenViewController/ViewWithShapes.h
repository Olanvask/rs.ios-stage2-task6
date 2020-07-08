//
//  ViewWithShapes.h
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"
#import "CircleView.h"
#import "ViewWithShapes.h"
#import "RectangleView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewWithShapes : UIStackView
@property (nonatomic,strong) CircleView *circleView;
@property (nonatomic,strong) TriangleView *triangleView;
@property (nonatomic,strong) RectangleView *rectangleView;
-(void)animate;
@end

NS_ASSUME_NONNULL_END
