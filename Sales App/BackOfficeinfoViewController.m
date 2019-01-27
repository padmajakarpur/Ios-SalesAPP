//
//  BackOfficeinfoViewController.m
//  Sales App
//
//  Created by Infinitum on 19/10/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BackOfficeinfoViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface BackOfficeinfoViewController ()<MXSegmentedPagerDelegate,MXPagerViewDataSource,MXSegmentedPagerDelegate,MXSegmentedPagerDataSource>

@end
@implementation BackOfficeinfoViewController
@synthesize mxpager,dict,daboardarr,summeryarr,loanarr,statusarr,historyarr,contactarr,indicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    //  [self generatenavigation];
    tittlearr=[NSMutableArray arrayWithObjects:@"Dashboard",@"Summery",@"Loan Details",@"Contact",@"Status",@"History", nil];

    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    
    UIButton*  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    //  [backBtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow_back_white.png"] forState:UIControlStateNormal];
    [navigationView addSubview:backBtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Info";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    // Do any additional setup after loading the view from its nib.
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.00,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.30)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
   
    headerView.layer.masksToBounds = NO;
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    Srnolbl.textAlignment = NSTextAlignmentCenter;
    Srnolbl.text = [dict objectForKey:@"name1"];
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    Srnolbl.layer.borderColor = [UIColor grayColor].CGColor;
    Srnolbl.layer.borderWidth = 1.0;
    
    UILabel*  reggstatus = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.0,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    reggstatus.font=[UIFont systemFontOfSize :screenRect.size.width*0.035];
    reggstatus.textAlignment = NSTextAlignmentCenter;
    reggstatus.text = [NSString stringWithFormat:@"Reg. status-%@",[dict objectForKey:@"reg_status"]];
    reggstatus.backgroundColor = [UIColor clearColor];
    reggstatus.textColor=[UIColor blackColor];
    reggstatus.lineBreakMode = NSLineBreakByWordWrapping;
    reggstatus.numberOfLines = 0;
    [headerView addSubview:reggstatus];
    reggstatus.layer.borderColor = [UIColor grayColor].CGColor;
    reggstatus.layer.borderWidth = 1.0;

    UILabel*  mobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    mobilelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    mobilelbl.textAlignment = NSTextAlignmentCenter;
    mobilelbl.text =[NSString stringWithFormat:@"%@/%@",[dict objectForKey:@"proj_name"],[dict objectForKey:@"unit_no"]];
    mobilelbl.backgroundColor = [UIColor clearColor];
    mobilelbl.textColor=[UIColor blackColor];
    mobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    mobilelbl.numberOfLines = 0;
    [headerView addSubview:mobilelbl];
    mobilelbl.layer.borderColor = [UIColor grayColor].CGColor;
    mobilelbl.layer.borderWidth = 1.0;
    
    UILabel*  debitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    debitlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    debitlbl.textAlignment = NSTextAlignmentCenter;
    debitlbl.lineBreakMode = NSLineBreakByWordWrapping;
    debitlbl.numberOfLines = 0;
    debitlbl.text =[NSString stringWithFormat:@"o/s w/o int debit(%@%%) %@",[dict objectForKey:@"os_percent"],[dict objectForKey:@"os_wo_interest"]];
    debitlbl.backgroundColor = [UIColor clearColor];
    debitlbl.textColor=[UIColor blackColor];
    [headerView addSubview:debitlbl];
    debitlbl.layer.borderColor = [UIColor grayColor].CGColor;
    debitlbl.layer.borderWidth = 1.0;

    
    UILabel*  avlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    avlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    avlbl.textAlignment = NSTextAlignmentCenter;
    avlbl.text =[NSString stringWithFormat:@"AV+GS-%@",[dict objectForKey:@"ag_gst"]];
    avlbl.backgroundColor = [UIColor clearColor];
    avlbl.textColor=[UIColor blackColor];
    avlbl.lineBreakMode = NSLineBreakByWordWrapping;
    avlbl.numberOfLines = 0;
    [headerView addSubview:avlbl];
    avlbl.layer.borderColor = [UIColor grayColor].CGColor;
    avlbl.layer.borderWidth = 1.0;

  
    
    UILabel*  totoalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.10,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    totoalbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    totoalbl.textAlignment = NSTextAlignmentCenter;
    totoalbl.text =[NSString stringWithFormat:@"Interest-%@",[dict objectForKey:@"int_debit"]];
    totoalbl.backgroundColor = [UIColor clearColor];
    totoalbl.textColor=[UIColor blackColor];
    totoalbl.lineBreakMode = NSLineBreakByWordWrapping;
    totoalbl.numberOfLines = 0;
    [headerView addSubview:totoalbl];
    totoalbl.layer.borderColor = [UIColor grayColor].CGColor;
    totoalbl.layer.borderWidth = 1.0;
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.15,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    datelbl.textAlignment = NSTextAlignmentCenter;
    datelbl.text =[NSString stringWithFormat:@"Total Cleared(%@%%) %@",[dict objectForKey:@"clr_percent"],[dict objectForKey:@"clr_act"]];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    datelbl.layer.borderColor = [UIColor grayColor].CGColor;
    datelbl.layer.borderWidth = 1.0;
    
    UILabel*  interstlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.15,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    interstlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    interstlbl.textAlignment = NSTextAlignmentCenter;
    interstlbl.text =[NSString stringWithFormat:@"Total os-%@",[dict objectForKey:@"total_os"]];
    interstlbl.backgroundColor = [UIColor clearColor];
    interstlbl.textColor=[UIColor blackColor];
    interstlbl.lineBreakMode = NSLineBreakByWordWrapping;
    interstlbl.numberOfLines = 0;
    [headerView addSubview:interstlbl];
    interstlbl.layer.borderColor = [UIColor grayColor].CGColor;
    interstlbl.layer.borderWidth = 1.0;
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.20,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    namelbl.textAlignment = NSTextAlignmentCenter;
    namelbl.text =[NSString stringWithFormat:@"scheme-%@",[dict objectForKey:@"scheme"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    [headerView addSubview:namelbl];
    namelbl.layer.borderColor = [UIColor grayColor].CGColor;
    namelbl.layer.borderWidth = 1.0;
    
    UILabel*  ramaklbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.20,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    ramaklbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    ramaklbl.textAlignment = NSTextAlignmentCenter;
    ramaklbl.text =[NSString stringWithFormat:@"Sales Remark-%@",[dict objectForKey:@"sales_remark"]];
    ramaklbl.backgroundColor = [UIColor clearColor];
    ramaklbl.textColor=[UIColor blackColor];
    ramaklbl.lineBreakMode = NSLineBreakByWordWrapping;
    ramaklbl.numberOfLines = 0;
    [headerView addSubview:ramaklbl];
    ramaklbl.layer.borderColor = [UIColor grayColor].CGColor;
    ramaklbl.layer.borderWidth = 1.0;
    
    UILabel*  activitylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.25,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    activitylbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    activitylbl.textAlignment = NSTextAlignmentCenter;
    activitylbl.text =[NSString stringWithFormat:@"Activity-%@",[dict objectForKey:@"process"]];
    activitylbl.backgroundColor = [UIColor clearColor];
    activitylbl.textColor=[UIColor blackColor];
    activitylbl.lineBreakMode = NSLineBreakByWordWrapping;
    activitylbl.numberOfLines = 0;
    [headerView addSubview:activitylbl];
    activitylbl.layer.borderColor = [UIColor grayColor].CGColor;
    activitylbl.layer.borderWidth = 1.0;
    
    UILabel*  folluplbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.25,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    folluplbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    folluplbl.textAlignment = NSTextAlignmentCenter;
    folluplbl.text =[NSString stringWithFormat:@"Followup date-%@",[dict objectForKey:@"sales_fu_date"]];
    folluplbl.backgroundColor = [UIColor clearColor];
    folluplbl.textColor=[UIColor blackColor];
    folluplbl.lineBreakMode = NSLineBreakByWordWrapping;
    folluplbl.numberOfLines = 0;
    [headerView addSubview:folluplbl];
    [self.view addSubview:headerView];
    folluplbl.layer.borderColor = [UIColor grayColor].CGColor;
    folluplbl.layer.borderWidth = 1.0;

    mxpager=[[MXSegmentedPager alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.40,screenRect.size.width,screenRect.size.height*0.60)];
    [self.view addSubview:mxpager];
    
    mxpager.delegate=self;
    mxpager.dataSource=self;
    mxpager.backgroundColor=[UIColor lightGrayColor];
    mxpager.segmentedControlPosition=MXSegmentedControlPositionTop;
    mxpager.contentMode=UIViewContentModeTop;
    mxpager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    mxpager.segmentedControl.selectionIndicatorColor = [UIColor blackColor];
    mxpager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    mxpager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    mxpager.segmentedControl.titleTextAttributes=@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor blackColor]};
    mxpager.segmentedControl.backgroundColor=[UIColor lightGrayColor];
    [mxpager.pager registerClass:[UITextView class] forPageReuseIdentifier:@"TextPage"];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    //  [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
    [params setObject:@"getbooking" forKey:@"requestType"];
    [params setObject:[dict objectForKey:@"bknum"]  forKey:@"bknum"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbofficebooking.php?",[prefs objectForKey:@"Link"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@",userDict);
        self.infodict=[userDict objectForKey:@"ProjectDetails"];
        self.daboardarr=[self.infodict objectForKey:@"OT_DASHBOARD"];
            self.summeryarr=[self.infodict objectForKey:@"OT_SUMMARY"];
            self.loanarr=[self.infodict objectForKey:@"OT_LOAN"];
            self.contactarr=[self.infodict objectForKey:@"OT_CONTACT"];
            self.statusarr=[self.infodict objectForKey:@"OT_STATUS"];
            self.historyarr=[self.infodict objectForKey:@"OT_HISTORY"];
         [self.mxpager reloadData];
        [self.indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 40.f;
}
- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
  
}
- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    NSLog(@"progress %f", parallaxHeader.progress);
}

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return tittlearr.count;
}
- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return [tittlearr objectAtIndex:index];
    
}
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    
   
    UITableView*  tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.tag=index;
    
    return tableView;
}
-(void)backbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==0)
        return daboardarr.count;

    if(tableView.tag==1)
        return summeryarr.count;

    if(tableView.tag==2)
        return loanarr.count;

    if(tableView.tag==3 )
        return contactarr.count;

    if(tableView.tag==4)
        return statusarr.count;

    if(tableView.tag==5)
        return historyarr.count;
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
   
    NSMutableArray * arr=[[NSMutableArray alloc]init];
    if(tableView.tag==0)
        arr=[daboardarr mutableCopy ];
    
    if(tableView.tag==1)
          arr=[summeryarr mutableCopy ];
    
    if(tableView.tag==2)
          arr=[loanarr mutableCopy ];
    
    if(tableView.tag==3)
          arr=[contactarr mutableCopy ];
    
    if(tableView.tag==4)
          arr=[statusarr mutableCopy ];
    
    if(tableView.tag==5)
          arr=[historyarr mutableCopy ];

    NSMutableDictionary*dict=[arr objectAtIndex:indexPath.row];

        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor whiteColor];
        CGFloat borderWidth = 2.0f;
        headerView.frame = CGRectInset(headerView.frame, -borderWidth, -borderWidth);
        headerView.layer.borderColor = [UIColor grayColor].CGColor;
        headerView.layer.borderWidth = borderWidth;
        
        UIButton*  drawerbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*.07)];
        drawerbtn.font=[UIFont systemFontOfSize:screenRect.size.width*0.35];
        [drawerbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        drawerbtn.backgroundColor=[UIColor clearColor];
        [headerView addSubview:drawerbtn];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.00,screenRect.size.width*0.55,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =[dict objectForKey:@"C1"];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        [headerView addSubview:Srnolbl];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        
        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.00,screenRect.size.width*0.35,screenRect.size.height*0.07)];
        textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        textlbl.textAlignment = NSTextAlignmentRight;
        textlbl.text =[[dict objectForKey:@"C2"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor blackColor];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        textlbl.numberOfLines = 0;
    
    if(tableView.tag==5)
    {
        textlbl.hidden=YES;
        Srnolbl.frame=CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.00,screenRect.size.width*0.88,screenRect.size.height*0.07);
        Srnolbl.text =[[dict objectForKey:@"TDLINE"] stringByReplacingOccurrencesOfString:@"*" withString:@""];
    }
    if ([[dict objectForKey:@"C3"] isEqualToString:@"X"])
        textlbl.textAlignment = NSTextAlignmentRight;

    else
        textlbl.textAlignment = NSTextAlignmentLeft;

    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
        return screenRect.size.height*0.070;
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
