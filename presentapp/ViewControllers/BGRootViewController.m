//
// Created by Johnny Sparks on 5/31/14.
// Copyright (c) 2014 beergrammer. All rights reserved.
//

#import "BGRootViewController.h"


@interface BGRootViewController ()
@property(nonatomic, strong) NSMutableArray *rectViews;
@property(nonatomic, strong) UIScrollView *myView;
@end

@implementation BGRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    self.myView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.myView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 10);
    self.myView.backgroundColor = [UIColor blueColor];

    self.rectViews = [[NSMutableArray alloc] init];
    CGFloat rectHeight = 200;
    NSUInteger count = 40;
    NSUInteger count2;
    UIImageView *myRect;

    while (count--){
        myRect = [[UIImageView alloc] initWithFrame:CGRectMake(0, ( (rectHeight + 20)* count ) + 20, 100, rectHeight)];
        [myRect setImage:[UIImage imageNamed:@"kitten.jpeg"]];
        myRect.backgroundColor = [UIColor whiteColor];
        [self.rectViews addObject:myRect];
        [self.myView addSubview:myRect];
        count2 = 10;
        while(count2--){
            myRect = [[UIImageView alloc] initWithFrame:CGRectMake(( rectHeight * count2 ), ( (rectHeight + 20)* count ) + 20, 100, rectHeight)];
            [myRect setImage:[UIImage imageNamed:@"kitten.jpeg"]];
            myRect.backgroundColor = [UIColor whiteColor];
            [self.rectViews addObject:myRect];
            [self.myView addSubview:myRect];
        }
    }


    CALayer *layer = self.myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -800;
    //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 60.0f * M_PI / 180.0f, 1.0f, 0.15f, -0.30f);
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 60.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);

    //rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, 0, -350, 0 );
    layer.transform = rotationAndPerspectiveTransform;
    [self.view addSubview:self.myView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    [UIView animateWithDuration:10.0f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
//        CALayer *layer = ((UIScrollView *)[self.view.subviews firstObject]).layer;
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.0f * M_PI / 180.0f, 0.0f, 0.0f, 0.0f);
//        layer.transform = rotationAndPerspectiveTransform;
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    CGRect newFrame = self.view.frame;
    CGFloat oldWidth;

    switch (toInterfaceOrientation){
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            oldWidth = newFrame.size.width;
            newFrame.size.width = newFrame.size.height;
            newFrame.size.height = oldWidth;
            break;
        case UIInterfaceOrientationPortrait:break;
        case UIInterfaceOrientationPortraitUpsideDown:break;
    }
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:0
                     animations:^{
                         [self.myView setFrame:newFrame];
                     }
                     completion:^(BOOL finished) {}];
}


@end