//
//  DiscApprovalViewController.m
//  Sales App
//
//  Created by Infinitum on 21/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "DiscApprovalViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface DiscApprovalViewController ()

@end

@implementation DiscApprovalViewController
@synthesize  tableViewHome,indicator,str,listarr,TakePhotoView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];;
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    if ([str isEqualToString:@"1"]) {
        horizontallbl.text=@"Discount Approval";
    }
    else if ([str isEqualToString:@"3"]) {
        horizontallbl.text=@"Cancel Approval";
    }
    else{
        horizontallbl.text=@"Transfer Approval";
    }
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewHome];
    
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
    [self getlist];
}

-(void)getlist
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    NSString*urlString =[[NSString alloc]init];
    [params setObject:@"get_list"forKey:@"requestType"];
    if ([str isEqualToString:@"3"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@savecancelation.php?",[prefs objectForKey:@"Link"]];
    }
    if ([str isEqualToString:@"2"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@saveshifting.php?",[prefs objectForKey:@"Link"]];
    }
    if ([str isEqualToString:@"1"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getdiscountvalue.php?",[prefs objectForKey:@"Link"]];
    }
    
    
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        listarr=[[NSMutableArray alloc]init];
        listarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                      length:[responseObject length] encoding: NSUTF8StringEncoding];
        //   NSLog(@"content %@",content);
        NSLog(@"content %@",listarr);
        
//        NSString *content1 = [[NSString alloc]  initWithBytes:[responseObject bytes]
//                                                      length:[responseObject length] encoding: NSUTF8StringEncoding];
//        NSLog(@"content1 %@",content1);
        
        [tableViewHome reloadData];
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
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
   return listarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSMutableDictionary * dict=[listarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.35)]; //0.35
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.70,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Name: %@",[dict objectForKey:@"customer_name"]];
    ;
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  projectlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.70,screenRect.size.height*0.035)];
    projectlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    projectlbl.textAlignment = NSTextAlignmentLeft;
    projectlbl.text =[NSString stringWithFormat:@"Project: %@",[dict objectForKey:@"project_name"]];
    ;
    projectlbl.backgroundColor = [UIColor clearColor];
    projectlbl.textColor=[UIColor blackColor];
    projectlbl.lineBreakMode = NSLineBreakByWordWrapping;
    projectlbl.numberOfLines = 0;
    
    [headerView addSubview:projectlbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.085,screenRect.size.width*0.70,screenRect.size.height*0.035)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =[NSString stringWithFormat:@"Unit No: %@",[dict objectForKey:@"unit_no"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11,screenRect.size.width*0.80,screenRect.size.height*0.050)];//0.035 h   0.70 w  y=0.12
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    idlbl.textAlignment = NSTextAlignmentLeft;
    idlbl.text = [NSString stringWithFormat:@"Reason: %@",[dict objectForKey:@"cancelled_reason_c"]];
    idlbl.backgroundColor = [UIColor clearColor];
    idlbl.textColor=[UIColor blackColor];
    //idlbl.backgroundColor=[UIColor redColor];
    //idlbl.lineBreakMode = NSLineBreakByWordWrapping;
    idlbl.lineBreakMode = NSLineBreakByCharWrapping;
   
   // idlbl.font=[UIFont systemFontOfSize:10];
