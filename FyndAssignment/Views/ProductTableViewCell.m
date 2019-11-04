//
//  ProductTableViewCell.m
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "DataCollectionViewCell.h"
#import "FlipAnimationViewController.h"

@interface ProductTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UICollectionViewDelegateFlowLayout>

@end


@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.productDetailCollectionView.delegate = self;
    self.productDetailCollectionView.dataSource = self;
    self.productDetailCollectionView.dragDelegate = self;
    self.productDetailCollectionView.dragDelegate = self;
    self.productDetailCollectionView.dropDelegate = self;
    self.productDetailCollectionView.dragInteractionEnabled = YES;
    //self.productDetailCollectionView.backgroundColor = UIColor.whiteColor;
    //[self.productDetailCollectionView setEditing:YES animated:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCollectionHeight{
    if(self.data.count > 0){
        self.collectionViewHeight.constant = 200;
    }else{
        self.collectionViewHeight.constant = 0;
    }
}

-(void)reorderItem:(id<UICollectionViewDropCoordinator>)cordinator destinationIndexPath:(NSIndexPath*)indexpath collectionView:(UICollectionView*)collectionView {
    id item = cordinator.items.firstObject;
    if (item && [item sourceIndexPath]) {
        [collectionView performBatchUpdates:^{
            NSMutableArray *arr = [self.data mutableCopy];
            [arr removeObjectAtIndex:[[item sourceIndexPath] item]];
            [arr insertObject:[item dragItem].localObject atIndex:indexpath.item];
            [collectionView deleteItemsAtIndexPaths:@[[item sourceIndexPath]]];
            [collectionView insertItemsAtIndexPaths:@[indexpath]];
            self.data = arr;
        } completion:nil];
    
        [cordinator dropItem:[item dragItem] toItemAtIndexPath:indexpath];
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    ProductDetailObject* entity = self.data[indexPath.row];
    NSItemProvider *provider = [[NSItemProvider alloc] initWithObject:self.data[indexPath.row].name];
    UIDragItem* item = [[UIDragItem alloc] initWithItemProvider:provider];
    item.localObject = entity;
    return @[item];
}

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator{
    
    NSIndexPath *indexpath  = [[NSIndexPath alloc]init];
    if (coordinator.destinationIndexPath){
        indexpath = coordinator.destinationIndexPath;
    }else {
        NSInteger row = [collectionView numberOfItemsInSection:0];
        indexpath = [NSIndexPath indexPathForRow:row - 1 inSection:0];
    }
    if (coordinator.proposal.operation == UIDropOperationMove){
        [self reorderItem:coordinator destinationIndexPath:indexpath collectionView:collectionView];
    }
}

- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath{
    
    if (collectionView.hasActiveDrag) {
        return [[UICollectionViewDropProposal alloc]initWithDropOperation:UIDropOperationMove intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
    }
    return [[UICollectionViewDropProposal alloc]initWithDropOperation:UIDropOperationForbidden];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.detail.text = self.data[indexPath.row].name;
    [cell pushGenerateImage];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FlipAnimationViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"FlipVC"];
    DataCollectionViewCell *cell = (DataCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    controller.image = cell.productDetailImageView;
    [self.viewController presentViewController:controller animated:NO completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat collectionViewSizeWidth = collectionView.frame.size.width;
    CGFloat collectionViewSizeHeight = collectionView.frame.size.height - 50;


    return CGSizeMake(collectionViewSizeWidth/3, collectionViewSizeHeight/2);
}


@end
