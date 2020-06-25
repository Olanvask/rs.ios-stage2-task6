//
//  GalleryCollectionViewCell.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

@implementation GalleryCollectionViewCell

 
-(void)setImage:(UIImage *)image{
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self addSubview:self.imageView];
  
    [self.imageView setImage:image];
}
@end
