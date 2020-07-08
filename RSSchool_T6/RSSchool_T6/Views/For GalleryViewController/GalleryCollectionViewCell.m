//
//  GalleryCollectionViewCell.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "GalleryCollectionViewCell.h"
#import "UIColor+task6.h"

@implementation GalleryCollectionViewCell

-(void)setDefaultImage: (UIImage *)defaultImage{
    self.backgroundColor = UIColor.task6White;
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    [self addSubview:self.imageView];
    [self.imageView setImage:defaultImage];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    ]];
}
//-------------------------------------------------------------------------------------------------
-(void)setImage:(UIImage *)image{
    self.backgroundColor = UIColor.task6White;
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
    [self.imageView setImage:[self squareImageWithImage:image scaledToSize:self.bounds.size]];
    [self.imageView clipsToBounds];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    ]];
}
//-------------------------------------------------------------------------------------------------
- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//-------------------------------------------------------------------------------------------------
-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
@end
