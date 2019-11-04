//
//  FlipAnimationViewController.m
//  FyndAssignment
//
//  Created by Danish Ansari on 05/11/19.
//  Copyright © 2019 neebal. All rights reserved.
//

#import "FlipAnimationViewController.h"

@interface FlipAnimationViewController ()

@end

@implementation FlipAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imageView setImage:[UIImage imageNamed:@"fynd"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)flipButtonPressed:(id)sender {
    [self.imageView setImage:self.image.image];
    [UIView transitionWithView:self.imageView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    
}

@end
