//
//  InfoTableViewCell.h
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 7/1/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell
-(void)setupCellFromAsset: (PHAsset *)asset withSize: (CGSize) size;
@end

NS_ASSUME_NONNULL_END
