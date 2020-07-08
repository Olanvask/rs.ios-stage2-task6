//
//  ModalPreviewViewController.h
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModalPreviewViewController : UIViewController
@property (nonatomic,copy) UIImage *modalImage;
@property (nonatomic,strong) PHAsset *phAsset;
@end

NS_ASSUME_NONNULL_END
