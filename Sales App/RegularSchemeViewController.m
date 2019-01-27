//
//  RegularSchemeViewController.m
//  Sales App
//
//  Created by Infinitum on 08/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "RegularSchemeViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
@interface RegularSchemeViewController ()

@end

@implementation RegularSchemeViewController
@synthesize scrollView,Generalinfobtn,custmsuptbtn,paymentdetailsbtn,Paymentschbtn,duedetailsbtn,interestbtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.16,screenRect.size.width,screenRect.size.height*0.84)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#001900"];
    [self.view addSubview:backgroundview];
    
    [self generatenavigation];
    [self createTab];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.16,screenRect.size.width,screenRect.size.height*0.07)];
    horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    NSString* positionstr9=@"JAYPRAKASH SINGH\n";
    NSString* positionstr10=@"BKG000020478";
    NSMutableAttributedString *attributedString9 =
    [[NSMutableAttributedString alloc] initWithString:positionstr9 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableAttributedString *attributedString10 =
    [[NSMutableAttributedString alloc] initWithString:positionstr10 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attributedString9 appendAttributedString:attributedString10];
    horizontallbl.attributedText = attributedString9;
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    horizontallbl.lineBreakMode = NSLineBreakByWordWrapping;
    horizontallbl.numberOfLines = 0;
    [self.view addSubview:horizontallbl];
    
    CGRect scrollViewFrame = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.23,screenRect.size.width,screenRect.size.height*0.05);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    scrollView.contentSize=CGSizeMake(screenRect.size.width*2.4,screenRect.size.height*0.05);
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    Generalinfobtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    [Generalinfobtn setTitle:@"GENERAL INFO" forState:UIControlStateNormal];
    [Generalinfobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Generalinfobtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    Generalinfobtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Generalinfobtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [Generalinfobtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
    Generalinfobtn.backgroundColor=[UIColor colorWithHexString:@"#004c00"];
    [scrollView addSubview:Generalinfobtn];
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, Generalinfobtn.frame.size.height - 1.0f, Generalinfobtn.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor whiteColor];
    [Generalinfobtn addSubview:bottomBorder];

    custmsuptbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    [custmsuptbtn setTitle:@"CUSTOMER SUPPORT" forState:UIControlStateNormal];
    [custmsuptbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [custmsuptbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    custmsuptbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [custmsuptbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [custmsuptbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
    custmsuptbtn.backgroundColor=[UIColor colorWithHexString:@"#003c00"];
    [scrollView addSubview:custmsuptbtn];
    
    
    Paymentschbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    [Paymentschbtn setTitle:@"PAYMENT SCHEDULE" forState:UIControlStateNormal];
    [Paymentschbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Paymentschbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    Paymentschbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Paymentschbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [Paymentschbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
    Paymentschbtn.backgroundColor=[UIColor colorWithHexString:@"#003c00"];
    [scrollView addSubview:Paymentschbtn];
    
    duedetailsbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*1.20,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    [duedetailsbtn setTitle:@"DUE DETAILS" forState:UIControlStateNormal];
    [duedetailsbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [duedetailsbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    duedetailsbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [duedetailsbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [duedetailsbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
    duedetailsbtn.backgroundColor=[UIColor colorWithHexString:@"#003c00"];
    [scrollView addSubview:duedetailsbtn];
    
    paymentdetailsbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*1.60,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    [paymentdetailsbtn setTitle:@"PAYMENT DETAILS" forState:UIControlStateNormal];
    [paymentdetailsbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [paymentdetailsbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    paymentdetailsbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [paymentdetailsbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [paymentdetailsbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
    paymentdetailsbtn.backgroundColor=[UIColor colorWithHexString:@"#003c00"];
    [scrollView addSubview:paymentdetailsbtn];
    
    interestbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*2.0,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    [interestbtn setTitle:@"INTEREST" forState:UIControlStateNormal];
    [interestbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [interestbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    interestbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [interestbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [interestbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
    interestbtn.backgroundColor=[UIColor colorWithHexString:@"#003c00"];
    [scrollView addSubview:interestbtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)select:(UIButton*)sender
{
    
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
    [sharebtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.03]];
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
    [offerbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.03]];
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
    [chahtbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.03]];
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
    [settingbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.03]];
    [settingview addSubview:settingbtn];
}
-(void)generatenavigation
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIImageView *headerimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25, screenRect.size.height*0.04, screenRect.size.width*0.50,screenRect.size.height*0.12)];
    headerimageview.image=[UIImage imageNamed:@"Xrbia Logo.png"];
    headerimageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headerimageview];
    
    UIButton *navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.10,screenRect.size.height*0.05)];
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
