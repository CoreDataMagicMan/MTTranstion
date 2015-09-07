//
//  ViewController.m
//  MTTranstion
//
//  Created by mtt0150 on 15/9/7.
//  Copyright (c) 2015年 MT. All rights reserved.
//

#import "ViewController.h"
#define IMAGECOUNT 5
@interface ViewController ()
//标志图片的下标
@property (assign, nonatomic) NSInteger index;
//声明一个用来显示image
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //首先需要初始化一个imageview
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = [UIScreen mainScreen].applicationFrame;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    //设置默认图片
    _imageView.image = [UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:_imageView];
    //添加左滑动手势
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeHandle:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipe];
    //添加右滑动手势
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeHandle:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipe];
}
- (void)upSwipeHandle:(UIGestureRecognizer *)gesture{
    //下一张图片
    [self displayImage:YES];
}
- (void)downSwipeHandle:(UIGestureRecognizer *)gesture{
    //上一张图片
    [self displayImage:NO];
    
}
- (void)displayImage:(BOOL)isNext{
    //在这里面初始化一个转场动画
    CATransition *transition = [CATransition animation];
    //设置转场的类型
    transition.type = @"oglFlip";
    //设置转场的方向
    if (isNext) {
        transition.subtype = kCATransitionFromTop;
    }
    else{
        transition.subtype = kCATransitionFromBottom;
    }
    transition.duration = 1.0;
    UIImage *image = [UIImage imageNamed:[self imageName:isNext]];
    self.imageView.image = image;
    [self.imageView.layer addAnimation:transition forKey:@"imageView-transition"];
    
}
- (NSString *)imageName:(BOOL)isNext{
    if (isNext) {
        self.index = (_index + 1) % IMAGECOUNT;
    }
    else{
        self.index = (_index + IMAGECOUNT - 1) % IMAGECOUNT;
    }
    NSString *imageString = [NSString stringWithFormat:@"%lu.jpg",self.index];
    return imageString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
