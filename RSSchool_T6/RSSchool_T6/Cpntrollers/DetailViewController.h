//
//  DetailControllerViewController.h
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/2/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic,strong) PHAsset *asset;
@end

NS_ASSUME_NONNULL_END
