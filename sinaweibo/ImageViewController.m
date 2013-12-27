//
//  ImageViewController.m
//  sinaweibo
//
//  Created by kingslay on 13-12-7.
//  Copyright (c) 2013年 王 金辨. All rights reserved.
//

#import "ImageViewController.h"
#import "PubUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ImageViewController (){
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    CGFloat lastScale;
}

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        lastScale = 1.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)loadView
{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.frame = [UIScreen mainScreen].bounds;
    _scrollView.bouncesZoom = true;
    _scrollView.delegate = self;
    self.view = _scrollView;
    _scrollView.scrollEnabled = true;
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = [UIScreen mainScreen].bounds;
    [_scrollView addSubview:_imageView];
    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    twoFingerTap.numberOfTouchesRequired = 2;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [singleTap requireGestureRecognizerToFail:twoFingerTap];

    [_imageView addGestureRecognizer:doubleTap];
    [_imageView addGestureRecognizer:singleTap];
    [_imageView addGestureRecognizer:twoFingerTap];
    
    [_imageView addObserver:self forKeyPath:@"image" options:0 context:nil];

}
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.numberOfTouches ==1) {
        [UIView animateWithDuration: 0.1 animations:^{
            
        } completion:^(BOOL finished) {
            [_imageView removeObserver:self forKeyPath:@"image"];
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }else if (gestureRecognizer.numberOfTouches ==2){
        [self handleDoubleTap:gestureRecognizer];
    }
    
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    _scrollView.zoomScale = 1;
    CGPoint center = CGPointMake(MAX(_imageView.frame.size.width/2, _scrollView.frame.size.width/2),MAX(_imageView.frame.size.height/2, _scrollView.frame.size.height/2));
    _imageView.center =center;

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"]) {
        if (_imageView.image) {
            CGSize size = _imageView.image.size;
            float scale = MIN(_scrollView.frame.size.width/size.width, _scrollView.frame.size.height/size.height);
            if(scale<1){
                _scrollView.minimumZoomScale = scale;
                 _imageView.frame = CGRectMake(0,0,size.width,size.height);
            }else{
                 _scrollView.minimumZoomScale = 1;
            }
            _scrollView.zoomScale = _scrollView.minimumZoomScale;
            _imageView.center = _scrollView.center;
        }
    }
}

-(void)show:(NSString *)imageURL
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    [_imageView setImageWithURL:[NSURL URLWithString:imageURL]];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    
    CGPoint center = CGPointMake(MAX(view.frame.size.width/2, scrollView.frame.size.width/2),MAX(view.frame.size.height/2, scrollView.frame.size.height/2));
    view.center =center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
