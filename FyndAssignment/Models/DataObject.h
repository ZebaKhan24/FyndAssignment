//
//  DataObject.h
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataObject : NSObject

@property (retain,nonatomic) NSString *name;

@property (retain,nonatomic) NSMutableArray<ProductDetailObject*> *productDetail;

@property BOOL isExpanded;

@end

NS_ASSUME_NONNULL_END