//    NSString *oneTwoThree = @"  TestString   ";
//    NSString *resultString;
//    resultString = [self removeEndSpaceFrom:oneTwoThree];
    
    idlbl.numberOfLines = 0;//0
    [headerView addSubview:idlbl];
    
    UILabel*  moblbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.155,screenRect.size.width*0.60,screenRect.size.height*0.035)]; //y 0.155
    moblbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    moblbl.textAlignment = NSTextAlignmentLeft;
    moblbl.text =[NSString stringWithFormat:@"Discount req value: %@",[dict objectForKey:@""]];
    moblbl.backgroundColor = [UIColor clearColor];
    moblbl.textColor=[UIColor blackColor];
    moblbl.lineBreakMode = NSLineBreakByWordWrapping;
    moblbl.numberOfLines = 0;
    [headerView addSubview:moblbl];
  
    if ([str isEqualToString:@"1"]) {
        Srnolbl.text =[NSString stringWithFormat:@"Project Name: %@",[dict objectForKey:@"proj_name"]];
        projectlbl.text =[NSString stringWithFormat:@"Requested by: %@",[dict objectForKey:@"requested_by"]];
        namelbl.text =[NSString stringWithFormat:@"Unit No: %@",[dict objectForKey:@"unit_no"]];
        idlbl.text =[NSString stringWithFormat:@"Agr. value: %@",[dict objectForKey:@"agvalue"]];
        moblbl.text =[NSString stringWithFormat:@"Discount amount: %@",[dict objectForKey:@"discount_amt"]];

        UILabel*  remarklbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.19,screenRect.size.width - 45,50)];
        remarklbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        remarklbl.textAlignment = NSTextAlignmentLeft;
        remarklbl.text =[NSString stringWithFormat:@"Discount remark: %@",[dict objectForKey:@"remarks"]];
        remarklbl.backgroundColor = [UIColor clearColor];
        remarklbl.textColor=[UIColor blackColor];
        remarklbl.lineBreakMode = NSLineBreakByWordWrapping;
        remarklbl.numberOfLines = 3;
        [remarklbl sizeToFit];
        [headerView addSubview:remarklbl];
        
        UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.29,screenRect.size.width*0.90,screenRect.size.height*0.003)];
        linelbl.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:linelbl];
        
        UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.30,screenRect.size.width*0.20,screenRect.size.height*0.04)];
        Createvoucherbtn.layer.cornerRadius = 4.0f;
        [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [Createvoucherbtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [Createvoucherbtn setTitle:@"Approve"forState:UIControlStateNormal];
        Createvoucherbtn.tag=indexPath.row;
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#007E2F"]] ;
        [headerView addSubview:Createvoucherbtn];
        
        UIButton *reject=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.73,screenRect.size.height*0.30,screenRect.size.width*0.20,screenRect.size.height*0.04)];
        reject.layer.cornerRadius = 4.0f;
        reject.tag=indexPath.row;
        [reject.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [reject addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [reject setTitle:@"Reject"forState:UIControlStateNormal];
        [reject setBackgroundColor:[UIColor redColor]] ;
        [headerView addSubview:reject];

headerView.frame=CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.35);
    }
    if ([str isEqualToString:@"2"]) {
        Srnolbl.text =[NSString stringWithFormat:@"From project: %@",[dict objectForKey:@"from_project_name"]];
        projectlbl.text =[NSString stringWithFormat:@"To Project: %@",[dict objectForKey:@"to_project_name"]];
        namelbl.text =[NSString stringWithFormat:@"From Unit No: %@",[dict objectForKey:@"from_unit_no"]];
        idlbl.text =[NSString stringWithFormat:@"To Unit No: %@",[dict objectForKey:@"to_unit_no"]];
        moblbl.text =[NSString stringWithFormat:@"From Agr. value: %@",[dict objectForKey:@"from_agreement_value"]];

        UILabel*  remarklbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.21,screenRect.size.width - 45,50)];//0.35  //0.19
        remarklbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        remarklbl.textAlignment = NSTextAlignmentLeft;
        remarklbl.text = [NSString stringWithFormat:@"Shifting reason: %@",[dict objectForKey:@"shifting_reason_c"]];
        remarklbl.backgroundColor = [UIColor clearColor];
        remarklbl.textColor=[UIColor blackColor];
       // remarklbl.lineBreakMode = NSLineBreakByWordWrapping;
        remarklbl.lineBreakMode = NSLineBreakByCharWrapping;
        remarklbl.numberOfLines = 3;
        remarklbl.adjustsFontSizeToFitWidth = true;
        [headerView addSubview:remarklbl];
        
        //delete
        UILabel*  remarklbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.17,screenRect.size.width - 45,50)];//0.35
        remarklbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        remarklbl1.textAlignment = NSTextAlignmentLeft;
        remarklbl1.text = [NSString stringWithFormat:@"Requested By: %@",[dict objectForKey:@"initiated_by_c"]];
        remarklbl1.backgroundColor = [UIColor clearColor];
        remarklbl1.textColor=[UIColor blackColor];
        // remarklbl.lineBreakMode = NSLineBreakByWordWrapping;
        remarklbl1.lineBreakMode = NSLineBreakByCharWrapping;
        remarklbl1.numberOfLines = 3;
        remarklbl1.adjustsFontSizeToFitWidth = true;
        [headerView addSubview:remarklbl1];
        

        UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.285,screenRect.size.width*0.90,screenRect.size.height*0.003)];//0.225 y
        linelbl.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:linelbl];
        
        UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.30,screenRect.size.width*0.20,screenRect.size.height*0.04)]; //y 0.23
        Createvoucherbtn.layer.cornerRadius = 4.0f;
        [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [Createvoucherbtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [Createvoucherbtn setTitle:@"Approve"forState:UIControlStateNormal];
        Createvoucherbtn.tag=indexPath.row;
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#007E2F"]] ;
        [headerView addSubview:Createvoucherbtn];
        
        UIButton *reject=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.73,screenRect.size.height*0.30,screenRect.size.width*0.20,screenRect.size.height*0.04)];// y 0.23
        reject.layer.cornerRadius = 4.0f;
        reject.tag=indexPath.row;
        [reject.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [reject addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [reject setTitle:@"Reject"forState:UIControlStateNormal];
        [reject setBackgroundColor:[UIColor redColor]] ;
        [headerView addSubview:reject];
        headerView.frame=CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.35);//0.28
    }
    if ([str isEqualToString:@"3"]) {
        
        UILabel*  moblbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.19,screenRect.size.width - 45,50)];//y 0.19
        moblbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        moblbl2.textAlignment = NSTextAlignmentLeft;
        moblbl2.text = [NSString stringWithFormat:@"Reason: %@",[dict objectForKey:@"cancelled_reason_c"]];
        moblbl2.backgroundColor = [UIColor clearColor];
        moblbl2.textColor=[UIColor blackColor];
        moblbl2.lineBreakMode = NSLineBreakByCharWrapping;
        moblbl2.numberOfLines = 3;
        moblbl2.adjustsFontSizeToFitWidth = YES;
        [headerView addSubview:moblbl2];
        
        //reason label
        idlbl.text = [NSString stringWithFormat:@"Agrement value: %@",[dict objectForKey:@"agreement_value"]];
        
        moblbl.text =[NSString stringWithFormat:@"Initiated by: %@",[dict objectForKey:@"initiated_by_c"]];
        
        
        UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.29,screenRect.size.width*0.90,screenRect.size.height*0.003)];
        linelbl.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:linelbl];
        
        UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.30,screenRect.size.width*0.20,screenRect.size.height*0.04)];
        Createvoucherbtn.layer.cornerRadius = 4.0f;
        [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [Createvoucherbtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [Createvoucherbtn setTitle:@"Approve"forState:UIControlStateNormal];
        Createvoucherbtn.tag=indexPath.row;
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#007E2F"]] ;
        [headerView addSubview:Createvoucherbtn];
        
        UIButton *reject=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.73,screenRect.size.height*0.30,screenRect.size.width*0.20,screenRect.size.height*0.04)];
        reject.layer.cornerRadius = 4.0f;
        reject.tag=indexPath.row;
        [reject.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [reject addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [reject setTitle:@"Reject"forState:UIControlStateNormal];
        [reject setBackgroundColor:[UIColor redColor]] ;
        [headerView addSubview:reject];
        
    
        
headerView.frame=CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.35);} //0.35
    [cell.contentView addSubview:headerView];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    LeadViewController *mainvc=[[LeadViewController alloc] initWithNibName:@"LeadViewController" bundle:nil];
    //    [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if ([str isEqualToString:@"3"])
        return screenRect.size.height*0.38; //0.31
    
   else if ([str isEqualToString:@"2"])
          return screenRect.size.height*0.38; //0.29

    else
        return screenRect.size.height*0.38;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save:(UIButton*)btn
{
  _dict=[listarr objectAtIndex:btn.tag];
    _btntittle=btn.titleLabel.text;

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [self showalert];
    
  
}
-(void)showalert
{
    [TakePhotoView close];
    TakePhotoView = [[CustomIOS7AlertView alloc] init];
    [TakePhotoView setContainerView:[self signImageSetAlert]];
    [TakePhotoView setDelegate:self];
    [TakePhotoView setUseMotionEffects:true];
    [TakePhotoView show];
}
-(UIView *)signImageSetAlert{
    int heig=0;
    UIView *demoView;
    heig=150;
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,160)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    [topButton setTitle:@"Update Status" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topButton setBackgroundColor:[UIColor colorWithHexString:@"#E8E8E8"]];
    [demoView addSubview:topButton];
    
    _aremars= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 50, 280, 50)];
    _aremars.textAlignment=NSTextAlignmentLeft;
    _aremars.delegate = self;
    _aremars.textColor=[UIColor blackColor];
    [_aremars setBackgroundColor:[UIColor clearColor]];
    _aremars.leftViewMode = UITextFieldViewModeAlways;
    [_aremars setKeyboardType:UIKeyboardTypeEmailAddress];
    _aremars.returnKeyType=UIReturnKeyDone;
    _aremars.placeholder=@"Remarks";
    [demoView addSubview:_aremars];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(10,110,135,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:cancelBtn];
    
    UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(155,110,135,40)];
    [okbtn setTitle:@"Submit" forState:UIControlStateNormal];
    [okbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    okbtn.tag=1;
    [okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:okbtn];
    return demoView;
}
-(void)submit
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     if ([str isEqualToString:@"1"]) {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"updatediscountvalue"  forKey:@"requestType"];
    //
         
    [params setObject:[_dict objectForKey:@"pk_id"] forKey:@"pk_id"];
    [params setObject:@"validate_user"  forKey:@"approved_dt"];
    [params setObject:@""  forKey:@"approved_ind"];
    [params setObject:@""  forKey:@"remark"];
    [params setObject:_aremars.text  forKey:@"aremarks"];

    if ([_btntittle isEqualToString:@"Approve"])
        [params setObject:@"Approved"  forKey:@"status"];
    else
        [params setObject:@"Rejected"  forKey:@"status"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@updatedicount.php?",[prefs objectForKey:@"Link"]];
    
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //    NSLog(@"JSON: %@", userDict);
        NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                      length:[responseObject length] encoding: NSUTF8StringEncoding];
        NSLog(@"content %@",content);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message: [userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [indicator stopAnimating];
        [TakePhotoView close];
        [self getlist];
        [alert show];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
     }
    
    if ([str isEqualToString:@"2"]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        NSString*urlString =[[NSString alloc]init];
        [params setObject:@"approve_shifting"forKey:@"requestType"];
        [params setObject:[_dict objectForKey:@"id"]forKey:@"id"];
        [params setObject:_aremars.text forKey:@"approve_remark"];

        
        if ([_btntittle isEqualToString:@"Approve"])
            [params setObject:@"Approved"  forKey:@"action"];
        else
            [params setObject:@"Rejected"  forKey:@"action"];
        
        [params setObject:[prefs objectForKey:@"user_name"]forKey:@"username"];
        [params setObject:[prefs objectForKey:@"password"]forKey:@"password"];
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        [params setObject:[prefs objectForKey:@"user_id"]forKey:@"usersimplecrmId"];
        urlString = [[NSString alloc]initWithFormat:@"%@saveshifting.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableDictionary * userdict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                          length:[responseObject length] encoding: NSUTF8StringEncoding];
            NSLog(@"content %@",userdict);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userdict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [TakePhotoView close];
            [self getlist];
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    if ([str isEqualToString:@"3"]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        NSString*urlString =[[NSString alloc]init];
        [params setObject:@"approve_cancel"forKey:@"requestType"];
        [params setObject:[_dict objectForKey:@"id"]forKey:@"id"];
        [params setObject:_aremars.text forKey:@"approve_remark"];

        if ([_btntittle isEqualToString:@"Approve"])
            [params setObject:@"Approved"  forKey:@"action"];
        else
            [params setObject:@"Rejected"  forKey:@"action"];
        
        [params setObject:[prefs objectForKey:@"user_name"]forKey:@"username"];
        [params setObject:[prefs objectForKey:@"password"]forKey:@"password"];
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        [params setObject:[prefs objectForKey:@"user_id"]forKey:@"usersimplecrmId"];
        
        urlString = [[NSString alloc]initWithFormat:@"%@savecancelation.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableDictionary * userdict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                          length:[responseObject length] encoding: NSUTF8StringEncoding];
            NSLog(@"content %@",userdict);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userdict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getlist];
            [TakePhotoView close];
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)closeAlert:(id)sender{
    [TakePhotoView close];
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
