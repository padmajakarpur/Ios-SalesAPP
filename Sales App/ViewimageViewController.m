//
//  ViewimageViewController.m
//  ESD
//
//  Created by Apple on 18/04/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ViewimageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Expanded.h"

@interface ViewimageViewController ()

@end
@implementation ViewimageViewController
@synthesize scrollview,profileViewimageView,urlstr ;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView *bgimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height)];
    [bgimageView setImage:[UIImage imageNamed:@"splash_screen.png"]];
    [self.view addSubview:bgimageView];

    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
  //  appDelegate=[[UIApplication sharedApplication] delegate];
    
    scrollview=[[UIScrollView alloc]init];
    scrollview.layer.frame=CGRectMake(0,screenRect.size.height*0.12,screenRect.size.width,screenRect.size.height*0.88);
    [scrollview removeFromSuperview];
    [self.view addSubview:scrollview];
    
    profileViewimageView =[[UIImageView alloc]init];
    profileViewimageView.layer.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.25);
    [profileViewimageView removeFromSuperview];
    [scrollview addSubview:self.profileViewimageView];
    
    self.scrollview.delegate=self;
    
    [profileViewimageView sd_setImageWithURL:[NSURL URLWithString:urlstr]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             }];
    profileViewimageView.frame = scrollview.bounds;
    [profileViewimageView setContentMode:UIViewContentModeScaleAspectFit];
    //scrollFront.contentSize = CGSizeMake(BackImgVw1.frame.size.width, BackImgVw1.frame.size.height);
    scrollview.maximumZoomScale = 4.0;
    scrollview.minimumZoomScale = 1.0;
    scrollview.delegate = self;
   }


- (void)viewDidUnload {
    self.scrollview = nil;
    self.profileViewimageView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
   
    if (scrollView==scrollview) {
        
        return self.profileViewimageView;
    }
    return 0;
}
- (IBAction)back:(id)sender
{ 
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
