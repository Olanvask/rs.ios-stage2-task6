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

@interface GalleryViewController() <UICollectionViewDelegate, UICollectionViewDataSource, MediaAggregatorDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) HeaderLabelForCollectionViewController *headerLabel;
@property (nonatomic,strong) MediaAggregator *mediaAggregator;
@property (nonatomic, strong) PHImageManager *imageManager;
@property (nonatomic) CGFloat cellSize;
@end
//TODO Настроить лэйаут коллекции в зависимости от ориентации
//Добавить возможность сохранять ссылку на видео в ячейках
//Организовать таббар контроллер и закастомить бары
@implementation GalleryViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = UIColor.task6White;
    
    self.headerLabel = [[HeaderLabelForCollectionViewController alloc] init];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    self.cellSize = (UIScreen.mainScreen.bounds.size.width / 3 ) - 10;
    layout.itemSize = CGSizeMake(self.cellSize, self.cellSize);
    layout.sectionInset = UIEdgeInsetsZero;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:GalleryCollectionViewCell.class forCellWithReuseIdentifier:@"collectionViewCellID"];

    self.collectionView.backgroundColor = UIColor.task6White;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    [self.view addSubview:self.headerLabel];
    [self.view addSubview:self.collectionView];
    
    self.mediaAggregator = [[MediaAggregator alloc] init];
    self.mediaAggregator.delegate = self;
    
    
  
    [self makeConstraints];
}


-(void)makeConstraints{
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5],
        [self.collectionView.topAnchor constraintEqualToAnchor:self.headerLabel.bottomAnchor constant:20],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: -20],
        [self.headerLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.headerLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.headerLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20],
        [self.headerLabel.heightAnchor constraintGreaterThanOrEqualToConstant:100],
        
    ]];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCellID" forIndexPath:indexPath];
    self.imageManager = [PHImageManager new];
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.synchronous = YES;
    option.resizeMode = 2;
 
    [self.imageManager requestImageForAsset:[self.mediaAggregator.collectionAssetResult objectAtIndex:indexPath.item] targetSize:CGSizeMake(self.cellSize,self.cellSize) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            [cell setImage:result];
        }
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mediaAggregator.collectionAssetResult.count;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ModalPreviewViewController *modalViewController = [ModalPreviewViewController new];
    self.imageManager = [PHImageManager new];
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.synchronous = YES;
    option.resizeMode = 2;
    UIImageView *transferImageView = [UIImageView new];
    
    [self.imageManager requestImageForAsset:[self.mediaAggregator.collectionAssetResult objectAtIndex:indexPath.item] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            [transferImageView setImage:result];
            
        }
    }];
    
    [modalViewController setModalImage:transferImageView.image];
    [self presentViewController:modalViewController animated:YES completion:nil];
    
}

- (void)galleryDidChage:(PHFetchResultChangeDetails *)ditails {
    [self.mediaAggregator fetchMedia];
    [self.collectionView reloadData];
}
@end
