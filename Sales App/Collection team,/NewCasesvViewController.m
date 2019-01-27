//
//  NewCasesvViewController.m
//  Sales App
//
//  Created by Infinitum on 25/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "NewCasesvViewController.h"
#import "UIColor+Expanded.h"
#import "DocumentsViewController.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"
@interface NewCasesvViewController ()

@end
@implementation NewCasesvViewController
@synthesize tableViewHome,TakePhotoView,statustxt,downPicker,indicator,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=_str;
    if (_str==nil) {
        horizontallbl.text=appDelegate.comestr;
    }
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    SWRevealViewController *revealController = [self revealViewController];
    //   [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE5D2" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewHome.scrollEnabled=YES;
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
      if (_statusstr!=nil) {
          NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:_statusstr  forKey:@"status1"];
        [params setObject:_groupstr  forKey:@"groupname"];
        [params setObject:[prefs objectForKey:@"user_name"] forKey:@"username"];
        [params setObject:_rowstr  forKey:@"row"];
        [params setObject:_columnstr  forKey:@"column"];

          // NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getcustomerlist.php?";
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getcustomerdata.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            _teamarr=[[NSMutableArray alloc]init];
            _teamarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", _teamarr);
            [indicator stopAnimating];
            [tableViewHome reloadData];
            if (_teamarr.count==0) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No records found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
   else
   {
       NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
       AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
       [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
       [params setObject:@"getCustomers"  forKey:@"requestType"];

       if ([appDelegate.comestr isEqualToString:@"Todays Followup"]) {
           [params setObject:@"T"  forKey:@"ip_check"];
       }
       if ([appDelegate.comestr isEqualToString:@"Missed Followup"]) {
           [params setObject:@"M"  forKey:@"ip_check"];
       }
       
       // NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getcustomerlist.php?";
       NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getcustomerlist.php?",[prefs objectForKey:@"Link"]];
       [indicator startAnimating];
       [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
           _teamarr=[[NSMutableArray alloc]init];
           _teamarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
           NSLog(@"JSON: %@", _teamarr);
           [indicator stopAnimating];
           [tableViewHome reloadData];
       } failure:^(NSURLSessionTask *operation, NSError *error) {
           NSLog(@"Error: %@", error);
           [indicator stopAnimating];
           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
       }];
   }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _teamarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict=[_teamarr objectAtIndex:indexPath.row];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.43)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];

    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.005,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Customer Name"];
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  projectlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    projectlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    projectlbl.textAlignment = NSTextAlignmentLeft;
    projectlbl.text =[dict objectForKey:@"name1"];
    projectlbl.backgroundColor = [UIColor clearColor];
    projectlbl.textColor=[UIColor blackColor];
    projectlbl.lineBreakMode = NSLineBreakByWordWrapping;
    projectlbl.numberOfLines = 0;
    
    [headerView addSubview:projectlbl];
    UILabel*  Unitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.005,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    Unitlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    Unitlbl.textAlignment = NSTextAlignmentLeft;
    Unitlbl.text =[NSString stringWithFormat:@"Project name"];
    Unitlbl.backgroundColor = [UIColor clearColor];
    Unitlbl.textColor=[UIColor blackColor];
    Unitlbl.lineBreakMode = NSLineBreakByWordWrapping;
    Unitlbl.numberOfLines = 0;
    [headerView addSubview:Unitlbl];
    
    UILabel*  unit2lbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    unit2lbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    unit2lbl.textAlignment = NSTextAlignmentLeft;
    unit2lbl.text =[dict objectForKey:@"proj_name"];
    unit2lbl.backgroundColor = [UIColor clearColor];
    unit2lbl.textColor=[UIColor blackColor];
    unit2lbl.lineBreakMode = NSLineBreakByWordWrapping;
    unit2lbl.numberOfLines = 0;
    [headerView addSubview:unit2lbl];
    
    UILabel*  tottalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.075,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    tottalbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    tottalbl.textAlignment = NSTextAlignmentLeft;
    tottalbl.text =[NSString stringWithFormat:@"Unit No"];
    tottalbl.backgroundColor = [UIColor clearColor];
    tottalbl.textColor=[UIColor blackColor];
    tottalbl.lineBreakMode = NSLineBreakByWordWrapping;
    tottalbl.numberOfLines = 0;
    [headerView addSubview:tottalbl];
    
    UILabel*  totalcoll2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.11,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    totalcoll2.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    totalcoll2.textAlignment = NSTextAlignmentLeft;
    totalcoll2.text =[dict objectForKey:@"unit_no"];
    totalcoll2.backgroundColor = [UIColor clearColor];
    totalcoll2.textColor=[UIColor blackColor];
    totalcoll2.lineBreakMode = NSLineBreakByWordWrapping;
    totalcoll2.numberOfLines = 0;
    [headerView addSubview:totalcoll2];
    
    UILabel*  balancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.075,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    balancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    balancelbl.textAlignment = NSTextAlignmentLeft;
    balancelbl.text =[NSString stringWithFormat:@"Assign date"];
    balancelbl.backgroundColor = [UIColor clearColor];
    balancelbl.textColor=[UIColor blackColor];
    balancelbl.lineBreakMode = NSLineBreakByWordWrapping;
    balancelbl.numberOfLines = 0;
    [headerView addSubview:balancelbl];
  
    UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.11,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    balancelbl2.textAlignment = NSTextAlignmentLeft;
    balancelbl2.text =[self formatdate:[dict objectForKey:@"assigned_date"]];
    balancelbl2.backgroundColor = [UIColor clearColor];
    balancelbl2.textColor=[UIColor blackColor];
    balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
    balancelbl2.numberOfLines = 0;
    [headerView addSubview:balancelbl2];

    UILabel*  reqlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.145,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    reqlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    reqlbl.textAlignment = NSTextAlignmentLeft;
    reqlbl.text =[NSString stringWithFormat:@"Loan required Amount"];
    reqlbl.backgroundColor = [UIColor clearColor];
    reqlbl.textColor=[UIColor blackColor];
    reqlbl.lineBreakMode = NSLineBreakByWordWrapping;
    reqlbl.numberOfLines = 0;
    [headerView addSubview:reqlbl];
    
    UILabel*  reqlbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.18,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    reqlbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    reqlbl1.textAlignment = NSTextAlignmentLeft;
    reqlbl1.text =[dict objectForKey:@"loan_required"];
    reqlbl1.backgroundColor = [UIColor clearColor];
    reqlbl1.lineBreakMode = NSLineBreakByWordWrapping;
    reqlbl1.numberOfLines = 0;
    [headerView addSubview:reqlbl1];
    
    UILabel*  baclbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.145,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    baclbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    baclbl.textAlignment = NSTextAlignmentLeft;
    baclbl.text =[NSString stringWithFormat:@"Followup Date"];
    baclbl.backgroundColor = [UIColor clearColor];
    baclbl.textColor=[UIColor blackColor];
    baclbl.lineBreakMode = NSLineBreakByWordWrapping;
    baclbl.numberOfLines = 0;
    [headerView addSubview:baclbl];
    
    UILabel*  baclbalance2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.18,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    baclbalance2.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    baclbalance2.textAlignment = NSTextAlignmentLeft;
    baclbalance2.text =[self formatdate:[dict objectForKey:@"fu_date"]];
    baclbalance2.backgroundColor = [UIColor clearColor];
    baclbalance2.textColor=[UIColor blackColor];
    baclbalance2.lineBreakMode = NSLineBreakByWordWrapping;
    baclbalance2.numberOfLines = 0;
    [headerView addSubview:baclbalance2];

    UILabel* statuslbl  = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.215,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    statuslbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    statuslbl.textAlignment = NSTextAlignmentLeft;
    statuslbl.text =[NSString stringWithFormat:@"Status"];
    statuslbl.backgroundColor = [UIColor clearColor];
    statuslbl.textColor=[UIColor blackColor];
    statuslbl.lineBreakMode = NSLineBreakByWordWrapping;
    statuslbl.numberOfLines = 0;
    [headerView addSubview:statuslbl];

    UILabel*  statuslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.25,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    statuslbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    statuslbl2.textAlignment = NSTextAlignmentLeft;
    statuslbl2.text =[dict objectForKey:@"status1"];
    statuslbl2.backgroundColor = [UIColor clearColor];
    statuslbl2.textColor=[UIColor blackColor];
    statuslbl2.lineBreakMode = NSLineBreakByWordWrapping;
    statuslbl2.numberOfLines = 0;
    [headerView addSubview:statuslbl2];
    
    UILabel*  custmobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.215,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    custmobilelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    custmobilelbl.textAlignment = NSTextAlignmentLeft;
    custmobilelbl.text =[NSString stringWithFormat:@"Customer mobile"];
    custmobilelbl.backgroundColor = [UIColor clearColor];
    custmobilelbl.textColor=[UIColor blackColor];
    custmobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    custmobilelbl.numberOfLines = 0;
    [headerView addSubview:custmobilelbl];
    
    UIButton *callbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.25,screenRect.size.width*0.05,screenRect.size.height*0.035)];
    [callbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    callbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    callbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:15];
    [callbtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:callbtn];
    
    UIButton *call1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.50,screenRect.size.height*0.25,screenRect.size.width*0.35,screenRect.size.height*.04)];
    [call1 setBackgroundColor:[UIColor clearColor]];
    [call1 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    [call1 setTitle:[dict objectForKey:@"mobile"] forState:UIControlStateNormal];
    [call1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    call1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont* font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    call1.titleLabel.font=font;
    [headerView addSubview:call1];
    
    UILabel* ggvaluelbl  = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.285,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    ggvaluelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    ggvaluelbl.textAlignment = NSTextAlignmentLeft;
    ggvaluelbl.text =[NSString stringWithFormat:@"Ag. value"];
    ggvaluelbl.backgroundColor = [UIColor clearColor];
    ggvaluelbl.textColor=[UIColor blackColor];
    ggvaluelbl.lineBreakMode = NSLineBreakByWordWrapping;
    ggvaluelbl.numberOfLines = 0;
    [headerView addSubview:ggvaluelbl];
    
    UILabel*  ggvaluelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.32,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    ggvaluelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    ggvaluelbl2.textAlignment = NSTextAlignmentLeft;
    ggvaluelbl2.text =[dict objectForKey:@"agvalue"];
    ggvaluelbl2.backgroundColor = [UIColor clearColor];
    ggvaluelbl2.textColor=[UIColor blackColor];
    ggvaluelbl2.lineBreakMode = NSLineBreakByWordWrapping;
    ggvaluelbl2.numberOfLines = 0;
    [headerView addSubview:ggvaluelbl2];
    
    UILabel*  custmobilelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.285,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    custmobilelbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    custmobilelbl2.textAlignment = NSTextAlignmentLeft;
    custmobilelbl2.text =[NSString stringWithFormat:@"Customer mobile2"];
    custmobilelbl2.backgroundColor = [UIColor clearColor];
    custmobilelbl2.textColor=[UIColor blackColor];
    custmobilelbl2.lineBreakMode = NSLineBreakByWordWrapping;
    custmobilelbl2.numberOfLines = 0;
    [headerView addSubview:custmobilelbl2];
    
    UIButton *call2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.50,screenRect.size.height*0.32,screenRect.size.width*0.35,screenRect.size.height*.04)];
    [call2 setBackgroundColor:[UIColor clearColor]];
    [call2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    [call2 setTitle:[dict objectForKey:@"mobile2"] forState:UIControlStateNormal];
    [call2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    call2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    call2.titleLabel.font=font;
    [headerView addSubview:call2];
    
    UIButton *callbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.45,screenRect.size.height*0.32,screenRect.size.width*0.05,screenRect.size.height*.04)];
    [callbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    callbtn2.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    callbtn2.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:15];
    [callbtn2 setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:callbtn2];
    
    UILabel*  custmobilelbl3 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.355,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    custmobilelbl3.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    custmobilelbl3.textAlignment = NSTextAlignmentLeft;
    custmobilelbl3.text =[NSString stringWithFormat:@"Customer mobile3"];
    custmobilelbl3.backgroundColor = [UIColor clearColor];
    custmobilelbl3.textColor=[UIColor blackColor];
    custmobilelbl3.lineBreakMode = NSLineBreakByWordWrapping;
    custmobilelbl3.numberOfLines = 0;
    [headerView addSubview:custmobilelbl3];
    
    UIButton *call3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.50,screenRect.size.height*0.39,screenRect.size.width*0.35,screenRect.size.height*.04)];
    [call3 setBackgroundColor:[UIColor clearColor]];
    [call3 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    [call3 setTitle:[dict objectForKey:@"mobile3"] forState:UIControlStateNormal];
    [call3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    call3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    call3.titleLabel.font=font;
    [headerView addSubview:call3];
    
    UIButton *callbtn3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.45,screenRect.size.height*0.39,screenRect.size.width*0.05,screenRect.size.height*.04)];
    [callbtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    callbtn3.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    callbtn3.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:15];
    [callbtn3 setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:callbtn3];
    
    UILabel* salesmobilelbl  = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.355,screenRect.size.width*0.39,screenRect.size.height*0.04)];
    salesmobilelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    salesmobilelbl.textAlignment = NSTextAlignmentLeft;
    salesmobilelbl.text =[NSString stringWithFormat:@"Sales Mobile"];
    salesmobilelbl.backgroundColor = [UIColor clearColor];
    salesmobilelbl.textColor=[UIColor blackColor];
    salesmobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    salesmobilelbl.numberOfLines = 0;
    [headerView addSubview:salesmobilelbl];

    UILabel*  salesmobilelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.39,screenRect.size.width*0.39,screenRect.size.height*0.035)];
    salesmobilelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.030];
    salesmobilelbl2.textAlignment = NSTextAlignmentLeft;
    salesmobilelbl2.text =[dict objectForKey:@"sales_employee_no"];
    salesmobilelbl2.backgroundColor = [UIColor clearColor];
    salesmobilelbl2.textColor=[UIColor blackColor];
    salesmobilelbl2.lineBreakMode = NSLineBreakByWordWrapping;
    salesmobilelbl2.numberOfLines = 0;
    [headerView addSubview:salesmobilelbl2];
    
    if (_statusstr==nil) {
        projectlbl.text =[dict objectForKey:@"NAME1"];
        unit2lbl.text =[dict objectForKey:@"PROJ_NAME"];
        totalcoll2.text =[dict objectForKey:@"UNIT_NO"];
        balancelbl2.text =[self formatdate:[dict objectForKey:@"ASSIGNED_DATE"]];
        reqlbl1.text =[dict objectForKey:@"LOAN_REQUIRED"];
        baclbalance2.text =[self formatdate:[dict objectForKey:@"FU_DATE"]];
        statuslbl2.text =[dict objectForKey:@"STATUS1"];
        [call1 setTitle:[dict objectForKey:@"MOBILE"] forState:UIControlStateNormal];
        ggvaluelbl2.text =[dict objectForKey:@"AGVALUE"];
        [call2 setTitle:[dict objectForKey:@"MOBILE2"] forState:UIControlStateNormal];
        [call3 setTitle:[dict objectForKey:@"MOBILE3"] forState:UIControlStateNormal];
 salesmobilelbl2.text =[dict objectForKey:@"SALES_EMPLOYEE_NO"];
    }
    
    
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

    DocumentsViewController *mainvc=[[DocumentsViewController alloc] initWithNibName:@"DocumentsViewController" bundle:nil];
    if (_statusstr!=nil)
    {
    mainvc.comstr=[[_teamarr objectAtIndex:indexPath.row]objectForKey:@"id"];
        mainvc.groupstr=_groupstr;
    }
    else
    {
        mainvc.comstr=[[_teamarr objectAtIndex:indexPath.row]objectForKey:@"ID"];
        mainvc.groupstr=@"OTHERS";
    }


    [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.44;
}
-(void)openurl:(UIButton*)btn
{
    NSString *phoneNumber = [@"tel://" stringByAppendingString:btn.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
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
    
    statustxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 50, 280, 50)];
    statustxt.textAlignment=NSTextAlignmentLeft;
    statustxt.delegate = self;
    statustxt.textColor=[UIColor blackColor];
    [statustxt setBackgroundColor:[UIColor clearColor]];
    statustxt.leftViewMode = UITextFieldViewModeAlways;
    [statustxt setKeyboardType:UIKeyboardTypeEmailAddress];
    statustxt.returnKeyType=UIReturnKeyDone;
    [demoView addSubview:statustxt];

    
    NSMutableArray* bandArray = [[NSMutableArray alloc] initWithObjects:@"Sanctioned",@"Partially Sanction",@"conditional sanction",@"Decline", nil];
    [downPicker setPlaceholder:@"Country"];
    [demoView addSubview:statustxt];

    downPicker = [[DownPicker alloc] initWithTextField:statustxt withData:bandArray];
    [downPicker setPlaceholderWhileSelecting:@"Country"];
    [downPicker addTarget:self action:@selector(dp_Selected:)
         forControlEvents:UIControlEventValueChanged];
    statustxt.placeholder=@"Update Status";
    [downPicker showArrowImage:YES];
    // [self.downPicker setData:array]
    
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
    [okbtn addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
    [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    okbtn.tag=1;
    [okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:okbtn];
    return demoView;
}
-(NSString*)formatdate:(NSString *)str
{
    if (![str isEqualToString:@"00000000"]) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        if (str!=nil)
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       else
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        
        NSDate *dateFromString = [dateFormatter dateFromString:str];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
        return stringDate;
    }
    else
    {
        return @"";
    }
}
-(void)dp_Selected:(DownPicker*)dp {
    NSString* selectedValue = [dp text];
    
    // do what you want
}

-(void)closeAlert:(id)sender{
    [TakePhotoView close];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
