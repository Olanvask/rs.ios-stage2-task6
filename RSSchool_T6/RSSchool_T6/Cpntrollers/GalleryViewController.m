//
//  GalleryViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/24/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
#import "UIColor+task6.h"
#import "GalleryViewController.h"
#import "MediaAggregator.h"
#import "GalleryCollectionViewCell.h"
#import "ModalPreviewViewController.h"
#import "HeaderLabelForCollectionViewController.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"
const int INSET_FOR_COLLECTION_VIEW = 5;
const int GALLERY_VC_HEADER_HEIGHT = 80;

@interface GalleryViewController() <UICollectionViewDelegate, UICollectionViewDataSource, MediaAggregatorDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) HeaderLabelForCollectionViewController *headerLabel;
@property (nonatomic,strong) MediaAggregator *mediaAggregator;
@property (nonatomic, strong) PHImageManager *imageManager;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, assign) int numberOfColumns;
@end

@implementation GalleryViewController
//-------------------------------------------------------------------------------------------------
-(BOOL)prefersStatusBarHidden{
    return YES;
}
//-------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.view.backgroundColor = [UIColor task6White];
    
    [self createViews];
    
    self.mediaAggregator = [[MediaAggregator alloc] init];
    self.mediaAggregator.delegate = self;
}
#pragma mark - Setup views
//-------------------------------------------------------------------------------------------------
-(void)createViews{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setSectionInset:UIEdgeInsetsMake(INSET_FOR_COLLECTION_VIEW , INSET_FOR_COLLECTION_VIEW, INSET_FOR_COLLECTION_VIEW, INSET_FOR_COLLECTION_VIEW)];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = INSET_FOR_COLLECTION_VIEW;
    
    if (self.view.frame.size.width > self.view.frame.size.height) {
        self.numberOfColumns = 5.0;
    }else{
        self.numberOfColumns = 3.0;
    }
    
    self.cellWidth = (self.view.frame.size.width - (self.numberOfColumns-1)*INSET_FOR_COLLECTION_VIEW - INSET_FOR_COLLECTION_VIEW * 2) / self.numberOfColumns;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.collectionView.backgroundColor = UIColor.task6White;
    
    [self.collectionView registerClass:GalleryCollectionViewCell.class forCellWithReuseIdentifier:@"collectionViewCellID"];
    
    [self.view addSubview:self.collectionView];
    
    self.headerLabel = [HeaderLabelForCollectionViewController new];
    [self.view addSubview:self.headerLabel];
    
    [self makeConstraints];
}
//-------------------------------------------------------------------------------------------------
-(void)makeConstraints{
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.headerLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.headerLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [self.headerLabel.heightAnchor constraintGreaterThanOrEqualToConstant:GALLERY_VC_HEADER_HEIGHT],            [self.headerLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.headerLabel.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
           
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant: 0],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant: 0],
            [self.collectionView.topAnchor constraintEqualToAnchor:self.headerLabel.bottomAnchor constant: 0],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [self.headerLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.headerLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.headerLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [self.headerLabel.heightAnchor constraintGreaterThanOrEqualToConstant:GALLERY_VC_HEADER_HEIGHT],
           
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant: 0],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: 0],
            [self.collectionView.topAnchor constraintEqualToAnchor:self.headerLabel.bottomAnchor constant: 0],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
}
//-------------------------------------------------------------------------------------------------
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        self.numberOfColumns = 5.0;
    }
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)){
        self.numberOfColumns = 3.0;
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}
#pragma mark - UICollectionView dataSource
//-------------------------------------------------------------------------------------------------
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section;{
    
    return UIEdgeInsetsMake(INSET_FOR_COLLECTION_VIEW, INSET_FOR_COLLECTION_VIEW, INSET_FOR_COLLECTION_VIEW, INSET_FOR_COLLECTION_VIEW);
}
//-------------------------------------------------------------------------------------------------
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;{
    return 5.0;
}
//-------------------------------------------------------------------------------------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cellWidth = (self.collectionView.bounds.size.width - (self.numberOfColumns-1)*INSET_FOR_COLLECTION_VIEW - INSET_FOR_COLLECTION_VIEW * 2) / self.numberOfColumns;
    
    return CGSizeMake(self.cellWidth, self.cellWidth);
}
//-------------------------------------------------------------------------------------------------
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return INSET_FOR_COLLECTION_VIEW;
}
//-------------------------------------------------------------------------------------------------
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCellID" forIndexPath:indexPath];
   
    self.imageManager = [PHImageManager new];
    
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.synchronous = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    PHAsset *asset = [self.mediaAggregator.collectionAssetResult objectAtIndex:indexPath.item];
    switch (asset.mediaType) {
        case PHAssetMediaTypeAudio:
            [cell setDefaultImage:[UIImage imageNamed:@"audio"]];
            break;
        case PHAssetMediaTypeUnknown:
            [cell setDefaultImage:[UIImage imageNamed:@"other"]];
            break;
        default:
            [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(self.cellWidth, self.cellWidth) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    [cell setImage:result];
                }
            }];
            break;
    }
    return cell;
}
//-------------------------------------------------------------------------------------------------
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.mediaAggregator.collectionAssetResult.count;
}
#pragma mark - UICollectionView delegate
//-------------------------------------------------------------------------------------------------
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ModalPreviewViewController *modalViewController = [ModalPreviewViewController new];
    
    self.imageManager = [PHImageManager new];
    
    PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
    requestOptions.synchronous = YES;
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    requestOptions.networkAccessAllowed = YES;
    
    UIImageView *transferImageView = [UIImageView new];
    PHAsset *asset = [self.mediaAggregator.collectionAssetResult objectAtIndex:indexPath.item];
    
    if (asset.mediaType == PHAssetMediaTypeImage) {
        
        [self.imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                [transferImageView setImage:result];
            }
        }];
        
        [modalViewController setModalImage:transferImageView.image];
        modalViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        modalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:modalViewController animated:YES completion:nil];
        
    }else if (asset.mediaType == PHAssetMediaTypeVideo){
        
        PHVideoRequestOptions *requestOptions = [PHVideoRequestOptions new];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOptions.networkAccessAllowed = YES;
        
        [self.imageManager requestPlayerItemForVideo:asset options:requestOptions resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
            
            AVPlayer *avPlayer = [[AVPlayer alloc]initWithPlayerItem:playerItem];
            AVPlayerViewController *avPlayerViewController = [AVPlayerViewController new];
            avPlayerViewController.player = avPlayer;
            [self presentViewController:avPlayerViewController animated:YES completion:^{
                [avPlayerViewController.player play];
            }];
        }];
    }else if (asset.mediaType == PHAssetMediaTypeAudio){
        
        PHVideoRequestOptions *videoOptions = [PHVideoRequestOptions new];
        [self.imageManager requestPlayerItemForVideo:asset options:videoOptions resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
            AVPlayer *avPlayer = [[AVPlayer alloc]initWithPlayerItem:playerItem];
            AVPlayerViewController *avPlayerViewController = [AVPlayerViewController new];
            avPlayerViewController.player = avPlayer;
            [self presentViewController:avPlayerViewController animated:YES completion:^{
                [avPlayerViewController.player play];
            }];
        }];
    }else if (asset.mediaType == PHAssetMediaTypeUnknown){
        
        [transferImageView setImage:[UIImage imageNamed:@"other"]];
        
        [modalViewController setModalImage:transferImageView.image];
        modalViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        modalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:modalViewController animated:YES completion:nil];
    }
}
#pragma mark - Media aggregator delegate
//-------------------------------------------------------------------------------------------------
- (void)galleryDidChage:(PHFetchResultChangeDetails *)ditails {
    [self.mediaAggregator fetchMedia];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
@end
