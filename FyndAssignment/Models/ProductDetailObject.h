//
//  ProductDetailObject.h
//  FyndAssignment
//
//  Created by Danish Ansari on 30/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailObject : NSObject

@property (retain,nonatomic) NSString *name;

@property (nonatomic) NSInteger cost;

@property (nonatomic) NSInteger sku;

@end

NS_ASSUME_NONNULL_END
