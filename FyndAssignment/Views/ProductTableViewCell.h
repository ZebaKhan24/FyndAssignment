//
//  ProductTableViewCell.h
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UICollectionView *productDetailCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (retain) NSMutableArray<ProductDetailObject *>* data;
@property (retain) UIViewController *viewController;

-(void) setCollectionHeight;

@end

NS_ASSUME_NONNULL_END
