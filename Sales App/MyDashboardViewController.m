//
//  MyDashboardViewController.m
//  Sales App
//
//  Created by Infinitum on 07/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MyDashboardViewController.h"
#import "HomeViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
@interface MyDashboardViewController ()

@end

@implementation MyDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self generatenavigation];
    [self createTab];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.16,screenRect.size.width,screenRect.size.height*0.05)];
    horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    horizontallbl.text=@"MY DASHBOARD";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)generatenavigation
{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView *headerimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25, screenRect.size.height*0.04, screenRect.size.width*0.50,screenRect.size.height*0.12)];
    headerimageview.image=[UIImage imageNamed:@"Xrbia Logo.png"];
    headerimageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headerimageview];
    
    NSArray * arr=[[NSArray alloc]init];
    UIButton *navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.10,screenRect.size.height*0.06)];
    [navigationbtn setClipsToBounds:YES];
    navigationbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navigationbtn];
    [navigationbtn setImage:[UIImage imageNamed:@"Menu Buttons.png"] forState:UIControlStateNormal];
    
    UIButton *searchbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.08,screenRect.size.width*0.06,screenRect.size.height*0.04)];
    [searchbtn setClipsToBounds:YES];
    searchbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchbtn];
    [searchbtn setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.89,screenRect.size.height*0.08,screenRect.size.width*0.005,screenRect.size.height*0.05)];
    lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineView];
    
    UIButton *alarbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.92,screenRect.size.height*0.08,screenRect.size.width*0.06,screenRect.size.height*0.04)];
    [alarbtn setClipsToBounds:YES];
    alarbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alarbtn];
    [alarbtn setImage:[UIImage imageNamed:@"Bell.png"] forState:UIControlStateNormal];
}
-(void)createTab
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView *shareview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.935,screenRect.size.width*0.25,screenRect.size.height*0.065)];
    shareview.backgroundColor=[UIColor colorWithHexString:@"#e6e6e6"];
    [self.view addSubview:shareview];
    
    UIButton *shariconbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.02,screenRect.size.width*0.06,screenRect.size.height*0.03)];
    [shariconbtn setClipsToBounds:YES];
    shariconbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [shareview addSubview:shariconbtn];
    [shariconbtn setImage:[UIImage imageNamed:@"share Icon.png"] forState:UIControlStateNormal];
    
    UIButton *sharebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.09,screenRect.size.height*0.0,screenRect.size.width*0.16,screenRect.size.height*0.06)];
    [sharebtn setTitle:@"Share" forState:UIControlStateNormal];
    [sharebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sharebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    sharebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [sharebtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.04]];
    [shareview addSubview:sharebtn];
    
    UIView *offerview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.935,screenRect.size.width*0.25,screenRect.size.height*0.065)];
    offerview.backgroundColor=[UIColor colorWithHexString:@"#b3b3b3"];
    [self.view addSubview:offerview];
    
    UIButton *offericonbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.02,screenRect.size.width*0.06,screenRect.size.height*0.03)];
    [offericonbtn setClipsToBounds:YES];
    offericonbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [offerview addSubview:offericonbtn];
    [offericonbtn setImage:[UIImage imageNamed:@"Offer Icon.png"] forState:UIControlStateNormal];
    
    UIButton *offerbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.09,screenRect.size.height*0.0,screenRect.size.width*0.16,screenRect.size.height*0.06)];
    [offerbtn setTitle:@"Offer" forState:UIControlStateNormal];
    [offerbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [offerbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    offerbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [offerbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.04]];
    [offerview addSubview:offerbtn];
    
    UIView *liveview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.935,screenRect.size.width*0.25,screenRect.size.height*0.065)];
    liveview.backgroundColor=[UIColor colorWithHexString:@"#e6e6e6"];
    [self.view addSubview:liveview];
    
    UIButton *chaticonbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.02,screenRect.size.width*0.06,screenRect.size.height*0.03)];
    [chaticonbtn setClipsToBounds:YES];
    chaticonbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [liveview addSubview:chaticonbtn];
    [chaticonbtn setImage:[UIImage imageNamed:@"Live Chat Icon.png"] forState:UIControlStateNormal];
    
    UIButton *chahtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,screenRect.size.height*0.0,screenRect.size.width*0.19,screenRect.size.height*0.06)];
    [chahtbtn setTitle:@"Live chat" forState:UIControlStateNormal];
    [chahtbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chahtbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    chahtbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [chahtbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.04]];
    [liveview addSubview:chahtbtn];
    
    UIView *settingview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.935,screenRect.size.width*0.25,screenRect.size.height*0.065)];
    settingview.backgroundColor=[UIColor colorWithHexString:@"#b3b3b3"];
    [self.view addSubview:settingview];
    
    UIButton *settingicon=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.02,screenRect.size.width*0.06,screenRect.size.height*0.03)];
    [settingicon setClipsToBounds:YES];
    settingicon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [settingview addSubview:settingicon];
    [settingicon setImage:[UIImage imageNamed:@"settings icon.png"] forState:UIControlStateNormal];
    
    UIButton *settingbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.09,screenRect.size.height*0.0,screenRect.size.width*0.16,screenRect.size.height*0.06)];
    [settingbtn setTitle:@"Setting" forState:UIControlStateNormal];
    [settingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    settingbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [settingbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.04]];
    [settingview addSubview:settingbtn];
}
-(void)home
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
