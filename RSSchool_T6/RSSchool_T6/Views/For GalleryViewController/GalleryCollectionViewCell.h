//
//  GalleryCollectionViewCell.h
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryCollectionViewCell : UICollectionViewCell
-(void)setImage:(UIImage *)image;
@property (nonatomic,strong) UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
