//
//  InfoTableViewCell.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/1/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
#import <Photos/Photos.h>
#import "InfoTableViewCell.h"
#import "UIColor+task6.h"

@interface InfoTableViewCell()
@property (nonatomic, strong) UIImageView *filePreviewImageView;
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *fileNameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) PHAsset *asset;
@property(nonatomic, strong) PHImageManager *imageManager;

@end
@implementation InfoTableViewCell


-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
//-------------------------------------------------------------------------------------------------
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

//-------------------------------------------------------------------------------------------------
-(void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    // self.backgroundColor = UIColor.task6HighlightedYellow;
}
#pragma mark - Setup cell
//-------------------------------------------------------------------------------------------------
-(void)setupCellFromAsset:(PHAsset *)asset withSize:(CGSize)size{
    
    self.backgroundColor = UIColor.task6White;
    
    self.asset = asset;
    
    self.filePreviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, size.width, size.height)];
    [self.filePreviewImageView setImage:[UIImage imageNamed:@"other"]];
    
    [self addSubview:self.filePreviewImageView];
    
    self.fileNameLabel = [UILabel new];
    self.fileNameLabel.font = [UIFont systemFontOfSize:17 weight: UIFontWeightSemibold];
    self.fileNameLabel.textColor = UIColor.task6Black;
    
    [self addSubview:self.fileNameLabel];
    
    self.typeImageView = [UIImageView new];
    [self.typeImageView setImage:[UIImage imageNamed:@"audio"]];
    self.typeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.infoLabel = [UILabel new];
    self.infoLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.infoLabel.textColor = UIColor.task6Black;

    [self addSubview:self.infoLabel];
    
    [self addSubview:self.typeImageView];

    if (self.asset.mediaType == PHAssetMediaTypeImage) {
        UIImage *tempImage;
        self.imageManager = [PHImageManager new];
        PHImageRequestOptions *option = [PHImageRequestOptions new];
        option.synchronous = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeExact;
        [self.imageManager requestImageForAsset:self.asset targetSize:CGSizeMake(size.width, size.height) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                [self.filePreviewImageView setImage:result];
                self.infoLabel.text = @"picture";
                
            }
        }];
        self.fileNameLabel.text = [asset valueForKey:@"filename"];
        [self.typeImageView setImage:[UIImage imageNamed:@"image"]];
        self.infoLabel.text = [NSString stringWithFormat:@"%lux%lu",(unsigned long)self.asset.pixelWidth, (unsigned long)self.asset.pixelHeight];
        [ self.filePreviewImageView setImage:[self squareImageWithImage:self.filePreviewImageView.image scaledToSize:CGSizeMake(80, 80)]];
    }else if (self.asset.mediaType == PHAssetMediaTypeVideo){
        UIImage *tempImage;
        self.imageManager = [PHImageManager new];
        PHImageRequestOptions *option = [PHImageRequestOptions new];
        option.synchronous = YES;
        
        option.resizeMode = PHImageRequestOptionsResizeModeExact;
        [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(size.width, size.height) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                [self.filePreviewImageView setImage:result];
            }
        }];
        self.fileNameLabel.text = [self.asset valueForKey:@"filename"];
        [self.typeImageView setImage:[UIImage imageNamed:@"video"]];
        NSString *resolutionString = [NSString stringWithFormat:@"%lux%lu",(unsigned long)self.asset.pixelWidth, (unsigned long)asset.pixelHeight];
        self.infoLabel.text = [NSString stringWithFormat:@"%@ %@",resolutionString, [self durationString:self.asset.duration]];
        [ self.filePreviewImageView setImage:[self squareImageWithImage:self.filePreviewImageView.image scaledToSize:CGSizeMake(80, 80)]];
        
    }else if (self.asset.mediaType == PHAssetMediaTypeAudio){
        [self.filePreviewImageView setImage: [UIImage imageNamed:@"audio"]];
        [self.typeImageView setImage:[UIImage imageNamed:@"audio"]];
        
    }else{
        [self.filePreviewImageView setImage: [UIImage imageNamed:@"other"]];
        [self.typeImageView setImage:[UIImage imageNamed:@"other"]];
        
    }
    
    [self makeConstraints];
}
#pragma mark - Make constraints
//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.fileNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.fileNameLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
        [self.fileNameLabel.leadingAnchor constraintEqualToAnchor:self.filePreviewImageView.trailingAnchor constant:10],
        [self.fileNameLabel.topAnchor constraintEqualToAnchor:self.filePreviewImageView.topAnchor constant:10],
    ]];
    
    self.typeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.typeImageView.widthAnchor constraintEqualToConstant:30],
        [self.typeImageView.leadingAnchor constraintEqualToAnchor:self.filePreviewImageView.trailingAnchor constant:10],
        [self.typeImageView.heightAnchor constraintEqualToConstant:30],
        [self.typeImageView.bottomAnchor constraintEqualToAnchor:self.filePreviewImageView.bottomAnchor constant:-10],
    ]];
    
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.infoLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
        [self.infoLabel.leadingAnchor constraintEqualToAnchor:self.typeImageView.trailingAnchor constant:10],
        [self.infoLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor constant:-5],
        [self.infoLabel.centerYAnchor constraintEqualToAnchor:self.typeImageView.centerYAnchor],
    ]];
    
}

//-------------------------------------------------------------------------------------------------
- (NSString *)durationString:(NSInteger)numberOfSeconds {
    
    NSInteger seconds = numberOfSeconds % 60;
    NSInteger minutes = (numberOfSeconds / 60) % 60;
    NSInteger hours = numberOfSeconds / 3600;
    
    if (hours) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, seconds];
    }
    if (minutes) {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    }
    return [NSString stringWithFormat:@"00:%02ld", (long)seconds];
}
#pragma mark Resize image
//-------------------------------------------------------------------------------------------------
- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
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
@end
