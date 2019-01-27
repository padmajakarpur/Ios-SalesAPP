//
//  BackOffCustomerListViewController.m
//  Sales App
//
//  Created by Infinitum on 19/10/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BackOffCustomerListViewController.h"
#import "UIColor+Expanded.h"
#import "BackOfficeinfoViewController.h"
#import <AFNetworking.h>
#import "DownPicker.h"
@interface BackOffCustomerListViewController ()
@property(nonatomic,retain) NSMutableArray * tittlearr;

@end

@implementation BackOffCustomerListViewController
@synthesize tableViewHome,indicator,bgview,demoView,datetxt,datePicker,numberToolbarzip;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    //  [self generatenavigation];
    
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
    horizontallbl.text=@"Back Office ESC";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10, screenRect.size.width,screenRect.size.height*.9)];
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


-(void)backbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getdata];
}
-(void)getdata
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
    [params setObject:@"getbdetail" forKey:@"requestType"];
    //  [params setObject:@"7e41cd4e-1b4f-6243-d849-599ad02046c5"  forKey:@"user_id"];
    [params setObject:self.processstr  forKey:@"process"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getboffice.php?",[prefs objectForKey:@"Link"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self->_tittlearr=[[NSMutableArray alloc]init];
        
        NSLog(@"JSON: %@", userDict);
        self.tittlearr=[[userDict objectForKey:@"Android"] objectForKey:@"projects"];
        if (_tittlearr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data avaible"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self.tableViewHome reloadData];
        [self.indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tittlearr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    NSMutableDictionary * dict=[_tittlearr objectAtIndex:indexPath.row];
    
    //    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.02,screenRect.size.height*0.12)];
    //    leftview.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    //    leftview.layer.shadowOffset = CGSizeMake(0, 2.0f);
    //    leftview.layer.shadowOpacity = 1.0f;
    //    leftview.layer.shadowRadius = 0.0f;
    //    leftview.layer.masksToBounds = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.35)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.45,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text = [dict objectForKey:@"name1"];
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  reggstatus = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.0,screenRect.size.width*0.45,screenRect.size.height*0.04)];
    reggstatus.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    reggstatus.textAlignment = NSTextAlignmentLeft;
    reggstatus.text = [NSString stringWithFormat:@"Reg. status-%@",[dict objectForKey:@"reg_status"]];
    reggstatus.backgroundColor = [UIColor clearColor];
    reggstatus.textColor=[UIColor blackColor];
    reggstatus.lineBreakMode = NSLineBreakByWordWrapping;
    reggstatus.numberOfLines = 0;
    [headerView addSubview:reggstatus];
    
    UILabel*  mobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    mobilelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    mobilelbl.textAlignment = NSTextAlignmentLeft;
    mobilelbl.text =[NSString stringWithFormat:@"%@/%@",[dict objectForKey:@"proj_name"],[dict objectForKey:@"unit_no"]];
    mobilelbl.backgroundColor = [UIColor clearColor];
    mobilelbl.textColor=[UIColor blackColor];
    mobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    mobilelbl.numberOfLines = 0;
    [headerView addSubview:mobilelbl];
    
   

    UILabel*  debitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.04,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    debitlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    debitlbl.textAlignment = NSTextAlignmentLeft;
    debitlbl.lineBreakMode = NSLineBreakByWordWrapping;
    debitlbl.numberOfLines = 0;
    debitlbl.text =[NSString stringWithFormat:@"o/s w/o int debit(%@%%) %@",[dict objectForKey:@"os_percent"],[dict objectForKey:@"os_wo_interest"]];
    debitlbl.backgroundColor = [UIColor clearColor];
    debitlbl.textColor=[UIColor blackColor];
    [headerView addSubview:debitlbl];
  
    UILabel*  avlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.09,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    avlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    avlbl.textAlignment = NSTextAlignmentLeft;
    avlbl.text =[NSString stringWithFormat:@"AV+GS-%@",[dict objectForKey:@"ag_gst"]];
    avlbl.backgroundColor = [UIColor clearColor];
    avlbl.textColor=[UIColor blackColor];
    avlbl.lineBreakMode = NSLineBreakByWordWrapping;
    avlbl.numberOfLines = 0;
    [headerView addSubview:avlbl];
    
    UILabel*  totoalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.09,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    totoalbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    totoalbl.textAlignment = NSTextAlignmentLeft;
    totoalbl.text =[NSString stringWithFormat:@"Interest-%@",[dict objectForKey:@"int_debit"]];
    totoalbl.backgroundColor = [UIColor clearColor];
    totoalbl.textColor=[UIColor blackColor];
    totoalbl.lineBreakMode = NSLineBreakByWordWrapping;
    totoalbl.numberOfLines = 0;
    [headerView addSubview:totoalbl];
   
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.14,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    datelbl.textAlignment = NSTextAlignmentLeft;
    datelbl.text =[NSString stringWithFormat:@"Total Cleared(%@%%) %@",[dict objectForKey:@"clr_percent"],[dict objectForKey:@"clr_act"]];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    UILabel*  interstlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.14,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    interstlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    interstlbl.textAlignment = NSTextAlignmentLeft;
    interstlbl.text =[NSString stringWithFormat:@"Total os-%@",[dict objectForKey:@"total_os"]];
    interstlbl.backgroundColor = [UIColor clearColor];
    interstlbl.textColor=[UIColor blackColor];
    interstlbl.lineBreakMode = NSLineBreakByWordWrapping;
    interstlbl.numberOfLines = 0;
    [headerView addSubview:interstlbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.19,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =[NSString stringWithFormat:@"scheme-%@",[dict objectForKey:@"scheme"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    [headerView addSubview:namelbl];
    
    UILabel*  ramaklbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.19,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    ramaklbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    ramaklbl.textAlignment = NSTextAlignmentLeft;
    ramaklbl.text =[NSString stringWithFormat:@"Sales Remark-%@",[dict objectForKey:@"sales_remark"]];
    ramaklbl.backgroundColor = [UIColor clearColor];
    ramaklbl.textColor=[UIColor blackColor];
    ramaklbl.lineBreakMode = NSLineBreakByWordWrapping;
    ramaklbl.numberOfLines = 0;
    [headerView addSubview:ramaklbl];
    
    UILabel*  activitylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.24,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    activitylbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    activitylbl.textAlignment = NSTextAlignmentLeft;
    activitylbl.text =[NSString stringWithFormat:@"Activity-%@",[dict objectForKey:@"process"]];
    activitylbl.backgroundColor = [UIColor clearColor];
    activitylbl.textColor=[UIColor blackColor];
    activitylbl.lineBreakMode = NSLineBreakByWordWrapping;
    activitylbl.numberOfLines = 0;
    [headerView addSubview:activitylbl];
    
    UILabel*  folluplbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.24,screenRect.size.width*0.45,screenRect.size.height*0.05)];
    folluplbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    folluplbl.textAlignment = NSTextAlignmentLeft;
    folluplbl.text =[NSString stringWithFormat:@"Followup date-%@",[dict objectForKey:@"sales_fu_date"]];
    folluplbl.backgroundColor = [UIColor clearColor];
    folluplbl.textColor=[UIColor blackColor];
    folluplbl.lineBreakMode = NSLineBreakByWordWrapping;
    folluplbl.numberOfLines = 0;
    [headerView addSubview:folluplbl];

 
    UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.295,screenRect.size.width*0.85,screenRect.size.height*0.003)];
    linelbl.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:linelbl];
    UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.030];
    
    UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.05,screenRect.size.height*0.30,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [editbtn setTitle:@"\uE90E" forState:UIControlStateNormal];
    [headerView addSubview:editbtn];
    
    UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.13,screenRect.size.height*0.30,screenRect.size.width*0.25,screenRect.size.height*.05)];
    [editbtn2 setBackgroundColor:[UIColor clearColor]];
    [editbtn2 addTarget:self action:@selector(remark:) forControlEvents:UIControlEventTouchUpInside];
    editbtn2.tag=indexPath.row;
    [editbtn2 setTitle:@"Update remark" forState:UIControlStateNormal];
    [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    editbtn2.titleLabel.font=font;
    [headerView addSubview:editbtn2];
    [cell.contentView addSubview:headerView];

    UIButton *savebtn1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.38,screenRect.size.height*0.30,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [savebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn1.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn1.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn1 setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:savebtn1];
    
    UIButton *phonebtn1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.46,screenRect.size.height*0.30,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [phonebtn1 setBackgroundColor:[UIColor clearColor]];
       [phonebtn1 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn1.tag=indexPath.row;
    [phonebtn1 setTitle:@"Call1" forState:UIControlStateNormal];
    [phonebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phonebtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phonebtn1.titleLabel.font=font;
    [headerView addSubview:phonebtn1];
    
    UIButton *savebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.58,screenRect.size.height*0.30,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [savebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn2.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn2.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn2 setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:savebtn2];
    
    UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.66,screenRect.size.height*0.30,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [phonebtn2 setBackgroundColor:[UIColor clearColor]];
       [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn2.tag=indexPath.row;
    [phonebtn2 setTitle:@"Call2" forState:UIControlStateNormal];
    [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phonebtn2.titleLabel.font=font;
    [headerView addSubview:phonebtn2];
    
    UIButton *savebtn3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.78,screenRect.size.height*0.30,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [savebtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn3.layer.masksToBounds=YES;
    savebtn3.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn3 setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:savebtn3];
    
    UIButton *phonebtn3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.86,screenRect.size.height*0.30,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [phonebtn3 setBackgroundColor:[UIColor clearColor]];
    [phonebtn3 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn3.tag=indexPath.row;
    [phonebtn3 setTitle:@"Call3" forState:UIControlStateNormal];
    [phonebtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phonebtn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phonebtn3.titleLabel.font=font;
    [headerView addSubview:phonebtn3];
    
    if([[dict objectForKey:@"mobile3"]isEqualToString:@""])
    {
        phonebtn3.hidden=YES;
        savebtn3.hidden=YES;
    }
    if([[dict objectForKey:@"mobile2"]isEqualToString:@""])
    {
        phonebtn2.hidden=YES;
        savebtn2.hidden=YES;
    }
    if([[dict objectForKey:@"mobile1"]isEqualToString:@""])
    {
        phonebtn1.hidden=YES;
        savebtn1.hidden=YES;
    }
    [cell.contentView addSubview:headerView];
    //   headerView.masksToBounds = NO;
    //   headerView.shadowOffset = CGSizeMake(-15, 20);
    //   headerView.shadowRadius = 5;
    //   headerView.shadowOpacity = 0.5;
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        BackOfficeinfoViewController *mainvc=[[BackOfficeinfoViewController alloc] initWithNibName:@"BackOfficeinfoViewController" bundle:nil];
    mainvc.dict=[_tittlearr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.36;
}
-(void) remark :(UIButton*)btn
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-150, 300,250)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
    [topButton setTitle:@"Update Remark" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];

    _statustxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,50, 280,40)];
    _statustxt.textAlignment=NSTextAlignmentLeft;
    _statustxt.delegate = self;
    _statustxt.textColor=[UIColor blackColor];
    [_statustxt setBackgroundColor:[UIColor clearColor]];
    _statustxt.leftViewMode = UITextFieldViewModeAlways;
    [_statustxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _statustxt.returnKeyType=UIReturnKeyDone;
    _statustxt.selectedLineColor = [UIColor redColor];
    _statustxt.selectedPlaceHolderColor = [UIColor redColor];
    _statustxt.placeHolderColor = [UIColor grayColor];
    _statustxt.font = [UIFont systemFontOfSize:14];
    _statustxt.placeholder=@"Status";
    [demoView addSubview:_statustxt];
    NSMutableArray * purposearr=[[NSMutableArray alloc]initWithObjects:@"Under Follow Up",@"Ready to Process Loan",@"Ready to Pay",@"Need Management Approva",@"Want to Cancel",@"Loan Issue",@"Non Cooperating",@"Not Contactable",@"Possession Issue",@"Other Issues", nil];
   DownPicker* purposedropdown = [[DownPicker alloc] initWithTextField:_statustxt withData:purposearr];
    [purposedropdown setPlaceholderWhileSelecting:@"Status"];
    [purposedropdown showArrowImage:YES];
   // [purposedropdown addTarget:self action:@selector(dp_Selected:) forControlEvents:UIControlEventValueChanged];
    purposedropdown.placeholder=@"Status";
    [demoView addSubview:purposedropdown];
    
    _remarktxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,100, 280,40)];
    _remarktxt.textAlignment=NSTextAlignmentLeft;
    _remarktxt.delegate = self;
    _remarktxt.textColor=[UIColor blackColor];
    [_remarktxt setBackgroundColor:[UIColor clearColor]];
    _remarktxt.leftViewMode = UITextFieldViewModeAlways;
    [_remarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _remarktxt.returnKeyType=UIReturnKeyDone;
    _remarktxt.selectedLineColor = [UIColor redColor];
    _remarktxt.selectedPlaceHolderColor = [UIColor redColor];
    _remarktxt.placeHolderColor = [UIColor grayColor];
    _remarktxt.font = [UIFont systemFontOfSize:14];
    _remarktxt.placeholder=@"Remark";
    [demoView addSubview:_remarktxt];
    
    datetxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,150, 280,40)];
    datetxt.textAlignment=NSTextAlignmentLeft;
    datetxt.delegate = self;
    datetxt.textColor=[UIColor blackColor];
    [datetxt setBackgroundColor:[UIColor clearColor]];
    datetxt.leftViewMode = UITextFieldViewModeAlways;
    [datetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    datetxt.returnKeyType=UIReturnKeyDone;
    datetxt.selectedLineColor = [UIColor redColor];
    datetxt.selectedPlaceHolderColor = [UIColor redColor];
    datetxt.placeHolderColor = [UIColor grayColor];
    datetxt.font = [UIFont systemFontOfSize:14];
    datetxt.placeholder=@"Followup date";
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                               style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
    
    [numberToolbarzip sizeToFit];
    datetxt.inputView =datePicker;
    datetxt.inputAccessoryView = numberToolbarzip;
    
    [demoView addSubview:datetxt];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,200,125,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    cancelBtn.tag=5;
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    cancelBtn.layer.borderWidth = 0.5;
    [demoView addSubview:cancelBtn];
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,200,125,40)];
    [savebtn setTitle:@"Update" forState:UIControlStateNormal];
    savebtn.tag=btn.tag;
    [savebtn addTarget:self action:@selector(update:)
      forControlEvents:UIControlEventTouchUpInside];
    savebtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    [savebtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    savebtn.layer.borderColor = [UIColor grayColor].CGColor;
    savebtn.layer.borderWidth = 0.5;
    [demoView addSubview:savebtn];
    
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    [self.view addSubview:demoView];
}
-(void)update:(UIButton*)btn
{
    btn.enabled=false;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    
    CGRect screenRect=[[UIScreen mainScreen]bounds];
    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
    //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
    acttyindicator.color=[UIColor blackColor];
    [self.view addSubview:acttyindicator];
    [acttyindicator bringSubviewToFront:demoView];
    
    NSMutableDictionary * dict=[_tittlearr objectAtIndex:btn.tag];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
    [params setObject:[dict objectForKey:@"bknum"] forKey:@"bknum"];
    [params setObject:[dict objectForKey:@"emp_code"] forKey:@"emp_code"];
    [params setObject:_statustxt.text  forKey:@"status"];
    [params setObject:_remarktxt.text  forKey:@"sales_remark"];
    [params setObject:datetxt.text  forKey:@"follow_date"];
    [params setObject:@"getbooking" forKey:@"requestType"];

    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@bofficestatus.php?",[prefs objectForKey:@"Link"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [acttyindicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
                    NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                                  length:[responseObject length] encoding: NSUTF8StringEncoding];
                    NSLog(@"Data= %@",content);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Saved"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self closeAlert:0];
        [acttyindicator stopAnimating];
        [self getdata];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [acttyindicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)closeAlert:(id)sender{
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    demoView.hidden=YES;
    [_remarktxt resignFirstResponder];
    [bgview removeFromSuperview];
}
-(void)openurl:(UIButton*)btn
{
    NSMutableDictionary * dict=[_tittlearr objectAtIndex:btn.tag];
    NSString * str;
    if ([btn.titleLabel.text isEqualToString:@"Call1"]) {
        str=[dict objectForKey:@"mobile1"];
    }
    else   if ([btn.titleLabel.text isEqualToString:@"Call2"]) {
        str=[dict objectForKey:@"mobile2"];
    }
    else
        str=[dict objectForKey:@"mobile3"];
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dict objectForKey:@"phone_mobile"]]]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"xrbia"  forKey:@"userName"];
    [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
    [params setObject:str forKey:@"custNumber"];
    [params setObject:[prefs objectForKey:@"user_name"] forKey:@"phoneName"];
    [params setObject:[prefs objectForKey:@"did_no"] forKey:@"did"];
    [params setObject:@"1000" forKey:@"callLimit"];
    [params setObject:@"sap_test" forKey:@"uui"];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        
        if ([[userDict objectForKey:@"status"]isEqualToString:@"queued"]) {
            [self savedata:dict:[userDict objectForKey:@"message"]:str];
        }
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"status"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)savedata:(NSMutableDictionary*)dict :(NSString*)message :(NSString*) mobile
{

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
    [params setObject:@"backoffice" forKey:@"module"];
    [params setObject:mobile forKey:@"mobile"];
    [params setObject:[dict objectForKey:@"name1"] forKey:@"name"];
    [params setObject:[dict objectForKey:@"proj_name"] forKey:@"projectname"];
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"userid"];
    [params setObject:datetxt.text forKey:@"date"];
    [params setObject:@"" forKey:@"message"];
    [params setObject:@"queued" forKey:@"status"];
    //
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        if ([[userDict objectForKey:@"status"]intValue] ==1) {
            
        }
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==_remarktxt) {
        if( textField.text.length>25)
            return NO;
    }
       return YES;
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.datetxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    datetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    [datetxt resignFirstResponder];
}

-(IBAction)cancelBtnpress{
    [datetxt resignFirstResponder];
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
