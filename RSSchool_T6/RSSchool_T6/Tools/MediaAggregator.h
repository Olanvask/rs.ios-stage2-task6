//
//  MediaAggregator.h
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/24/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
@protocol MediaAggregatorDelegate <NSObject>
-(void)galleryDidChage:(PHFetchResultChangeDetails *)details;
@end
@interface MediaAggregator : NSObject

@property (nonatomic, strong) PHFetchResult<PHAsset*> *collectionAssetResult;
@property (nonatomic, weak, nullable) id <MediaAggregatorDelegate> delegate;
-(void)fetchMedia;
@end

NS_ASSUME_NONNULL_END
