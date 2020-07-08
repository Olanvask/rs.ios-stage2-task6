//
//  DetailControllerViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/2/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "DetailViewController.h"
#import "UIColor+task6.h"
#import "CreationDateLabel.h"
#import "ModifyDateLabel.h"
#import "TypeLabel.h"
#import "ShareButton.h"
#import "StartButton.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"
#import "MediaAggregator.h"



int const OFFSET = 20;
int const LABEL_HEIGHT = 30;
int const SHARE_BUTTON_MINIMUM_WIDTH = 200;
int const SHARE_BUTTON_MINIMUM_HEIGHT = 60;
int const OFFSET_FOR_SHARE_BUTTON = 20;


@interface DetailViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIStackView *stackView;
@property (nonatomic,strong) ShareButton *shareButton;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) CreationDateLabel *creationDateLabel;
@property (nonatomic,strong) ModifyDateLabel *modifyDateLabel;
@property (nonatomic,strong) TypeLabel *typeLabel;
@property (nonatomic,strong) PHImageManager *imageManager;
@property (nonatomic, strong) MediaAggregator *mediaAggregator;

@end

@implementation DetailViewController
//-------------------------------------------------------------------------------------------------
-(BOOL)prefersStatusBarHidden{
    return YES;
}

//-------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self configureNavigationBar];
    
}
#pragma mark - Setup layout
//-------------------------------------------------------------------------------------------------

-(void)configureNavigationBar {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (@available(iOS 13, *)) {
        self.navigationController.navigationBar.standardAppearance = [[UINavigationBarAppearance alloc] init];
        [self.navigationController.navigationBar.standardAppearance configureWithDefaultBackground];
        self.navigationController.navigationBar.standardAppearance.backgroundColor = [UIColor task6Yellow];
        self.navigationController.navigationBar.standardAppearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor task6Black], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor task6Yellow];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor task6Black], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self.navigationController
                                                                  action:@selector(popViewControllerAnimated:)];
    backButton.tintColor = [UIColor task6Black];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = [self.asset valueForKey:@"filename"];
}

//-------------------------------------------------------------------------------------------------
-(void)setupViews{
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    
    
    self.imageView = [UIImageView new];
    
    self.imageManager = [PHImageManager new];
    PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
    requestOptions.synchronous = YES;
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    requestOptions.networkAccessAllowed = YES;
    
    [self.imageManager requestImageForAsset:self.asset targetSize:CGSizeMake(self.asset.pixelWidth, self.asset.pixelHeight) contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            [self.imageView setImage:result];
        }
    }];
    
    [self.imageView setImage:[self resizeImage: self.imageView.image newWidth:self.view.frame.size.width-OFFSET*2]];
    [self.contentView addSubview:self.imageView];
   
    self.creationDateLabel = [[CreationDateLabel alloc] initWithDate:self.asset.creationDate];
    [self.contentView addSubview:self.creationDateLabel];
    
    self.modifyDateLabel = [[ModifyDateLabel alloc] initWithDate:self.asset.modificationDate];
    [self.contentView addSubview:self.modifyDateLabel];
    
    self.typeLabel = [[TypeLabel alloc] initWithType:self.asset.mediaType];
    [self.contentView addSubview:self.typeLabel];
    
    self.shareButton = [ShareButton new];
    [self.shareButton addTarget:self action:@selector(shareButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.shareButton];
    
    self.shareButton.layer.cornerRadius = SHARE_BUTTON_MINIMUM_HEIGHT / 2;
    
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    [self makeConstraints];
}

//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
    ]];
    
     self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
       [NSLayoutConstraint activateConstraints:@[
           [self.imageView.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant:OFFSET],
           [self.imageView.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:OFFSET],
           [self.imageView.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant:-OFFSET],
           [self.imageView.heightAnchor constraintEqualToConstant:self.imageView.image.size.height],
           
       ]];
    
    self.creationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.creationDateLabel.topAnchor constraintEqualToAnchor: self.imageView.bottomAnchor constant:OFFSET],
        [self.creationDateLabel.leadingAnchor constraintEqualToAnchor: self.scrollView.leadingAnchor constant:OFFSET],
        [self.creationDateLabel.trailingAnchor constraintEqualToAnchor: self.scrollView.trailingAnchor constant:-OFFSET],
        [self.creationDateLabel.heightAnchor constraintEqualToConstant:LABEL_HEIGHT],
    ]];
    
    self.modifyDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.modifyDateLabel.topAnchor constraintEqualToAnchor: self.creationDateLabel.bottomAnchor constant:OFFSET],
        [self.modifyDateLabel.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:OFFSET],
        [self.modifyDateLabel.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-OFFSET],
        [self.modifyDateLabel.heightAnchor constraintEqualToConstant:LABEL_HEIGHT],
    ]];
    
    self.typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.typeLabel.topAnchor constraintEqualToAnchor: self.modifyDateLabel.bottomAnchor constant:OFFSET],
        [self.typeLabel.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:OFFSET],
        [self.typeLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant:-OFFSET],
        [self.typeLabel.heightAnchor constraintEqualToConstant:LABEL_HEIGHT],
    ]];
    
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.shareButton.topAnchor constraintGreaterThanOrEqualToAnchor: self.typeLabel.bottomAnchor constant: OFFSET_FOR_SHARE_BUTTON],
        [self.shareButton.widthAnchor constraintEqualToConstant:SHARE_BUTTON_MINIMUM_WIDTH],
        [self.shareButton.heightAnchor constraintEqualToConstant:SHARE_BUTTON_MINIMUM_HEIGHT],
        [self.shareButton.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.shareButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: - OFFSET_FOR_SHARE_BUTTON],
    ]];
}

//-------------------------------------------------------------------------------------------------
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [NSLayoutConstraint deactivateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant:OFFSET],
        [self.imageView.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:OFFSET],
        [self.imageView.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant:-OFFSET],
        [self.imageView.heightAnchor constraintEqualToConstant:self.imageView.image.size.height],
    ]];
    
    [self.imageView setImage:[self resizeImage: self.imageView.image newWidth:size.width-OFFSET*2]];
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant:OFFSET],
        [self.imageView.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:OFFSET],
        [self.imageView.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant:-OFFSET],
        [self.imageView.heightAnchor constraintEqualToConstant:self.imageView.image.size.height],
        
    ]];
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
    
    return newImage;
}
#pragma mark - Button action
//-------------------------------------------------------------------------------------------------
-(void)shareButtonTaped{
    
    self.mediaAggregator = [MediaAggregator new];
    
    if(self.asset.mediaType == PHAssetMediaTypeVideo) {
        __weak typeof(self) weakSelf = self;
        [self.mediaAggregator getVideoForExport:self.asset resultHandler:^(NSURL * _Nullable fileURL) {
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
                    activityViewController.modalPresentationStyle = UIModalPresentationPopover;
                    activityViewController.popoverPresentationController.sourceView = self.shareButton;                    [weakSelf presentViewController:activityViewController animated:YES completion:nil];
                });
            }
        }];
    } else {
    
        PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        requestOptions.synchronous = YES;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOptions.networkAccessAllowed = YES;
        
        [self.imageManager requestImageForAsset:self.asset targetSize:CGSizeMake(self.asset.pixelWidth, self.asset.pixelHeight) contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[result] applicationActivities:nil];
                activityViewController.modalPresentationStyle = UIModalPresentationPopover;
                activityViewController.popoverPresentationController.sourceView = self.shareButton;
                [self presentViewController:activityViewController animated:YES completion:nil];
            }
        }];
    }
}

@end
