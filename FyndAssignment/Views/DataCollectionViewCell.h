//
//  DataCollectionViewCell.h
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detail;

- (void)pushGenerateImage;

@end

NS_ASSUME_NONNULL_END
