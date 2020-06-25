//
//  ModalPreviewViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/25/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "ModalPreviewViewController.h"

@interface ModalPreviewViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@property CGFloat scalingIndex;
@end
//TODO добавить кнопку возврата на предыдущий контроллер
//добавить обработку ориентации и переделать масштабирование
@implementation ModalPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithImage:self.modalImage];
    [self.view addSubview:self.imageView];
    
   
}
-(void)viewWillAppear:(BOOL)animated{
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        
    ]];
    
    if (self.modalImage.size.width > (self.view.frame.size.width)) {
        
        self.modalImage =  [self resizeImage:self.modalImage newWidth:self.view.frame.size.width];
    }
    if (self.modalImage.size.height > (self.view.window.screen.bounds.size.height)) {
        self.modalImage =  [self resizeImage:self.modalImage newHeight:self.view.frame.size.height];
    }
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:self.modalImage.size.width],
        [self.imageView.heightAnchor constraintEqualToConstant:self.modalImage.size.height],
        
            ]];}
- (UIImage *)resizeImage:(UIImage *)image newWidth:(CGFloat)newWidth {

    double scale = newWidth / image.size.width;
    double newHeight = image.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}
- (UIImage *)resizeImage:(UIImage *)image newHeight:(CGFloat)newHeight {

    double scale = newHeight / image.size.width;
    double newWidth = image.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
  //  self resizeImage:self.modalImage newWidth:<#(CGFloat)#>
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
