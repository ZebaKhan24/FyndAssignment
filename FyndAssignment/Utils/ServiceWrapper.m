//
//  ServiceWrapper.m
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import "ServiceWrapper.h"

@implementation ServiceWrapper


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.categoryDataObj = [[NSMutableArray alloc]init];
//        self.jackets = [[NSMutableArray alloc]init];
//        self.shirts = [[NSMutableArray alloc]init];
//        self.polos = [[NSMutableArray alloc]init];
//        self.sweatshirt = [[NSMutableArray alloc]init];
//
//        DataObject *data = [[DataObject alloc]init];
//        data.name = @"Jackets";
//        for (int i=0; i<4; i++) {
//            [self.categoryDataObj addObject: data];
//        }
//        DataObject *datajacket = [[DataObject alloc]init];
//        datajacket.name = @"jacket1";
//        for (int i=0; i<8; i++) {
//            [self.jackets addObject:datajacket];
//        }
    }
    return self;
}


-(void) getData:(NSString *) urlString OnSuccess:(void(^)(id data))onSuccess
      onFailure:(void(^)(NSError *error))onFailure{
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          if(httpResponse.statusCode == 200)
                                          {
                                              NSError *parseError = nil;
                                              NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                                              NSLog(@"The response is - %@",responseArray);
                                             // NSArray * arr = [responseArray valueForKey:@"products"];//products
                                              [self mapCategoryData:responseArray];
                                              onSuccess(responseArray);
                                          }
                                          else
                                          {
                                              NSLog(@"Error");
                                              onFailure(error);
                                          }
                                      }];
    [dataTask resume];
}


-(void) mapCategoryData:(NSArray*)data{
    for (int category=0; category < data.count; category++) {
        DataObject *obj = [[DataObject alloc]init];
        obj.name = [data[category] valueForKey:@"name"];
        NSMutableArray<ProductDetailObject *> *productList = [[NSMutableArray<ProductDetailObject*> alloc]init];
        NSArray * arr =[data[category] valueForKey: @"products"];
        for (int detail=0; detail < arr.count; detail++){
            ProductDetailObject *detailObj = [[ProductDetailObject alloc]init];
            detailObj.name = [arr[detail] valueForKey:@"name"];
            detailObj.cost = [[arr[detail] valueForKey:@"cost"] integerValue];
            detailObj.sku = [[arr[detail] valueForKey:@"sku"] integerValue];
            [productList addObject:detailObj];
        }
        obj.isExpanded = NO;
        obj.productDetail = [productList mutableCopy];
        [self.categoryDataObj addObject:obj];
    }
}


@end
