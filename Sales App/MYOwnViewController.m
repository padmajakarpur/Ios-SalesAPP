//
//  MYOwnViewController.m
//  Sales App
//
//  Created by Infinitum on 07/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MYOwnViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"

@interface MYOwnViewController ()

@end

@implementation MYOwnViewController
@synthesize tableViewHome;
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
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.16,screenRect.size.width,screenRect.size.height*0.05)];
    horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    horizontallbl.text=@"MY BOOKINGS";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
  
    stattusarr=[[NSMutableArray alloc]initWithObjects:@"BOOKED",@"REGISTERED", nil];

    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*.22, screenRect.size.width*.94,screenRect.size.height*.60)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewHome.scrollEnabled=NO;
    [self.view addSubview:tableViewHome];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.07,screenRect.size.height*0.16)];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.07,0,screenRect.size.width*0.87,screenRect.size.height*0.16)];
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.20,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =@"SUBJECT";
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    [headerView addSubview:Srnolbl];
    
    UILabel*  Srnolbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.32,0,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    Srnolbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl2.textAlignment = NSTextAlignmentLeft;
    Srnolbl2.text =@": BKG00001301";
    Srnolbl2.backgroundColor = [UIColor clearColor];
    Srnolbl2.textColor=[UIColor blackColor];
    [headerView addSubview:Srnolbl2];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text = @"PAID AMOUNT";
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor grayColor];
    [headerView addSubview:namelbl];
    
    UILabel*  namelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.32,screenRect.size.height*0.04,screenRect.size.width*0.22,screenRect.size.height*0.04)];
    namelbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    namelbl2.textAlignment = NSTextAlignmentLeft;
    namelbl2.text =@": 101";
    namelbl2.backgroundColor = [UIColor clearColor];
    namelbl2.textColor=[UIColor grayColor];
    [headerView addSubview:namelbl2];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    idlbl.textAlignment = NSTextAlignmentLeft;
    idlbl.text = @"UNIT NO";
    idlbl.backgroundColor = [UIColor clearColor];
    idlbl.textColor=[UIColor grayColor];
    [headerView addSubview:idlbl];
    
    UILabel*  idlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.32,screenRect.size.height*0.08,screenRect.size.width*0.22,screenRect.size.height*0.04)];
    idlbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    idlbl2.textAlignment = NSTextAlignmentLeft;
    idlbl2.text =@": A4-224";
    idlbl2.backgroundColor = [UIColor clearColor];
    idlbl2.textColor=[UIColor grayColor];
    [headerView addSubview:idlbl2];
    
    UILabel*  statuslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    statuslbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    statuslbl.textAlignment = NSTextAlignmentLeft;
    statuslbl.text = @"STATUS";
    statuslbl.backgroundColor = [UIColor clearColor];
    statuslbl.textColor=[UIColor grayColor];
    [headerView addSubview:statuslbl];
    
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.34,screenRect.size.height*0.125,screenRect.size.width*0.22,screenRect.size.height*0.03)];
    [Createvoucherbtn setClipsToBounds:YES];
    [Createvoucherbtn setTitle:[stattusarr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    // [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Createvoucherbtn];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.025]];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#4861AC"]] ;
    [headerView addSubview:Createvoucherbtn];
    
    [cell.contentView addSubview:leftview];
    [cell.contentView addSubview:headerView];
    
    if ([[stattusarr objectAtIndex:indexPath.row] isEqualToString:@"BOOKED"]) {
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#000080"]] ;
        leftview.backgroundColor=[UIColor colorWithHexString:@"#000080"];
    }
    if ([[stattusarr objectAtIndex:indexPath.row] isEqualToString:@"REGISTERED"]) {
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#00cc00"]] ;
        leftview.backgroundColor=[UIColor colorWithHexString:@"#00cc00"];
    }
    
    
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.17;
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
