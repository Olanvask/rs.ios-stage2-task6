//
//  MediaAggregator.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/24/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "MediaAggregator.h"
@interface MediaAggregator()<PHPhotoLibraryChangeObserver>
@property (nonatomic, strong) NSMutableArray *collectionResult;

@end
@implementation MediaAggregator
-(instancetype)init{
    self = [super init];
    if (self) {
        [self fetchMedia];
        [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];

    }
    return self;
}
-(void)fetchMedia{
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.collectionAssetResult = [PHAsset fetchAssetsWithOptions:options];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHFetchResultChangeDetails *changeDetails = [changeInstance changeDetailsForFetchResult:self.collectionAssetResult];
    
    [self.delegate galleryDidChage:changeDetails];
}
- (void)dealloc
{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

@end
