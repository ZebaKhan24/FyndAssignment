//
//  ServiceWrapper.h
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceWrapper : NSObject

@property (retain,nonatomic) NSMutableArray<DataObject*> *categoryDataObj;


-(void) getData:(NSString *) urlString OnSuccess:(void(^)(id data))onSuccess
      onFailure:(void(^)(NSError *error))onFailure;


@end

NS_ASSUME_NONNULL_END
