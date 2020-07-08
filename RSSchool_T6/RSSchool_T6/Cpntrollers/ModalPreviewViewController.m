//
//  ModalPreviewViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "ModalPreviewViewController.h"
#import "UIColor+task6.h"
#import "CloseButton.h"

int const CLOSE_BUTTON_SIZE = 40;
int const MODAL_VC_OFFSET = 5;

@interface ModalPreviewViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGSize willViewSize;
@end

@implementation ModalPreviewViewController
//-------------------------------------------------------------------------------------------------
-(BOOL)prefersStatusBarHidden{
    return YES;
}

//-------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.task6White;
    
    [self createViews];
    
    [self layoutImage];
    
    self.willViewSize = self.view.frame.size;
}
#pragma mark - Setup layout
//-------------------------------------------------------------------------------------------------
-(void)createViews{
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    
    self.closeButton = [[CloseButton alloc] init];
    [self.closeButton addTarget:self action:@selector(closeButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
}
//-------------------------------------------------------------------------------------------------
-(void) viewWillLayoutSubviews{
    
    [self layoutImage];
    [self makeConstraints];
    
}

//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        
        [self.closeButton.topAnchor constraintEqualToAnchor:self.imageView.topAnchor constant: MODAL_VC_OFFSET],
        [self.closeButton.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:-MODAL_VC_OFFSET],
        [self.closeButton.widthAnchor constraintGreaterThanOrEqualToConstant:CLOSE_BUTTON_SIZE],
        [self.closeButton.heightAnchor constraintGreaterThanOrEqualToConstant:CLOSE_BUTTON_SIZE],
    ]];
}

//-------------------------------------------------------------------------------------------------
-(void) layoutImage{
    
    UIImage *tempImage = [UIImage new];
    
    if (self.modalImage.size.width > self.willViewSize.width) {
        
        tempImage =  [self resizeImage:self.modalImage newWidth:self.willViewSize.width];
        
        if (tempImage.size.height > self.willViewSize.height) {
            tempImage =  [self resizeImage:tempImage newHeight:self.willViewSize.height];
        }
        
    }else if (self.modalImage.size.height > (self.willViewSize.width))  {
        
        tempImage =  [self resizeImage:self.modalImage newHeight:self.willViewSize.height];
        
        if (tempImage.size.width > self.willViewSize.width) {
            tempImage =  [self resizeImage:tempImage newWidth:self.willViewSize.width];
        }
        
    }else{
        self.imageSize = self.modalImage.size;
    }
    
    self.imageView.frame = CGRectMake(self.willViewSize.width/2 - self.imageSize.width/2, self.willViewSize.height/2 - self.imageSize.height/2, self.imageSize.width, self.imageSize.height);

    [self.imageView setImage:tempImage];
}

//-------------------------------------------------------------------------------------------------
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    self.willViewSize = size;
}
#pragma mark - Resize image
//-------------------------------------------------------------------------------------------------
- (UIImage *)resizeImage:(UIImage *)image newWidth:(CGFloat)newWidth {
    
    CGFloat scale = newWidth / image.size.width;
    CGFloat newHeight = image.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageSize = CGSizeMake(newWidth, newHeight);
    return newImage;
}

//-------------------------------------------------------------------------------------------------
- (UIImage *)resizeImage:(UIImage *)image newHeight:(CGFloat)newHeight {
    
    CGFloat scale = newHeight / image.size.height;
    CGFloat newWidth = image.size.width * scale;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageSize = CGSizeMake(newWidth, newHeight);
    return newImage;
}

//-------------------------------------------------------------------------------------------------
#pragma mark - Button action
-(void)closeButtonTaped{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
