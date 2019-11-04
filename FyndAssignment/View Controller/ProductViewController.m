//
//  ViewController.m
//  FyndAssignment
//
//  Created by Zeba Khan on 13/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductTableViewCell.h"
#import "DataObject.h"
#import "ServiceWrapper.h"
#import "FyndEnums.h"
#import "ProductListTableViewCell.h"

@interface ProductViewController () <UITableViewDelegate,UITableViewDataSource>

    @property (retain) ServiceWrapper *serviceWrapper;


@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation ProductViewController{
    BOOL isTableViewMode;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.serviceWrapper = [[ServiceWrapper alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
    isTableViewMode = NO;
    
    UISwitch* switchView = [[UISwitch alloc] init];
    [switchView addTarget:self action:@selector(switchButtonPressed) forControlEvents: UIControlEventValueChanged];
    UIBarButtonItem* switchItem = [[UIBarButtonItem alloc] initWithCustomView:switchView];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithTitle:@"sort" style:UIBarButtonItemStylePlain target:self action:@selector(sort)];
    self.navigationItem.rightBarButtonItems = @[switchItem, sort];
    
    [self getCategory];
}


-(void)getCategory {
    
    [self.serviceWrapper getData:@"http://demo4308233.mockable.io/all" OnSuccess:^(id  _Nonnull data) {
    dispatch_async(dispatch_get_main_queue(), ^{
            [self.productTableView reloadData];
        });
    } onFailure:^(NSError * _Nonnull error) {
        
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (isTableViewMode){
        ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productList"];
        cell.categoryItem.text = self.serviceWrapper.categoryDataObj[indexPath.row].name;
        cell.data = self.serviceWrapper.categoryDataObj[indexPath.row].productDetail;
        cell.expandableView.tag = indexPath.row;
        cell.viewcontroller = self;
        cell.backgroundView = nil;
        [cell.detailTableView reloadData];
        return cell;
    }else{
        ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCollectionView"];
        cell.productName.text = self.serviceWrapper.categoryDataObj[indexPath.row].name;
        cell.data = self.serviceWrapper.categoryDataObj[indexPath.row].productDetail;
        cell.viewController = self;
        [cell.productDetailCollectionView reloadData];
        [cell setCollectionHeight];
        return cell;
    }
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.serviceWrapper.categoryDataObj.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isTableViewMode){
        if (self.serviceWrapper.categoryDataObj[indexPath.row].isExpanded){
            return 75 + self.serviceWrapper.categoryDataObj[indexPath.row].productDetail.count * 53;
        }
        return 75;
    }
    return UITableViewAutomaticDimension;
}


-(void) switchButtonPressed {
    NSLog(@"sdfsd");
    isTableViewMode = !isTableViewMode;
    [self.productTableView reloadData];
}

-(void) sort {
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [self.serviceWrapper.categoryDataObj sortUsingDescriptors:[NSArray arrayWithObject:sort]];

    [self.productTableView reloadData];
}

- (IBAction)expandButtonPressed:(id)sender {
    NSLog(@"expand button");
    
    UIButton *theButton = (UIButton*)sender;
    
    for (DataObject *obj in self.serviceWrapper.categoryDataObj){
        if (obj == self.serviceWrapper.categoryDataObj[[theButton tag]]){
            obj.isExpanded = !obj.isExpanded;
        }else {
        obj.isExpanded = NO;
        }
    }
   // self.serviceWrapper.categoryDataObj[[theButton tag]].isExpanded = !self.serviceWrapper.categoryDataObj[[theButton tag]].isExpanded;
    
    [self.productTableView reloadData];
}



@end
