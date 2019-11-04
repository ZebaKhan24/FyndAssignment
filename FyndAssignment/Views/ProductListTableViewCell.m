//
//  ProductListTableViewCell.m
//  FyndAssignment
//
//  Created by Danish Ansari on 01/11/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import "ProductListTableViewCell.h"
#import "ProductDetailTableViewCell.h"
#import "PECropViewController.h"

@interface ProductListTableViewCell () <UITableViewDelegate,UITableViewDataSource, PECropViewControllerDelegate>

@end


@implementation ProductListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productDetailList" forIndexPath:indexPath];
    cell.productDetail.text = self.data[indexPath.row].name;
    cell.tag = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PECropViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"cropVC"];
    
    NSArray *myImageNames = [NSArray arrayWithObjects:@"water", @"stock", @"beautiful", nil];
     int index = arc4random() % ([myImageNames count] - 1);
    
    controller.image = [UIImage imageNamed:[myImageNames objectAtIndex:index]];
    controller.delegate = self;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.viewcontroller presentViewController:navigationController animated:YES completion:NULL];
}

-(void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    [controller dismissViewControllerAnimated:YES completion:NULL];
   // self.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"fynd"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    self.backgroundView = [[UIImageView alloc] initWithImage:[ croppedImage stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    [UIView transitionWithView:self.backgroundView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
   //  [UIView transitionFromView:view1 toView:self.backgroundView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    
    
}

-(void)cropViewControllerDidCancel:(PECropViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}



@end
