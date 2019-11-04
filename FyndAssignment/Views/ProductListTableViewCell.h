//
//  ProductListTableViewCell.h
//  FyndAssignment
//
//  Created by Danish Ansari on 01/11/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryItem;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (weak, nonatomic) IBOutlet UIControl *expandableView;

@property (retain) NSMutableArray<ProductDetailObject *>* data;
@property (retain) UIViewController *viewcontroller;



@end

NS_ASSUME_NONNULL_END
