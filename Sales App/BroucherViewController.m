//
//  BroucherViewController.m
//  Sales App
//
//  Created by Infinitum on 31/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BroucherViewController.h"
#import "UIColor+Expanded.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BroucherViewController ()

@end

@implementation BroucherViewController
@synthesize image,namestr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#d3d3d3"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"";
    [horizontallbl setTextColor:[UIColor blackColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.10,screenRect.size.width*0.98,screenRect.size.height*0.30)];
    [self.view addSubview:imageview];
    imageview.image=image;
    UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.35,screenRect.size.width*0.70,screenRect.size.height*0.05)];
    linelbl1.font=[UIFont boldSystemFontOfSize:16];
    linelbl1.text=namestr;
    [linelbl1 setTextColor:[UIColor whiteColor]];
    linelbl1.backgroundColor=[UIColor clearColor];
    linelbl1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:linelbl1];
    
    UILabel *broucherlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.40,screenRect.size.width,screenRect.size.height*0.07)];
    broucherlbl.font=[UIFont boldSystemFontOfSize:17];
    broucherlbl.text=@"BROCHURE";
    [broucherlbl setTextColor:[UIColor whiteColor]];
    broucherlbl.backgroundColor=[UIColor colorWithHexString:@"#004c00"];
    broucherlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:broucherlbl];

  UIImageView*  broucherimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.50,screenRect.size.width*0.50,screenRect.size.height*0.45)];
    [self.view addSubview:broucherimage];
    [broucherimage sd_setImageWithURL:[NSURL URLWithString:[_responsedict objectForKey:@"Image"]]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    UIButton* broucherbtn=[[UIButton alloc]initWithFrame:broucherimage.frame];
    [broucherbtn addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:broucherbtn];
    [broucherbtn setImage:[UIImage imageNamed:@"Download icon.png"] forState:UIControlStateNormal];
  //  [broucherbtn setTitleEdgeInsets:UIEdgeInsetsMake(screenRect.size.height*.20, screenRect.size.width*.20, screenRect.size.height*.20, screenRect.size.width*.20)];
    [broucherbtn setTitleEdgeInsets:UIEdgeInsetsMake(10.0, 5.0,10.0, 5.0)];

  broucherimage.layer.shadowColor =  [UIColor blackColor].CGColor;
    broucherimage.layer.shadowOffset = CGSizeMake(0, 2.0f);
    broucherimage.layer.shadowOpacity = 2.0f;
    broucherimage.layer.shadowRadius = 4.0f;
    broucherimage.layer.masksToBounds = NO;
    broucherimage.layer.cornerRadius = 0.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)open
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:[ NSURL URLWithString:[_responsedict objectForKey:@"pdf"]] options:@{} completionHandler:NULL];
    }
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
