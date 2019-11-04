//
//  DataCollectionViewCell.m
//  FyndAssignment
//
//  Created by Zeba Khan on 14/10/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import "DataCollectionViewCell.h"
#import "SDWebImage.h"

@implementation DataCollectionViewCell

- (void)pushGenerateImage {
    NSArray *myImageNames = [NSArray arrayWithObjects:@"https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?cs=srgb&dl=beauty-bloom-blue-67636.jpg&fm=jpg", @"https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?cs=srgb&dl=beautiful-beauty-blue-414612.jpg&fm=jpg", @"https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?cs=srgb&dl=beautiful-blur-bright-326055.jpg&fm=jpg", @"https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg?cs=srgb&dl=beautiful-beautiful-flowers-bright-1133957.jpg&fm=jpg",@"https://image.shutterstock.com/z/stock-photo-mountains-during-sunset-beautiful-natural-landscape-in-the-summer-time-407021107.jpg", nil];
    int index = arc4random() % ([myImageNames count] - 1);

   // UIImage *myImage = [UIImage imageNamed:[myImageNames objectAtIndex:index]];
    [_productDetailImageView sd_setImageWithURL:[NSURL URLWithString:[myImageNames objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"fynd"]];
   // _productDetailImageView.image = myImage;
}

@end
