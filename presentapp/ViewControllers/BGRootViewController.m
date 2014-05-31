//
// Created by Johnny Sparks on 5/31/14.
// Copyright (c) 2014 beergrammer. All rights reserved.
//

#import "BGRootViewController.h"


@interface BGRootViewController ()
@property(nonatomic, strong) NSMutableArray *rectViews;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *sliders;
@property(nonatomic) float x;
@property(nonatomic) float y;
@property(nonatomic) float z;
@property(nonatomic) float p;
@end

@implementation BGRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 10);
    self.scrollView.backgroundColor = [UIColor blueColor];

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
        [self.scrollView addSubview:myRect];
        count2 = 10;
        while(count2--){
            myRect = [[UIImageView alloc] initWithFrame:CGRectMake(( rectHeight * count2 ), ( (rectHeight + 20)* count ) + 20, 100, rectHeight)];
            [myRect setImage:[UIImage imageNamed:@"kitten.jpeg"]];
            myRect.backgroundColor = [UIColor whiteColor];
            [self.rectViews addObject:myRect];
            [self.scrollView addSubview:myRect];
        }
    }

    self.x = 0.0f;
    self.y = 0.0f;
    self.z = 0.0f;

    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor whiteColor];


    UISlider *slider;
    NSUInteger sliderCount = 4;
    while (sliderCount --){
        slider = [[UISlider alloc] initWithFrame:CGRectMake(800, (sliderCount * 50) + 100, 200, 10)];
        [slider addTarget:self action:@selector(sliderUpdated:) forControlEvents:UIControlEventValueChanged];
        slider.tag = sliderCount;
        [self.view addSubview:slider];
    }
}

- (void)sliderUpdated:(UISlider *)slider {
    NSLog(@"%f", slider.value);

    switch (slider.tag){
        case 0: self.p = slider.value; break;
        case 1: self.z = slider.value; break;
        case 2: self.y = slider.value; break;
        case 3: self.x = slider.value; break;
    }


    CALayer *layer = self.scrollView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = -1.0 / (200 + (self.p * 1000));
    
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, self.x * 2 * M_PI, 1, 0, 0);
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, self.y * 2 * M_PI, 0, 1, 0);
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, self.z * 2 * M_PI, 0, 0, 1);
    
    layer.transform = rotationAndPerspectiveTransform;
    [self.view sendSubviewToBack:self.scrollView];
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
                         [self.scrollView setFrame:newFrame];
                     }
                     completion:^(BOOL finished) {}];
}


@end