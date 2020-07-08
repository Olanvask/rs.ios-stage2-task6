//
//  MediaAggregator.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/24/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "MediaAggregator.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"

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
- (void)checkAuthorization {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
            [self fetchMedia];
        }
    }];
}
-(void)fetchMedia{
    
// [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
  //   if (status == PHAuthorizationStatusAuthorized) {
  //       [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
         PHFetchOptions *options = [[PHFetchOptions alloc] init];
         options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
         self.collectionAssetResult = [PHAsset fetchAssetsWithOptions:options];
 //    }
// }];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHFetchResultChangeDetails *changeDetails = [changeInstance changeDetailsForFetchResult:self.collectionAssetResult];
    
    [self.delegate galleryDidChage:changeDetails];
}
- (void)dealloc{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}
- (void)getVideoForExport:(PHAsset*)asset resultHandler:(void (^)(NSURL *__nullable fileURL))resultHandler {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHVideoRequestOptionsVersionOriginal;
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:
     ^(AVAsset * _Nullable avasset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        AVURLAsset *avurlasset = (AVURLAsset*) avasset;
        NSString *tmpDirectory = NSTemporaryDirectory();
        NSString *tmpFile = [tmpDirectory stringByAppendingPathComponent:[avurlasset.URL lastPathComponent]];
        NSURL *fileURL = [NSURL fileURLWithPath:tmpFile];
        if([[NSFileManager defaultManager] copyItemAtURL:avurlasset.URL toURL:fileURL error:nil]) {
             resultHandler(fileURL);
        }
     }];
}


@end
