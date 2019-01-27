//
//  OCRViewController.m
//  Sales App
//
//  Created by Infinitum on 10/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "OCRViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"
@interface OCRViewController ()

@end

@implementation OCRViewController
@synthesize tableViewHome,indicator,bgview,demoView,projectpicker,projectoolbar,projectstr,projectarr,projectstxt,bookingarr,teamtableview,backgroundview,remarktxt,TakePhotoView,scrollview,segmentedControl,searchview,totalarr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    SWRevealViewController *revealController = [self revealViewController];
    //    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE5D2" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UIButton* emailbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.90,screenRect.size.height*0.03,screenRect.size.width*.1,screenRect.size.height*.07)];
    [emailbtn addTarget:self action:@selector(email) forControlEvents:UIControlEventTouchUpInside];
    [emailbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [emailbtn.titleLabel setFont:customFontdregs];
    [emailbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:emailbtn];;
    [emailbtn setImage:[UIImage imageNamed:@"email.png"] forState:UIControlStateNormal];
    
    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [filtbtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [filtbtn setTitle:@"\uE8B6" forState:UIControlStateNormal];
    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filtbtn.titleLabel setFont:customFontdregs];
    [filtbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:filtbtn];
    
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];

    if ([_comestr isEqualToString:@"ESC"]) {
        horizontallbl.text=@"ESC";
    }
    if ([_comestr isEqualToString:@"handover"]) {
        horizontallbl.text=@"Handover";
        emailbtn.hidden=YES;
        
    }if ([_comestr isEqualToString:@"performance"]) {
        horizontallbl.text=@"Performance";
        emailbtn.hidden=YES;
        filtbtn.hidden=YES;
    }
    
   backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UIButton *filterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.03,screenRect.size.width*0.15,screenRect.size.height*0.07)];
    filterbtn.layer.cornerRadius = 4.0f;
    [filterbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [filterbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    filterbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [filterbtn addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
    [filterbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [filterbtn setTitle:@"Filter" forState:UIControlStateNormal];
    //   [self.view addSubview:filterbtn];
    
    NSArray *itemArray;
    if ([_comestr isEqualToString:@"performance"])
    {
        itemArray = [NSArray arrayWithObjects: @"My", @"Team", nil];
    }
    if ([_comestr isEqualToString:@"ESC"]||[_comestr isEqualToString:@"handover"]) {
        itemArray = [NSArray arrayWithObjects: @"My", @"Team", nil];
        tableViewHome = [[UITableView alloc] init];
        [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89)];
        tableViewHome.backgroundColor=[UIColor clearColor];
        tableViewHome.delegate = self;
        tableViewHome.dataSource = self;
        tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableViewHome];
    }
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Sales Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
     
       segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.12, screenRect.size.width*0.80,screenRect.size.height*0.05);
        [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 0;
        [self.view addSubview:segmentedControl];
      
            teamtableview = [[UIScrollView alloc] init];
            [teamtableview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.20, screenRect.size.width,screenRect.size.height*.79)];
            teamtableview.backgroundColor=[UIColor clearColor];
            teamtableview.delegate = self;
            [self.view addSubview:teamtableview];
            teamtableview.hidden=YES;
        
        if ([_comestr isEqualToString:@"ESC"])
        {
            [self generateESCteam];
            tableViewHome.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.19, screenRect.size.width,screenRect.size.height*.79);
            
        }
        if ([_comestr isEqualToString:@"performance"])
        {
            tableViewHome.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.19, screenRect.size.width,screenRect.size.height*.79);
        }
        if ([_comestr isEqualToString:@"handover"])
        {
            segmentedControl.hidden=YES;
            tableViewHome.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89);
            
        }
        
    }
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}
-(void)email
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
 UIActivityIndicatorView *  actyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actyindicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    actyindicator.color=[UIColor colorWithHexString:@"#004c00"];
    actyindicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:actyindicator];
    [actyindicator bringSubviewToFront:self.view];
    actyindicator.layer.cornerRadius=15.0f;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
    
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Sales Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {

        [params setObject:@"esc_header"  forKey:@"table_name"];
        [params setObject:@"mg_empcode"  forKey:@"field_name"];
    }
    else
    {
        [params setObject:@"bac_details"  forKey:@"table_name"];
        [params setObject:@"esc_from_id"  forKey:@"field_name"];
    }
    
    [actyindicator startAnimating];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString*   urlString = @"http://13.126.129.245/xrbia/mobilecrm/sales/sendTableData.php";
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                      length:[responseObject length] encoding: NSUTF8StringEncoding];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:content delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        NSLog(@"content %@",content);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        [actyindicator stopAnimating];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [actyindicator stopAnimating];
    }];
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        tableViewHome.hidden=NO;
        teamtableview.hidden=YES;
        backgroundview.hidden=NO;
        scrollview.hidden=NO;
    }
    if(segment.selectedSegmentIndex == 1)
    {
        // code for the first button
        tableViewHome.hidden=YES;
        teamtableview.hidden=NO;
        backgroundview.hidden=YES;
        scrollview.hidden=YES;
        [self getteamlist];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getlist];
}
-(void)search
{
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    searchview=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:searchview];
    searchview.backgroundColor = [UIColor whiteColor];
    _searchtext=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.03,screenRect.size.width*0.80,screenRect.size.height*0.07)];
    _searchtext.placeholder=@"Search projects here...";
    _searchtext.delegate=self;
    [searchview addSubview:_searchtext];
    [_searchtext becomeFirstResponder];
    [self.view addSubview:searchview];
    
    UIButton* backbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbtn.titleLabel setFont:customFontdregs];
    [backbtn setBackgroundColor:[UIColor clearColor]];
    [searchview addSubview:backbtn];
}
-(void)back
{
    [searchview removeFromSuperview];
    bookingarr=[[NSMutableArray alloc]init];
    [bookingarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
}
-(void)createview
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSMutableDictionary *dict=[bookingarr objectAtIndex:0];
    scrollview = [[UIScrollView alloc] init];
    [scrollview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.18, screenRect.size.width,screenRect.size.height*.82)];
    scrollview.backgroundColor=[UIColor clearColor];
    scrollview.delegate = self;
    scrollview.bounces = NO;
    [self.view addSubview:scrollview];
    {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15,0,screenRect.size.width*0.70,screenRect.size.height*0.21)];
    headerView.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.70,screenRect.size.height*0.05)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
    Srnolbl.textAlignment = NSTextAlignmentCenter;
    Srnolbl.text = @"Monthly";
    Srnolbl.backgroundColor = [UIColor lightGrayColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [[Srnolbl layer] setBorderWidth:1.0f];
    [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:Srnolbl];
    
    UILabel*  leadlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    leadlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    leadlbl.textAlignment = NSTextAlignmentLeft;
    leadlbl.text = @"Lead";
    leadlbl.backgroundColor = [UIColor clearColor];
    leadlbl.textColor=[UIColor blackColor];
    leadlbl.lineBreakMode = NSLineBreakByWordWrapping;
    leadlbl.numberOfLines = 0;
    [headerView addSubview:leadlbl];
    
    UILabel*  leadlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.05,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    leadlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    leadlbl2.textAlignment = NSTextAlignmentRight;
    leadlbl2.text = [dict objectForKey:@"m_lead"];
    leadlbl2.backgroundColor = [UIColor clearColor];
    leadlbl2.textColor=[UIColor blackColor];
    leadlbl2.lineBreakMode = NSLineBreakByWordWrapping;
    leadlbl2.numberOfLines = 0;
//    [[leadlbl2 layer] setBorderWidth:1.0f];
//    [[leadlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:leadlbl2];
    
    UILabel*  bookinglbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.085,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    bookinglbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    bookinglbl.textAlignment = NSTextAlignmentLeft;
    bookinglbl.text = @"Booking";
    bookinglbl.backgroundColor = [UIColor clearColor];
    bookinglbl.textColor=[UIColor blackColor];
    bookinglbl.lineBreakMode = NSLineBreakByWordWrapping;
    bookinglbl.numberOfLines = 0;
//    [[bookinglbl layer] setBorderWidth:1.0f];
//    [[bookinglbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:bookinglbl];
    
    UILabel*  bookinglbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.085,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    bookinglbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    bookinglbl2.textAlignment = NSTextAlignmentRight;
    bookinglbl2.text = [dict objectForKey:@"m_booking"];
    bookinglbl2.backgroundColor = [UIColor clearColor];
    bookinglbl2.textColor=[UIColor blackColor];
    bookinglbl2.lineBreakMode = NSLineBreakByWordWrapping;
    bookinglbl2.numberOfLines = 0;
//    [[bookinglbl2 layer] setBorderWidth:1.0f];
//    [[bookinglbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:bookinglbl2];
    
    UILabel*  arvalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    arvalbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    arvalbl.textAlignment = NSTextAlignmentLeft;
    arvalbl.text = @"Agr. value";
    arvalbl.backgroundColor = [UIColor clearColor];
    arvalbl.textColor=[UIColor blackColor];
    arvalbl.lineBreakMode = NSLineBreakByWordWrapping;
    arvalbl.numberOfLines = 0;
//    [[arvalbl layer] setBorderWidth:1.0f];
//    [[arvalbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:arvalbl];
    
    UILabel*  arvalbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.12,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    arvalbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    arvalbl2.textAlignment = NSTextAlignmentRight;
    arvalbl2.text = [dict objectForKey:@"m_agvalue"];
    arvalbl2.backgroundColor = [UIColor clearColor];
    arvalbl2.textColor=[UIColor blackColor];
    arvalbl2.lineBreakMode = NSLineBreakByWordWrapping;
    arvalbl2.numberOfLines = 0;
//    [[arvalbl2 layer] setBorderWidth:1.0f];
//    [[arvalbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:arvalbl2];
    
    UILabel*  converlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.155,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    converlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    converlbl.textAlignment = NSTextAlignmentLeft;
    converlbl.text = @"Conversion ratio";
    converlbl.backgroundColor = [UIColor clearColor];
    converlbl.textColor=[UIColor blackColor];
    converlbl.lineBreakMode = NSLineBreakByWordWrapping;
    converlbl.numberOfLines = 0;
//    [[converlbl layer] setBorderWidth:1.0f];
//    [[converlbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:converlbl];
   
    UILabel*  converlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.155,screenRect.size.width*0.33,screenRect.size.height*0.035)];
    converlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    converlbl2.textAlignment = NSTextAlignmentRight;
    converlbl2.text = [dict objectForKey:@"m_con_ratio"];
    converlbl2.backgroundColor = [UIColor clearColor];
    converlbl2.textColor=[UIColor blackColor];
    converlbl2.lineBreakMode = NSLineBreakByWordWrapping;
    converlbl2.numberOfLines = 0;
//    [[converlbl2 layer] setBorderWidth:1.0f];
//    [[converlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:converlbl2];
    
    UILabel*  mpslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.height*0.045)];
    mpslbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    mpslbl.textAlignment = NSTextAlignmentLeft;
    mpslbl.text = @" MPS %";
    mpslbl.backgroundColor = [UIColor lightGrayColor];
    mpslbl.textColor=[UIColor blackColor];
    mpslbl.lineBreakMode = NSLineBreakByWordWrapping;
    mpslbl.numberOfLines = 0;
//    [[mpslbl layer] setBorderWidth:1.0f];
//    [[mpslbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:mpslbl];
    
    UILabel*  mpslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.height*0.045)];
    mpslbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
    mpslbl2.textAlignment = NSTextAlignmentRight;
    mpslbl2.text = @"";
    mpslbl2.backgroundColor = [UIColor lightGrayColor];
    mpslbl2.textColor=[UIColor blackColor];
    mpslbl2.lineBreakMode = NSLineBreakByWordWrapping;
    mpslbl2.numberOfLines = 0;
//    [[mpslbl2 layer] setBorderWidth:1.0f];
//    [[mpslbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:mpslbl2];
    [scrollview addSubview:headerView];
        
}
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.28,screenRect.size.width*0.70,screenRect.size.height*0.21)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.70,screenRect.size.height*0.05)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = @"Quarterly";
        Srnolbl.backgroundColor = [UIColor lightGrayColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:1.0f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  leadlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        leadlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        leadlbl.textAlignment = NSTextAlignmentLeft;
        leadlbl.text = @"Lead";
        leadlbl.backgroundColor = [UIColor clearColor];
        leadlbl.textColor=[UIColor blackColor];
        leadlbl.lineBreakMode = NSLineBreakByWordWrapping;
        leadlbl.numberOfLines = 0;
        //    [[leadlbl layer] setBorderWidth:1.0f];
        //    [[leadlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:leadlbl];
        
        UILabel*  leadlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.05,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        leadlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        leadlbl2.textAlignment = NSTextAlignmentRight;
        leadlbl2.text =[dict objectForKey:@"q_lead"];
        leadlbl2.backgroundColor = [UIColor clearColor];
        leadlbl2.textColor=[UIColor blackColor];
        leadlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        leadlbl2.numberOfLines = 0;
        //    [[leadlbl2 layer] setBorderWidth:1.0f];
        //    [[leadlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:leadlbl2];
        
        
        UILabel*  bookinglbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.085,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        bookinglbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        bookinglbl.textAlignment = NSTextAlignmentLeft;
        bookinglbl.text = @"Booking";
        bookinglbl.backgroundColor = [UIColor clearColor];
        bookinglbl.textColor=[UIColor blackColor];
        bookinglbl.lineBreakMode = NSLineBreakByWordWrapping;
        bookinglbl.numberOfLines = 0;
        //    [[bookinglbl layer] setBorderWidth:1.0f];
        //    [[bookinglbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:bookinglbl];
        
        UILabel*  bookinglbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.085,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        bookinglbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        bookinglbl2.textAlignment = NSTextAlignmentRight;
        bookinglbl2.text =[dict objectForKey:@"q_booking"];
        bookinglbl2.backgroundColor = [UIColor clearColor];
        bookinglbl2.textColor=[UIColor blackColor];
        bookinglbl2.lineBreakMode = NSLineBreakByWordWrapping;
        bookinglbl2.numberOfLines = 0;
        //    [[bookinglbl2 layer] setBorderWidth:1.0f];
        //    [[bookinglbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:bookinglbl2];
        
        UILabel*  arvalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        arvalbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        arvalbl.textAlignment = NSTextAlignmentLeft;
        arvalbl.text = @"Agr. value";
        arvalbl.backgroundColor = [UIColor clearColor];
        arvalbl.textColor=[UIColor blackColor];
        arvalbl.lineBreakMode = NSLineBreakByWordWrapping;
        arvalbl.numberOfLines = 0;
        //    [[arvalbl layer] setBorderWidth:1.0f];
        //    [[arvalbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:arvalbl];
        
        UILabel*  arvalbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.12,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        arvalbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        arvalbl2.textAlignment = NSTextAlignmentRight;
        arvalbl2.text = [dict objectForKey:@"q_agvalue"];
        arvalbl2.backgroundColor = [UIColor clearColor];
        arvalbl2.textColor=[UIColor blackColor];
        arvalbl2.lineBreakMode = NSLineBreakByWordWrapping;
        arvalbl2.numberOfLines = 0;
        //    [[arvalbl2 layer] setBorderWidth:1.0f];
        //    [[arvalbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:arvalbl2];
        
        UILabel*  converlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.155,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        converlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        converlbl.textAlignment = NSTextAlignmentLeft;
        converlbl.text = @"Conversion ratio";
        converlbl.backgroundColor = [UIColor clearColor];
        converlbl.textColor=[UIColor blackColor];
        converlbl.lineBreakMode = NSLineBreakByWordWrapping;
        converlbl.numberOfLines = 0;
        //    [[converlbl layer] setBorderWidth:1.0f];
        //    [[converlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:converlbl];
        
        UILabel*  converlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.155,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        converlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        converlbl2.textAlignment = NSTextAlignmentRight;
        converlbl2.text =[dict objectForKey:@"q_con_ratio"];
        converlbl2.backgroundColor = [UIColor clearColor];
        converlbl2.textColor=[UIColor blackColor];
        converlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        converlbl2.numberOfLines = 0;
        //    [[converlbl2 layer] setBorderWidth:1.0f];
        //    [[converlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:converlbl2];
        
        UILabel*  mpslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.height*0.045)];
        mpslbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        mpslbl.textAlignment = NSTextAlignmentLeft;
        mpslbl.text = @" MPS %";
        mpslbl.backgroundColor = [UIColor lightGrayColor];
        mpslbl.textColor=[UIColor blackColor];
        mpslbl.lineBreakMode = NSLineBreakByWordWrapping;
        mpslbl.numberOfLines = 0;
        //    [[mpslbl layer] setBorderWidth:1.0f];
        //    [[mpslbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:mpslbl];
        
        UILabel*  mpslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.height*0.045)];
        mpslbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        mpslbl2.textAlignment = NSTextAlignmentRight;
        mpslbl2.text =@"";
        mpslbl2.backgroundColor = [UIColor lightGrayColor];
        mpslbl2.textColor=[UIColor blackColor];
        mpslbl2.lineBreakMode = NSLineBreakByWordWrapping;
        mpslbl2.numberOfLines = 0;
        //    [[mpslbl2 layer] setBorderWidth:1.0f];
        //    [[mpslbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:mpslbl2];
        [scrollview addSubview:headerView];
    }
    
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.56,screenRect.size.width*0.70,screenRect.size.height*0.26)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.70,screenRect.size.height*0.05)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = @"Cumulative";
        Srnolbl.backgroundColor = [UIColor lightGrayColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:1.0f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  leadlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        leadlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        leadlbl.textAlignment = NSTextAlignmentLeft;
        leadlbl.text = @"Lead";
        leadlbl.backgroundColor = [UIColor clearColor];
        leadlbl.textColor=[UIColor blackColor];
        leadlbl.lineBreakMode = NSLineBreakByWordWrapping;
        leadlbl.numberOfLines = 0;
        //    [[leadlbl layer] setBorderWidth:1.0f];
        //    [[leadlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:leadlbl];
        
        UILabel*  leadlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.05,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        leadlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        leadlbl2.textAlignment = NSTextAlignmentRight;
        leadlbl2.text =[dict objectForKey:@"y_lead"];
        leadlbl2.backgroundColor = [UIColor clearColor];
        leadlbl2.textColor=[UIColor blackColor];
        leadlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        leadlbl2.numberOfLines = 0;
        //    [[leadlbl2 layer] setBorderWidth:1.0f];
        //    [[leadlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:leadlbl2];
        
        UILabel*  bookinglbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.085,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        bookinglbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        bookinglbl.textAlignment = NSTextAlignmentLeft;
        bookinglbl.text = @"Booking";
        bookinglbl.backgroundColor = [UIColor clearColor];
        bookinglbl.textColor=[UIColor blackColor];
        bookinglbl.lineBreakMode = NSLineBreakByWordWrapping;
        bookinglbl.numberOfLines = 0;
        //    [[bookinglbl layer] setBorderWidth:1.0f];
        //    [[bookinglbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:bookinglbl];
        
        UILabel*  bookinglbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.085,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        bookinglbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        bookinglbl2.textAlignment = NSTextAlignmentRight;
        bookinglbl2.text =[dict objectForKey:@"y_booking"];
        bookinglbl2.backgroundColor = [UIColor clearColor];
        bookinglbl2.textColor=[UIColor blackColor];
        bookinglbl2.lineBreakMode = NSLineBreakByWordWrapping;
        bookinglbl2.numberOfLines = 0;
        //    [[bookinglbl2 layer] setBorderWidth:1.0f];
        //    [[bookinglbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:bookinglbl2];
        
        UILabel*  arvalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        arvalbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        arvalbl.textAlignment = NSTextAlignmentLeft;
        arvalbl.text = @"Agr. value";
        arvalbl.backgroundColor = [UIColor clearColor];
        arvalbl.textColor=[UIColor blackColor];
        arvalbl.lineBreakMode = NSLineBreakByWordWrapping;
        arvalbl.numberOfLines = 0;
        //    [[arvalbl layer] setBorderWidth:1.0f];
        //    [[arvalbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:arvalbl];
        
        UILabel*  arvalbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.12,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        arvalbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        arvalbl2.textAlignment = NSTextAlignmentRight;
        arvalbl2.text =[dict objectForKey:@"y_agvalue"];
        arvalbl2.backgroundColor = [UIColor clearColor];
        arvalbl2.textColor=[UIColor blackColor];
        arvalbl2.lineBreakMode = NSLineBreakByWordWrapping;
        arvalbl2.numberOfLines = 0;
        //    [[arvalbl2 layer] setBorderWidth:1.0f];
        //    [[arvalbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:arvalbl2];
        
        UILabel*  converlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.155,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        converlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        converlbl.textAlignment = NSTextAlignmentLeft;
        converlbl.text = @"Conversion ratio";
        converlbl.backgroundColor = [UIColor clearColor];
        converlbl.textColor=[UIColor blackColor];
        converlbl.lineBreakMode = NSLineBreakByWordWrapping;
        converlbl.numberOfLines = 0;
        //    [[converlbl layer] setBorderWidth:1.0f];
        //    [[converlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:converlbl];
        
        UILabel*  converlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.155,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        converlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        converlbl2.textAlignment = NSTextAlignmentRight;
        converlbl2.text =[dict objectForKey:@"y_con_ratio"];
        converlbl2.backgroundColor = [UIColor clearColor];
        converlbl2.textColor=[UIColor blackColor];
        converlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        converlbl2.numberOfLines = 0;
        //    [[converlbl2 layer] setBorderWidth:1.0f];
        //    [[converlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:converlbl2];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.19,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        datelbl.textAlignment = NSTextAlignmentLeft;
        datelbl.text = @"From date";
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        //    [[converlbl layer] setBorderWidth:1.0f];
        //    [[converlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:datelbl];
        
        UILabel*  datelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.19,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        datelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        datelbl2.textAlignment = NSTextAlignmentRight;
        datelbl2.text =[dict objectForKey:@"fromdate"];
        datelbl2.backgroundColor = [UIColor clearColor];
        datelbl2.textColor=[UIColor blackColor];
        datelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl2.numberOfLines = 0;
        //    [[converlbl2 layer] setBorderWidth:1.0f];
        //    [[converlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:datelbl2];
        
        UILabel*  todatedatelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.225,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        todatedatelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        todatedatelbl.textAlignment = NSTextAlignmentLeft;
        todatedatelbl.text = @"To date";
        todatedatelbl.backgroundColor = [UIColor clearColor];
        todatedatelbl.textColor=[UIColor blackColor];
        todatedatelbl.lineBreakMode = NSLineBreakByWordWrapping;
        todatedatelbl.numberOfLines = 0;
        //    [[converlbl layer] setBorderWidth:1.0f];
        //    [[converlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:todatedatelbl];
        
        UILabel*  todatedatelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.225,screenRect.size.width*0.33,screenRect.size.height*0.035)];
        todatedatelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        todatedatelbl2.textAlignment = NSTextAlignmentRight;
        todatedatelbl2.text =[dict objectForKey:@"todate"];
        todatedatelbl2.backgroundColor = [UIColor clearColor];
        todatedatelbl2.textColor=[UIColor blackColor];
        todatedatelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        todatedatelbl2.numberOfLines = 0;
        //    [[converlbl2 layer] setBorderWidth:1.0f];
        //    [[converlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:todatedatelbl2];
        
        UILabel*  mpslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.26,screenRect.size.width*0.35,screenRect.size.height*0.045)];
        mpslbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        mpslbl.textAlignment = NSTextAlignmentLeft;
        mpslbl.text = @" MPS %";
        mpslbl.backgroundColor = [UIColor lightGrayColor];
        mpslbl.textColor=[UIColor blackColor];
        mpslbl.lineBreakMode = NSLineBreakByWordWrapping;
        mpslbl.numberOfLines = 0;
        //    [[mpslbl layer] setBorderWidth:1.0f];
        //    [[mpslbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:mpslbl];
        
        UILabel*  mpslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.26,screenRect.size.width*0.35,screenRect.size.height*0.045)];
        mpslbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.040];
        mpslbl2.textAlignment = NSTextAlignmentRight;
        mpslbl2.text = @"";
        mpslbl2.backgroundColor = [UIColor lightGrayColor];
        mpslbl2.textColor=[UIColor blackColor];
        mpslbl2.lineBreakMode = NSLineBreakByWordWrapping;
        mpslbl2.numberOfLines = 0;
        //    [[mpslbl2 layer] setBorderWidth:1.0f];
        //    [[mpslbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:mpslbl2];
        [scrollview addSubview:headerView];
    }
    scrollview.contentSize = CGSizeMake(screenRect.size.width, screenRect.size.height*0.89);

}

-(void)performance
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*2.55,screenRect.size.height*0.07)];
    headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
    //    lineView2.backgroundColor = [UIColor grayColor];
    //    [headerView addSubview:lineView2];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentCenter;
    Srnolbl.text = @"Emp Name";
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [[Srnolbl layer] setBorderWidth:1.0f];
    [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:Srnolbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    namelbl.textAlignment = NSTextAlignmentCenter;
    namelbl.text = @"Location";
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    [[namelbl layer] setBorderWidth:1.0f];
    [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:namelbl];
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    datelbl.textAlignment = NSTextAlignmentCenter;
    datelbl.text = @"Monthly\nBooking";
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[datelbl layer] setBorderWidth:1.0f];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.80,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    cashlbl.textAlignment = NSTextAlignmentCenter;
    cashlbl.text = @"Monthly\n C.R.";
    cashlbl.backgroundColor = [UIColor clearColor];
    cashlbl.textColor=[UIColor blackColor];
    cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[cashlbl layer] setBorderWidth:1.0f];
    cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
    cashlbl.numberOfLines = 0;
    [headerView addSubview:cashlbl];
    
    UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.05,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    expencelbl.textAlignment = NSTextAlignmentCenter;
    expencelbl.text = @"Monthly \nagr. value";
    expencelbl.backgroundColor = [UIColor clearColor];
    expencelbl.textColor=[UIColor blackColor];
    expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[expencelbl layer] setBorderWidth:1.0f];
    expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
    expencelbl.numberOfLines = 0;
    [headerView addSubview:expencelbl];
    
    UILabel*  OCramt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.30,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    OCramt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    OCramt.textAlignment = NSTextAlignmentCenter;
    OCramt.text = @"Monthly\n MPS";
    OCramt.backgroundColor = [UIColor clearColor];
    OCramt.textColor=[UIColor blackColor];
    OCramt.lineBreakMode = NSLineBreakByWordWrapping;
    [[OCramt layer] setBorderWidth:1.0f];
    OCramt.lineBreakMode = NSLineBreakByWordWrapping;
    OCramt.numberOfLines = 0;
    [headerView addSubview:OCramt];
    
    UILabel*  bookingllbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.55,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    bookingllbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    bookingllbl.textAlignment = NSTextAlignmentCenter;
    bookingllbl.text = @"Quarterly\n Booking";
    bookingllbl.backgroundColor = [UIColor clearColor];
    bookingllbl.textColor=[UIColor blackColor];
    bookingllbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[bookingllbl layer] setBorderWidth:1.0f];
    bookingllbl.lineBreakMode = NSLineBreakByWordWrapping;
    bookingllbl.numberOfLines = 0;
    [headerView addSubview:bookingllbl];
    
    
    UILabel*  qconversion = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.80,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    qconversion.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    qconversion.textAlignment = NSTextAlignmentCenter;
    qconversion.text = @"Quarterly\n C.R.";
    qconversion.backgroundColor = [UIColor clearColor];
    qconversion.textColor=[UIColor blackColor];
    qconversion.lineBreakMode = NSLineBreakByWordWrapping;
    [[qconversion layer] setBorderWidth:1.0f];
    qconversion.lineBreakMode = NSLineBreakByWordWrapping;
    qconversion.numberOfLines = 0;
    [headerView addSubview:qconversion];
    
    UILabel*  qagvalue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*2.05,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    qagvalue.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    qagvalue.textAlignment = NSTextAlignmentCenter;
    qagvalue.text = @"Quarterly\nagr. value";
    qagvalue.backgroundColor = [UIColor clearColor];
    qagvalue.textColor=[UIColor blackColor];
    qagvalue.lineBreakMode = NSLineBreakByWordWrapping;
    [[qagvalue layer] setBorderWidth:1.0f];
    qagvalue.lineBreakMode = NSLineBreakByWordWrapping;
    qagvalue.numberOfLines = 0;
    [headerView addSubview:qagvalue];
    
    UILabel*  qmps = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*2.30,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    qmps.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    qmps.textAlignment = NSTextAlignmentCenter;
    qmps.text = @"Quarterly\n MPS";
    qmps.backgroundColor = [UIColor clearColor];
    qmps.textColor=[UIColor blackColor];
    qmps.lineBreakMode = NSLineBreakByWordWrapping;
    [[qmps layer] setBorderWidth:1.0f];
    qmps.lineBreakMode = NSLineBreakByWordWrapping;
    qmps.numberOfLines = 0;
    [headerView addSubview:qmps];
    [teamtableview addSubview:headerView];
    
    int hig=screenRect.size.height*0.07;
    for (int i=0; i<_teamarr.count; i++) {
        NSMutableDictionary *dict=[_teamarr objectAtIndex:i];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width*2.55,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor clearColor];
        [headerView addSubview:lineView];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = [dict objectForKey:@"emp_name"];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:1.0f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.20,screenRect.size.height*0.07)];
        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = [dict objectForKey:@"location"];
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [[namelbl layer] setBorderWidth:1.0f];
        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text =[dict objectForKey:@"m_booking"];
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[datelbl layer] setBorderWidth:1.0f];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.80,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text =[dict objectForKey:@"m_con_ratio"];
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl layer] setBorderWidth:1.0f];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.05,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = [dict objectForKey:@"m_agvalue"];
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[expencelbl layer] setBorderWidth:1.0f];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        
        UILabel*  OCramt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.30,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        OCramt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        OCramt.textAlignment = NSTextAlignmentCenter;
        OCramt.text = @"";
        OCramt.backgroundColor = [UIColor clearColor];
        OCramt.textColor=[UIColor blackColor];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        [[OCramt layer] setBorderWidth:1.0f];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        OCramt.numberOfLines = 0;
        [headerView addSubview:OCramt];
        
        UILabel*  bookingllbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.55,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        bookingllbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        bookingllbl.textAlignment = NSTextAlignmentCenter;
        bookingllbl.text =[dict objectForKey:@"q_booking"];
        bookingllbl.backgroundColor = [UIColor clearColor];
        bookingllbl.textColor=[UIColor blackColor];
        bookingllbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[bookingllbl layer] setBorderWidth:1.0f];
        bookingllbl.lineBreakMode = NSLineBreakByWordWrapping;
        bookingllbl.numberOfLines = 0;
        [headerView addSubview:bookingllbl];
        
        UILabel*  qconversion = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.80,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        qconversion.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        qconversion.textAlignment = NSTextAlignmentCenter;
        qconversion.text = [dict objectForKey:@"q_con_ratio"];
        qconversion.backgroundColor = [UIColor clearColor];
        qconversion.textColor=[UIColor blackColor];
        qconversion.lineBreakMode = NSLineBreakByWordWrapping;
        [[qconversion layer] setBorderWidth:1.0f];
        qconversion.lineBreakMode = NSLineBreakByWordWrapping;
        qconversion.numberOfLines = 0;
        [headerView addSubview:qconversion];
        
        UILabel*  qagvalue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*2.05,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        qagvalue.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        qagvalue.textAlignment = NSTextAlignmentCenter;
        qagvalue.text =[dict objectForKey:@"q_agvalue"];
        qagvalue.backgroundColor = [UIColor clearColor];
        qagvalue.textColor=[UIColor blackColor];
        qagvalue.lineBreakMode = NSLineBreakByWordWrapping;
        [[qagvalue layer] setBorderWidth:1.0f];
        qagvalue.lineBreakMode = NSLineBreakByWordWrapping;
        qagvalue.numberOfLines = 0;
        [headerView addSubview:qagvalue];
        
        
        UILabel*  qmps = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*2.3,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        qmps.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        qmps.textAlignment = NSTextAlignmentCenter;
        qmps.text =@"";
        qmps.backgroundColor = [UIColor clearColor];
        qmps.textColor=[UIColor blackColor];
        qmps.lineBreakMode = NSLineBreakByWordWrapping;
        [[qmps layer] setBorderWidth:1.0f];
        qmps.lineBreakMode = NSLineBreakByWordWrapping;
        qmps.numberOfLines = 0;
        [headerView addSubview:qmps];
        [teamtableview addSubview:headerView];
        
        hig=hig+screenRect.size.height*0.07;
    }
    teamtableview.contentSize = CGSizeMake(screenRect.size.width*2.55, hig);
}
-(void)generateESCteam
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*2.,screenRect.size.height*0.07)];
    headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
    //    lineView2.backgroundColor = [UIColor grayColor];
    //    [headerView addSubview:lineView2];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentCenter;
    Srnolbl.text = @"Emp Name";
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [[Srnolbl layer] setBorderWidth:1.0f];
    [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:Srnolbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
    namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    namelbl.textAlignment = NSTextAlignmentCenter;
    namelbl.text = @"Total\n Avg";
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    [[namelbl layer] setBorderWidth:1.0f];
    [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
    [headerView addSubview:namelbl];
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    datelbl.textAlignment = NSTextAlignmentCenter;
    datelbl.text = @"No of\ncases done";
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[datelbl layer] setBorderWidth:1.0f];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    cashlbl.textAlignment = NSTextAlignmentCenter;
    cashlbl.text = @"Avg cases\ndone";
    cashlbl.backgroundColor = [UIColor clearColor];
    cashlbl.textColor=[UIColor blackColor];
    cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[cashlbl layer] setBorderWidth:1.0f];
    cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
    cashlbl.numberOfLines = 0;
    [headerView addSubview:cashlbl];
    
    UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    expencelbl.textAlignment = NSTextAlignmentCenter;
    expencelbl.text = @"No of cases not done";
    expencelbl.backgroundColor = [UIColor clearColor];
    expencelbl.textColor=[UIColor blackColor];
    expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
    [[expencelbl layer] setBorderWidth:1.0f];
    expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
    expencelbl.numberOfLines = 0;
    [headerView addSubview:expencelbl];
    
    UILabel*  OCramt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.25,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    OCramt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    OCramt.textAlignment = NSTextAlignmentCenter;
    OCramt.text = @"Avg cases not done";
    OCramt.backgroundColor = [UIColor clearColor];
    OCramt.textColor=[UIColor blackColor];
    OCramt.lineBreakMode = NSLineBreakByWordWrapping;
    [[OCramt layer] setBorderWidth:1.0f];
    OCramt.lineBreakMode = NSLineBreakByWordWrapping;
    OCramt.numberOfLines = 0;
    [headerView addSubview:OCramt];
    
    UILabel*  nocasesc = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.5,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    nocasesc.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    nocasesc.textAlignment = NSTextAlignmentCenter;
    nocasesc.text = @"Avg cases not done";
    nocasesc.backgroundColor = [UIColor clearColor];
    nocasesc.textColor=[UIColor blackColor];
    nocasesc.lineBreakMode = NSLineBreakByWordWrapping;
    [[nocasesc layer] setBorderWidth:1.0f];
    nocasesc.lineBreakMode = NSLineBreakByWordWrapping;
    nocasesc.numberOfLines = 0;
    [headerView addSubview:nocasesc];
    
    UILabel*  avgcasesexc = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
    avgcasesexc.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    avgcasesexc.textAlignment = NSTextAlignmentCenter;
    avgcasesexc.text = @"Avg cases ESC";
    avgcasesexc.backgroundColor = [UIColor clearColor];
    avgcasesexc.textColor=[UIColor blackColor];
    avgcasesexc.lineBreakMode = NSLineBreakByWordWrapping;
    [[avgcasesexc layer] setBorderWidth:1.0f];
    avgcasesexc.lineBreakMode = NSLineBreakByWordWrapping;
    avgcasesexc.numberOfLines = 0;
    [headerView addSubview:avgcasesexc];
    [teamtableview addSubview:headerView];
    
   int hig=screenRect.size.height*0.07;
    for (int i=0; i<_teamarr.count; i++) {
        NSMutableDictionary *dict=[_teamarr objectAtIndex:i];
        NSMutableDictionary *mutableDict = [dict mutableCopy];
        for (NSString *key in [dict allKeys]) {
            if ([dict[key] isEqual:[NSNull null]]) {
                mutableDict[key] = @"";
            }
        }
        dict = [mutableDict copy];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width*2.,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor clearColor];
        [headerView addSubview:lineView];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = [dict objectForKey:@"sr_empname"];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:1.0f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text =[dict objectForKey:@"av_total_case"];
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [[namelbl layer] setBorderWidth:1.0f];
        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = [dict objectForKey:@"no_done_case"];
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[datelbl layer] setBorderWidth:1.0f];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        float value=[[dict objectForKey:@"bac_balance"]floatValue]+[[dict objectForKey:@"ocr_balance"]floatValue];
        cashlbl.text =[dict objectForKey:@"av_done_case"];
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl layer] setBorderWidth:1.0f];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = [dict objectForKey:@"no_tbd_case"];
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[expencelbl layer] setBorderWidth:1.0f];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        
        UILabel*  OCramt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.25,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        OCramt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        OCramt.textAlignment = NSTextAlignmentCenter;
        OCramt.text = [dict objectForKey:@"av_tbd_case"];
        OCramt.backgroundColor = [UIColor clearColor];
        OCramt.textColor=[UIColor blackColor];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        [[OCramt layer] setBorderWidth:1.0f];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        OCramt.numberOfLines = 0;
        [headerView addSubview:OCramt];
        [teamtableview addSubview:headerView];
        
        UILabel*  nocasesc = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.5,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        nocasesc.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        nocasesc.textAlignment = NSTextAlignmentCenter;
        nocasesc.text = [dict objectForKey:@"no_esc_case"];
        nocasesc.backgroundColor = [UIColor clearColor];
        nocasesc.textColor=[UIColor blackColor];
        nocasesc.lineBreakMode = NSLineBreakByWordWrapping;
        [[nocasesc layer] setBorderWidth:1.0f];
        nocasesc.lineBreakMode = NSLineBreakByWordWrapping;
        nocasesc.numberOfLines = 0;
        [headerView addSubview:nocasesc];
        
        UILabel*  avgcasesexc = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        avgcasesexc.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        avgcasesexc.textAlignment = NSTextAlignmentCenter;
        avgcasesexc.text = [dict objectForKey:@"av_esc_case"];
        avgcasesexc.backgroundColor = [UIColor clearColor];
        avgcasesexc.textColor=[UIColor blackColor];
        avgcasesexc.lineBreakMode = NSLineBreakByWordWrapping;
        [[avgcasesexc layer] setBorderWidth:1.0f];
        avgcasesexc.lineBreakMode = NSLineBreakByWordWrapping;
        avgcasesexc.numberOfLines = 0;
        [headerView addSubview:avgcasesexc];
        [teamtableview addSubview:headerView];
        
        hig=hig+screenRect.size.height*0.07;
    }
    teamtableview.contentSize = CGSizeMake(screenRect.size.width*2., hig);
}
-(void)getlist
{
    bookingarr=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"S"  forKey:@"mode"];

    NSString *keystr;
    NSString *urlString;
    if ([_comestr isEqualToString:@"ESC"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getsalespitem.php?",[prefs objectForKey:@"Link"]];
        keystr=@"salespitem";
        [params setObject:@"getsalespitem"  forKey:@"requestType"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
    }
    if ([_comestr isEqualToString:@"handover"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getboho.php?",[prefs objectForKey:@"Link"]];
        keystr=@"bookings";
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
        [params setObject:@"getBookings"  forKey:@"requestType"];
        
    }if ([_comestr isEqualToString:@"performance"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getPerformanceData.php",[prefs objectForKey:@"Link"]];
        keystr=@"performance";
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"empid"];
    }
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        bookingarr=[[NSMutableArray alloc]init];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        bookingarr=[dic objectForKey:keystr];
        if ([_comestr isEqualToString:@"performance"])
        [self createview];
        
        if (bookingarr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data avaible"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        totalarr=[bookingarr mutableCopy];
        [indicator stopAnimating];
        [tableViewHome reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (textField==_searchtext) {
        bookingarr= [[NSMutableArray alloc]init];
        NSString*  textstr=textField.text;
        if ([string isEqualToString:@""]) {
            textstr= [textstr substringToIndex:[textstr length]-1];
        }
        else
        {
            textstr=[NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        if ([_comestr isEqualToString:@"ESC"]) {
            for (int i=0; i<totalarr.count; i++) {
                NSDictionary *tempdict=[totalarr objectAtIndex:i];
                NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"proj_name"]]
                ;
                if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"unit_no"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"name1"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"mobile"] uppercaseString] containsString:[textstr uppercaseString]]) {
                    [bookingarr addObject:[totalarr objectAtIndex:i]];
                }
            }
        }
        if([_comestr isEqualToString:@"handover"])
        {
            for (int i=0; i<totalarr.count; i++) {
                NSDictionary *tempdict=[totalarr objectAtIndex:i];
                NSMutableDictionary *mutableDict = [tempdict mutableCopy];
                for (NSString *key in [tempdict allKeys]) {
                    if ([tempdict[key] isEqual:[NSNull null]]) {
                        mutableDict[key] = @"";
                    }
                }
                tempdict = [mutableDict copy];
                NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_id"]]
                ;
                if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"bknum"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"bkdate"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"unit_no"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"name"] uppercaseString] containsString:[textstr uppercaseString]]) {
                    [bookingarr addObject:[totalarr objectAtIndex:i]];
                }
            }
        }
        if (textstr.length<1) {
            [bookingarr addObjectsFromArray:totalarr];
        }
        [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
}
-(void)getteamlist
{
    bookingarr=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
  
   // [params setObject:@"e79e4496-95eb-dba6-d86c-599acc022070"  forKey:@"empid"];
    [params setObject:@"T"  forKey:@"mode"];

    NSString *keystr;
    NSString *urlString;
    if ([_comestr isEqualToString:@"ESC"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getsalesphead.php?",[prefs objectForKey:@"Link"]];
        keystr=@"salesphead";
        [params setObject:@"getsalespHead"  forKey:@"requestType"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];

    }
    if ([_comestr isEqualToString:@"handover"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getboho.php?",[prefs objectForKey:@"Link"]];
        keystr=@"bookings";
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
        
    }if ([_comestr isEqualToString:@"performance"]) {
        urlString = [[NSString alloc]initWithFormat:@"%@getPerformanceData.php",[prefs objectForKey:@"Link"]];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"empid"];
        keystr=@"performance";
    }
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        _teamarr=[[NSMutableArray alloc]init];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        _teamarr=[dic objectForKey:keystr];
        if ([_comestr isEqualToString:@"performance"])
        [self performance];
 if ([_comestr isEqualToString:@"ESC"])
     [self generateESCteam];
    
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
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
    if (tableView==tableViewHome) {
        return bookingarr.count;
    }
     if([_comestr isEqualToString:@"performance"]&&tableView==teamtableview)
    {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (tableView==tableViewHome) {
        NSDictionary *dict=[bookingarr objectAtIndex:indexPath.row];
        NSMutableDictionary *mutableDict = [dict mutableCopy];
        for (NSString *key in [dict allKeys]) {
            if ([dict[key] isEqual:[NSNull null]]) {
                mutableDict[key] = @"";
            }
        }
        dict = [mutableDict copy];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        
        if ([_comestr isEqualToString:@"ESC"]) {

            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.32)];
            headerView.backgroundColor=[UIColor whiteColor];
            headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
            headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
            headerView.layer.shadowOpacity = 1.0f;
            headerView.layer.shadowRadius = 0.0f;
            headerView.layer.masksToBounds = NO;
            headerView.backgroundColor=[UIColor whiteColor];
            
            UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.39,screenRect.size.height*0.04)];
            Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            Srnolbl.textAlignment = NSTextAlignmentLeft;
            Srnolbl.text =[NSString stringWithFormat:@"Proj Name"];
            Srnolbl.backgroundColor = [UIColor clearColor];
            Srnolbl.textColor=[UIColor blackColor];
            Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
            Srnolbl.numberOfLines = 0;
            [headerView addSubview:Srnolbl];
            
            UILabel*  projectlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
            projectlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            projectlbl.textAlignment = NSTextAlignmentLeft;
            projectlbl.text =[dict objectForKey:@"proj_name"];
            projectlbl.backgroundColor = [UIColor clearColor];
            projectlbl.textColor=[UIColor blackColor];
            projectlbl.lineBreakMode = NSLineBreakByWordWrapping;
            projectlbl.numberOfLines = 0;
            
            [headerView addSubview:projectlbl];
            
            UILabel*  Unitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.0,screenRect.size.width*0.39,screenRect.size.height*0.04)];
            Unitlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            Unitlbl.textAlignment = NSTextAlignmentLeft;
            Unitlbl.text =[NSString stringWithFormat:@"Unit no"];
            Unitlbl.backgroundColor = [UIColor clearColor];
            Unitlbl.textColor=[UIColor blackColor];
            Unitlbl.lineBreakMode = NSLineBreakByWordWrapping;
            Unitlbl.numberOfLines = 0;
            [headerView addSubview:Unitlbl];
            
            UILabel*  unit2lbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
            unit2lbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            unit2lbl.textAlignment = NSTextAlignmentLeft;
            unit2lbl.text =[dict objectForKey:@"unit_no"];
            unit2lbl.backgroundColor = [UIColor clearColor];
            unit2lbl.textColor=[UIColor blackColor];
            unit2lbl.lineBreakMode = NSLineBreakByWordWrapping;
            unit2lbl.numberOfLines = 0;
            [headerView addSubview:unit2lbl];
            
            UILabel*  tottalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
            tottalbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            tottalbl.textAlignment = NSTextAlignmentLeft;
            tottalbl.text =[NSString stringWithFormat:@"Agreement value"];
            tottalbl.backgroundColor = [UIColor clearColor];
            tottalbl.textColor=[UIColor blackColor];
            tottalbl.lineBreakMode = NSLineBreakByWordWrapping;
            tottalbl.numberOfLines = 0;
            [headerView addSubview:tottalbl];
            
            UILabel*  totalcoll2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
            totalcoll2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            totalcoll2.textAlignment = NSTextAlignmentLeft;
            totalcoll2.text =[dict objectForKey:@"amt_collected"];
            totalcoll2.backgroundColor = [UIColor clearColor];
            totalcoll2.textColor=[UIColor blackColor];
            totalcoll2.lineBreakMode = NSLineBreakByWordWrapping;
            totalcoll2.numberOfLines = 0;
            [headerView addSubview:totalcoll2];
            
            UILabel*  balancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
            balancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            balancelbl.textAlignment = NSTextAlignmentLeft;
            balancelbl.text =[NSString stringWithFormat:@"Scheme"];
            balancelbl.backgroundColor = [UIColor clearColor];
            balancelbl.textColor=[UIColor blackColor];
            balancelbl.lineBreakMode = NSLineBreakByWordWrapping;
            balancelbl.numberOfLines = 0;
            [headerView addSubview:balancelbl];
            
            UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
            balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            balancelbl2.textAlignment = NSTextAlignmentLeft;
            balancelbl2.text =[dict objectForKey:@"scheme"];
            balancelbl2.backgroundColor = [UIColor clearColor];
            balancelbl2.textColor=[UIColor blackColor];
            balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
            balancelbl2.numberOfLines = 0;
            [headerView addSubview:balancelbl2];
            
            UILabel*  baclbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
            baclbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            baclbl.textAlignment = NSTextAlignmentLeft;
            baclbl.text =[NSString stringWithFormat:@"ESC Date"];
            baclbl.backgroundColor = [UIColor clearColor];
            baclbl.textColor=[UIColor blackColor];
            baclbl.lineBreakMode = NSLineBreakByWordWrapping;
            baclbl.numberOfLines = 0;
            [headerView addSubview:baclbl];
            
            UILabel*  baclbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
            baclbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            baclbl2.textAlignment = NSTextAlignmentLeft;
            baclbl2.text =[dict objectForKey:@"esc_date"];
            baclbl2.backgroundColor = [UIColor clearColor];
            baclbl2.textColor=[UIColor blackColor];
            baclbl2.lineBreakMode = NSLineBreakByWordWrapping;
            baclbl2.numberOfLines = 0;
            [headerView addSubview:baclbl2];
            
            UILabel*  baclbalance = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
            baclbalance.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            baclbalance.textAlignment = NSTextAlignmentLeft;
            baclbalance.text =[NSString stringWithFormat:@"ESC Escalated to"];
            baclbalance.backgroundColor = [UIColor clearColor];
            baclbalance.textColor=[UIColor blackColor];
            baclbalance.lineBreakMode = NSLineBreakByWordWrapping;
            baclbalance.numberOfLines = 0;
            [headerView addSubview:baclbalance];
            
            UILabel*  baclbalance2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
            baclbalance2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            baclbalance2.textAlignment = NSTextAlignmentLeft;
            baclbalance2.text =[dict objectForKey:@"esc_to_empname"];
            baclbalance2.backgroundColor = [UIColor clearColor];
            baclbalance2.textColor=[UIColor blackColor];
            baclbalance2.lineBreakMode = NSLineBreakByWordWrapping;
            baclbalance2.numberOfLines = 0;
            [headerView addSubview:baclbalance2];
            

            UILabel*  custlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.24,screenRect.size.width*0.70,screenRect.size.height*0.04)];
            custlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            custlbl.textAlignment = NSTextAlignmentLeft;
            custlbl.text =[NSString stringWithFormat:@"Customer Name"];
            custlbl.backgroundColor = [UIColor clearColor];
            custlbl.textColor=[UIColor blackColor];
            custlbl.lineBreakMode = NSLineBreakByWordWrapping;
            custlbl.numberOfLines = 0;
            [headerView addSubview:custlbl];
            
            UILabel*  custlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.28,screenRect.size.width*0.70,screenRect.size.height*0.035)];
            custlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            custlbl2.textAlignment = NSTextAlignmentLeft;
            custlbl2.text =[dict objectForKey:@"name1"];
            custlbl2.backgroundColor = [UIColor clearColor];
            custlbl2.textColor=[UIColor blackColor];
            custlbl2.lineBreakMode = NSLineBreakByWordWrapping;
            custlbl2.numberOfLines = 0;
            [headerView addSubview:custlbl2];
            
            [cell.contentView addSubview:headerView];
        }
        if ([_comestr isEqualToString:@"handover"]) {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,0,screenRect.size.width*0.94,screenRect.size.height*0.23)];
            headerView.backgroundColor=[UIColor whiteColor];
            headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
            headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
            headerView.layer.shadowOpacity = 1.0f;
            headerView.layer.shadowRadius = 0.0f;
            headerView.layer.masksToBounds = NO;
            headerView.backgroundColor=[UIColor whiteColor];
            
            UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.80,screenRect.size.height*0.04)];
            Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
            Srnolbl.textAlignment = NSTextAlignmentLeft;
            Srnolbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"project_id"]];
            ;
            Srnolbl.backgroundColor = [UIColor clearColor];
            Srnolbl.textColor=[UIColor blackColor];
            Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
            Srnolbl.numberOfLines = 0;
            [headerView addSubview:Srnolbl];
            
            UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.035)];
            namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            namelbl.textAlignment = NSTextAlignmentLeft;
            namelbl.text =[NSString stringWithFormat:@"Booking no: %@",[dict objectForKey:@"bknum"]];
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor=[UIColor blackColor];
            namelbl.lineBreakMode = NSLineBreakByWordWrapping;
            namelbl.numberOfLines = 0;
            
            [headerView addSubview:namelbl];
            
            UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.085,screenRect.size.width*0.80,screenRect.size.height*0.035)];
            idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            idlbl.textAlignment = NSTextAlignmentLeft;
            idlbl.text =[NSString stringWithFormat:@"Booking Date: %@",[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"bkdate"]]]];
            idlbl.backgroundColor = [UIColor clearColor];
            idlbl.textColor=[UIColor blackColor];
            idlbl.lineBreakMode = NSLineBreakByWordWrapping;
            idlbl.numberOfLines = 0;
            [headerView addSubview:idlbl];
            
            UILabel*  moblbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12,screenRect.size.width*0.80,screenRect.size.height*0.035)];
            moblbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            moblbl.textAlignment = NSTextAlignmentLeft;
            moblbl.text =[NSString stringWithFormat:@"Unit No: %@",[dict objectForKey:@"unit_no"]];
            moblbl.backgroundColor = [UIColor clearColor];
            moblbl.textColor=[UIColor blackColor];
            moblbl.lineBreakMode = NSLineBreakByWordWrapping;
            moblbl.numberOfLines = 0;
            [headerView addSubview:moblbl];
            
            UILabel*  custname = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.155,screenRect.size.width*0.85,screenRect.size.height*0.035)];
            custname.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            custname.textAlignment = NSTextAlignmentLeft;
            custname.text =[NSString stringWithFormat:@"Customer name: %@",[dict objectForKey:@"name"]];
            custname.backgroundColor = [UIColor clearColor];
            custname.textColor=[UIColor blackColor];
            custname.lineBreakMode = NSLineBreakByWordWrapping;
            custname.numberOfLines = 0;
            [headerView addSubview:custname];
            
            UILabel*  agrvalue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.19,screenRect.size.width*0.85,screenRect.size.height*0.035)];
            agrvalue.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
            agrvalue.textAlignment = NSTextAlignmentLeft;
            agrvalue.text =[NSString stringWithFormat:@"Amount collected: %@",[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"amt_collected"]]]];
            agrvalue.backgroundColor = [UIColor clearColor];
            agrvalue.textColor=[UIColor blackColor];
            agrvalue.lineBreakMode = NSLineBreakByWordWrapping;
            agrvalue.numberOfLines = 0;
            [headerView addSubview:agrvalue];
            
            if ([_comestr isEqualToString:@"handover"]) {
                agrvalue.text =[NSString stringWithFormat:@"Agreement Value:%@",[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"agvalue"]]]];
                idlbl.text =[NSString stringWithFormat:@"Booking date: %@",[dict objectForKey:@"bkdate"]];
            }
            else
            {
                UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.23,screenRect.size.width*0.90,screenRect.size.height*0.003)];
                linelbl.backgroundColor = [UIColor lightGrayColor];
                [headerView addSubview:linelbl];
                UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.70,screenRect.size.height*0.235,screenRect.size.width*0.08,screenRect.size.height*.05)];
                [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                editbtn.layer.masksToBounds=YES;
                //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
                editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
                [editbtn setTitle:@"\uE90E" forState:UIControlStateNormal];
                [headerView addSubview:editbtn];
                
                UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.78,screenRect.size.height*0.235,screenRect.size.width*0.20,screenRect.size.height*.05)];
                [editbtn2 setBackgroundColor:[UIColor clearColor]];
                [editbtn2 addTarget:self action:@selector(remark:) forControlEvents:UIControlEventTouchUpInside];
                editbtn2.tag=indexPath.row;
                UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
                [editbtn2 setTitle:@"Remark" forState:UIControlStateNormal];
                editbtn2.titleLabel.font=font;
                [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [headerView addSubview:editbtn2];
                
                UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.52,screenRect.size.height*0.235,screenRect.size.width*0.08,screenRect.size.height*.05)];
                [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                savebtn.layer.masksToBounds=YES;
                //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
                savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
                [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
                [headerView addSubview:savebtn];
                
                UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.60,screenRect.size.height*0.235,screenRect.size.width*0.10,screenRect.size.height*.05)];
                [phonebtn2 setBackgroundColor:[UIColor clearColor]];
                [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
                phonebtn2.tag=indexPath.row;
                [phonebtn2 setTitle:@"Call" forState:UIControlStateNormal];
                [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                phonebtn2.titleLabel.font=font;
                [headerView addSubview:phonebtn2];
                headerView.frame=CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.29);
            }
            [cell.contentView addSubview:headerView];
        }
        if ([_comestr isEqualToString:@"performance"]) {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width,screenRect.size.height*0.72)];
            headerView.backgroundColor=[UIColor whiteColor];
            headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
            headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
            headerView.layer.shadowOpacity = 1.0f;
            headerView.layer.shadowRadius = 0.0f;
            headerView.layer.masksToBounds = NO;
            headerView.backgroundColor=[UIColor whiteColor];
            
            UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            namelbl.textAlignment = NSTextAlignmentLeft;
            namelbl.text =@"Employee code:";
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor=[UIColor blackColor];
            namelbl.lineBreakMode = NSLineBreakByWordWrapping;
            namelbl.numberOfLines = 0;
            [headerView addSubview:namelbl];
            
            UILabel*  dotlbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.0,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl1.text=@":";
            dotlbl1.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl1];
            
            UILabel*  namelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.0,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            namelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            namelbl2.textAlignment = NSTextAlignmentLeft;
            namelbl2.text =[dict objectForKey:@"empcode"];
            namelbl2.backgroundColor = [UIColor clearColor];
            namelbl2.textColor=[UIColor blackColor];
            namelbl2.lineBreakMode = NSLineBreakByWordWrapping;
            namelbl2.numberOfLines = 0;
            [headerView addSubview:namelbl2];
            
            UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            idlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            idlbl.textAlignment = NSTextAlignmentLeft;
            //   idlbl.text =[NSString stringWithFormat:@"Booking Date: %@",[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"bkdate"]]]];
            idlbl.text =@"Monthly leads";
            
            idlbl.backgroundColor = [UIColor clearColor];
            idlbl.textColor=[UIColor blackColor];
            idlbl.lineBreakMode = NSLineBreakByWordWrapping;
            idlbl.numberOfLines = 0;
            [headerView addSubview:idlbl];
            
            UILabel*  dotlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.05,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl2.text=@":";
            dotlbl2.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl2];
            
            UILabel*  idlblvalue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.05,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            idlblvalue.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            idlblvalue.textAlignment = NSTextAlignmentLeft;
            idlblvalue.text =[dict objectForKey:@"mlead"];
            idlblvalue.backgroundColor = [UIColor clearColor];
            idlblvalue.textColor=[UIColor blackColor];
            idlblvalue.lineBreakMode = NSLineBreakByWordWrapping;
            idlblvalue.numberOfLines = 0;
            [headerView addSubview:idlblvalue];
            
            UILabel*  idlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.10,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            idlbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            idlbl2.textAlignment = NSTextAlignmentLeft;
            //   idlbl.text =[NSString stringWithFormat:@"Booking Date: %@",[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"bkdate"]]]];
            idlbl2.text =@"Quarterly leads";
            idlbl2.backgroundColor = [UIColor clearColor];
            idlbl2.textColor=[UIColor blackColor];
            idlbl2.lineBreakMode = NSLineBreakByWordWrapping;
            idlbl2.numberOfLines = 0;
            [headerView addSubview:idlbl2];
            
            UILabel*  dotlbl3 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.10,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl3.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl3.text=@":";
            dotlbl3.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl3];
            
            UILabel*  idlbl2value = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.10,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            idlbl2value.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            idlbl2value.textAlignment = NSTextAlignmentLeft;
            idlbl2value.text =[dict objectForKey:@"qlead"];
            idlbl2value.backgroundColor = [UIColor clearColor];
            idlbl2value.textColor=[UIColor blackColor];
            [headerView addSubview:idlbl2value];
            
            UILabel*  idlbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.15,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            idlbl1.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            idlbl1.textAlignment = NSTextAlignmentLeft;
            //   idlbl.text =[NSString stringWithFormat:@"Booking Date: %@",[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"bkdate"]]]];
            idlbl1.text =@"Yearly leads";
            idlbl1.backgroundColor = [UIColor clearColor];
            idlbl1.textColor=[UIColor blackColor];
            idlbl1.lineBreakMode = NSLineBreakByWordWrapping;
            idlbl1.numberOfLines = 0;
            [headerView addSubview:idlbl1];
            
            UILabel*  dotlbl4 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.15,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl4.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl4.text=@":";
            dotlbl4.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl4];
            
            UILabel*  idlbl3value = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.15,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            idlbl3value.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            idlbl3value.textAlignment = NSTextAlignmentLeft;
            idlbl3value.text =[dict objectForKey:@"ylead"];
            idlbl3value.backgroundColor = [UIColor clearColor];
            idlbl3value.textColor=[UIColor blackColor];
            [headerView addSubview:idlbl3value];
            
            
            UILabel*  moblbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            moblbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            moblbl2.textAlignment = NSTextAlignmentLeft;
            moblbl2.text=@"Monthly bookings";
            moblbl2.backgroundColor = [UIColor clearColor];
            moblbl2.textColor=[UIColor blackColor];
            moblbl2.lineBreakMode = NSLineBreakByWordWrapping;
            moblbl2.numberOfLines = 0;
            [headerView addSubview:moblbl2];
            
            UILabel*  dotlbl5 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.20,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl5.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl5.text=@":";
            dotlbl5.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl5];
            
            UILabel*  moblbl2vlaue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.20,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            moblbl2vlaue.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            moblbl2vlaue.textAlignment = NSTextAlignmentLeft;
            moblbl2vlaue.text =[dict objectForKey:@"mbooking"];
            moblbl2vlaue.backgroundColor = [UIColor clearColor];
            moblbl2vlaue.textColor=[UIColor blackColor];
            [headerView addSubview:moblbl2vlaue];
            
            UILabel*  quatrlylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.25,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            quatrlylbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.042];
            quatrlylbl.textAlignment = NSTextAlignmentLeft;
            quatrlylbl.text =@"Quarterly bookings";
            quatrlylbl.backgroundColor = [UIColor clearColor];
            quatrlylbl.textColor=[UIColor blackColor];
            quatrlylbl.lineBreakMode = NSLineBreakByWordWrapping;
            quatrlylbl.numberOfLines = 0;
            [headerView addSubview:quatrlylbl];
            
            UILabel*  dotlbl6 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.25,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl6.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl6.text=@":";
            dotlbl6.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl6];
            
            UILabel*  quatrlylblvlaue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.25,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            quatrlylblvlaue.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            quatrlylblvlaue.textAlignment = NSTextAlignmentLeft;
            quatrlylblvlaue.text =[dict objectForKey:@"qbooking"];
            quatrlylblvlaue.backgroundColor = [UIColor clearColor];
            quatrlylblvlaue.textColor=[UIColor blackColor];
            [headerView addSubview:quatrlylblvlaue];
            
            UILabel*  quatrlylbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.30,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            quatrlylbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            quatrlylbl2.textAlignment = NSTextAlignmentLeft;
            quatrlylbl2.text =@"Yearly bookings";
            quatrlylbl2.backgroundColor = [UIColor clearColor];
            quatrlylbl2.textColor=[UIColor blackColor];
            quatrlylbl2.lineBreakMode = NSLineBreakByWordWrapping;
            quatrlylbl2.numberOfLines = 0;
            [headerView addSubview:quatrlylbl2];
            
            UILabel*  dotlbl7 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.30,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl7.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl7.text=@":";
            dotlbl7.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl7];
            
            UILabel*  quatrlylbl2value = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.30,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            quatrlylbl2value.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            quatrlylbl2value.textAlignment = NSTextAlignmentLeft;
            quatrlylbl2value.text =[dict objectForKey:@"ybooking"];
            quatrlylbl2value.backgroundColor = [UIColor clearColor];
            quatrlylbl2value.textColor=[UIColor blackColor];
            [headerView addSubview:quatrlylbl2value];
            
            UILabel*  custname = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.35,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            custname.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            custname.textAlignment = NSTextAlignmentLeft;
            custname.text =@"Monthly C.R.";
            custname.backgroundColor = [UIColor clearColor];
            custname.textColor=[UIColor blackColor];
            custname.lineBreakMode = NSLineBreakByWordWrapping;
            custname.numberOfLines = 0;
            [headerView addSubview:custname];
            
            UILabel*  dotlbl8 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.35,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl8.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl8.text=@":";
            dotlbl8.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl8];
            
            UILabel*  custnamevalues = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.35,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            custnamevalues.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            custnamevalues.textAlignment = NSTextAlignmentLeft;
            custnamevalues.text =[dict objectForKey:@"mratio"];
            custnamevalues.backgroundColor = [UIColor clearColor];
            custnamevalues.textColor=[UIColor blackColor];
            [headerView addSubview:custnamevalues];
            
            UILabel*  quatcr = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.40,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            quatcr.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            quatcr.textAlignment = NSTextAlignmentLeft;
            quatcr.text =@"Quarterly C.R.";
            quatcr.backgroundColor = [UIColor clearColor];
            quatcr.textColor=[UIColor blackColor];
            quatcr.lineBreakMode = NSLineBreakByWordWrapping;
            quatcr.numberOfLines = 0;
            [headerView addSubview:quatcr];
            
            UILabel*  dotlbl9 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.40,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl9.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl9.text=@":";
            dotlbl9.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl9];
            
            UILabel*  quatcrvalye = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.40,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            quatcrvalye.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            quatcrvalye.textAlignment = NSTextAlignmentLeft;
            quatcrvalye.text =[dict objectForKey:@"qratio"];
            quatcrvalye.backgroundColor = [UIColor clearColor];
            quatcrvalye.textColor=[UIColor blackColor];
            [headerView addSubview:quatcrvalye];
            
            UILabel*  quatcr2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.45,screenRect.size.width*0.38,screenRect.size.height*0.05)];
            quatcr2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            quatcr2.textAlignment = NSTextAlignmentLeft;
            quatcr2.text =@"Yearly C.R.";
            quatcr2.backgroundColor = [UIColor clearColor];
            quatcr2.textColor=[UIColor blackColor];
            quatcr2.lineBreakMode = NSLineBreakByWordWrapping;
            quatcr2.numberOfLines = 0;
            [headerView addSubview:quatcr2];
            
            UILabel*  dotlbl10 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.45,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl10.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl10.text=@":";
            dotlbl10.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl10];
            
            UILabel*  quatcr2value = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.45,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            quatcr2value.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            quatcr2value.textAlignment = NSTextAlignmentLeft;
            quatcr2value.text =[dict objectForKey:@"yratio"];
            quatcr2value.backgroundColor = [UIColor clearColor];
            quatcr2value.textColor=[UIColor blackColor];
            [headerView addSubview:quatcr2value];
            
            UILabel*  agrvalue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.5,screenRect.size.width*0.38,screenRect.size.height*0.07)];
            agrvalue.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            agrvalue.textAlignment = NSTextAlignmentLeft;
            agrvalue.text =@"Monthly Agr. value:";
            agrvalue.backgroundColor = [UIColor clearColor];
            agrvalue.textColor=[UIColor blackColor];
            agrvalue.lineBreakMode = NSLineBreakByWordWrapping;
            agrvalue.numberOfLines = 0;
            [headerView addSubview:agrvalue];
            
            UILabel*  dotlbl11 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.51,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl11.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl11.text=@":";
            dotlbl11.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl11];
            
            UILabel*  agrvaluevalue = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.51,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            agrvaluevalue.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            agrvaluevalue.textAlignment = NSTextAlignmentLeft;
            agrvaluevalue.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"magvalue"]]];
            agrvaluevalue.backgroundColor = [UIColor clearColor];
            agrvaluevalue.textColor=[UIColor blackColor];
            [headerView addSubview:agrvaluevalue];
            
            UILabel*  agrvalue2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.57,screenRect.size.width*0.38,screenRect.size.height*0.07)];
            agrvalue2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            agrvalue2.textAlignment = NSTextAlignmentLeft;
            agrvalue2.text=@"Quartly Agr. value:";
            agrvalue2.backgroundColor = [UIColor clearColor];
            agrvalue2.textColor=[UIColor blackColor];
            agrvalue2.lineBreakMode = NSLineBreakByWordWrapping;
            agrvalue2.numberOfLines = 0;
            [headerView addSubview:agrvalue2];
            
            
            UILabel*  dotlbl12 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.58,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl12.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl12.text=@":";
            dotlbl12.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl12];
            
            UILabel*  agrvaluevalue2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.58,screenRect.size.width*0.55,screenRect.size.height*0.06)];
            agrvaluevalue2.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            agrvaluevalue2.textAlignment = NSTextAlignmentLeft;
            agrvaluevalue2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"qagvalue"]]];
            agrvaluevalue2.backgroundColor = [UIColor clearColor];
            agrvaluevalue2.textColor=[UIColor blackColor];
            [headerView addSubview:agrvaluevalue2];
            
            UILabel*  agrvalue3 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.65,screenRect.size.width*0.38,screenRect.size.height*0.07)];
            agrvalue3.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
            agrvalue3.textAlignment = NSTextAlignmentLeft;
            agrvalue3.text =@"Yearly Agr. value";
            agrvalue3.backgroundColor = [UIColor clearColor];
            agrvalue3.textColor=[UIColor blackColor];
            agrvalue3.lineBreakMode = NSLineBreakByWordWrapping;
            agrvalue3.numberOfLines = 0;
            [headerView addSubview:agrvalue3];
            
            UILabel*  dotlbl13 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.66,screenRect.size.width*0.03,screenRect.size.height*0.05)];
            dotlbl13.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            dotlbl13.text=@":";
            dotlbl13.textColor=[UIColor blackColor];
            [headerView addSubview:dotlbl13];
            
            UILabel*  agrvalue3value = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,screenRect.size.height*0.66,screenRect.size.width*0.55,screenRect.size.height*0.05)];
            agrvalue3value.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
            agrvalue3value.textAlignment = NSTextAlignmentLeft;
            agrvalue3value.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"yagvalue"]]];
            agrvalue3value.backgroundColor = [UIColor clearColor];
            agrvalue3value.textColor=[UIColor blackColor];
            [headerView addSubview:agrvalue3value];
            
            [cell.contentView addSubview:headerView];
        }
    }
    if (tableView==teamtableview&&[_comestr isEqualToString:@"performance"]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor clearColor];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.30,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text =@"Thir T" ;
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = @"12";
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,0,screenRect.size.width*0.23,screenRect.size.height*0.07)];
        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = @"47";
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text = @"23";
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.85,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = @"11.03";
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        
        [cell.contentView addSubview:headerView];
        return cell;
    }
    if (tableView==teamtableview&&[_comestr isEqualToString:@"ESC"])
    {
        return cell;
    }
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
    //    LeadViewController *mainvc=[[LeadViewController alloc] initWithNibName:@"LeadViewController" bundle:nil];
    //    [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (tableView==tableViewHome) {
        if ([_comestr isEqualToString:@"performance"]) {
            return screenRect.size.height*0.74;
        }
        if ([_comestr isEqualToString:@"handover"]) {
            return screenRect.size.height*0.24;
        }
      else  if ([_comestr isEqualToString:@"ESC"]) {
            return screenRect.size.height*0.33;
        }
    else
        return screenRect.size.height*0.30;
    }
    if (tableView==teamtableview &&[_comestr isEqualToString:@"performance"])
    {
        return screenRect.size.height*0.30;
    }
    if (tableView==teamtableview &&[_comestr isEqualToString:@"ESC"])
    {
        return screenRect.size.height*0.10;
    }
    return screenRect.size.height*0.10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (tableView==teamtableview &&[_comestr isEqualToString:@"performance"])
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.30,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = @"Emp Name";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:1.0f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = @"Total\nBooking";
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [[namelbl layer] setBorderWidth:1.0f];
        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = @"Total\nVisit";
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[datelbl layer] setBorderWidth:1.0f];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text = @"Conversion\nretio";
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl layer] setBorderWidth:1.0f];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.85,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = @"Agr.\nValue %";
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[expencelbl layer] setBorderWidth:1.0f];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        return headerView;
    }
    else
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (tableView==teamtableview &&[_comestr isEqualToString:@"performance"])
    {        return  screenRect.size.height*0.07;
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)remark:(UIButton*)btn
{
    [TakePhotoView removeFromSuperview];
    TakePhotoView = [[CustomIOS7AlertView alloc] init];
    [TakePhotoView setContainerView:[self signImageSetAlert]];
    [TakePhotoView setDelegate:self];
    [TakePhotoView setUseMotionEffects:true];
    [TakePhotoView show];
}

-(UIView *)signImageSetAlert{
    NSDictionary *dict=[bookingarr objectAtIndex:index];
    int heig=0;
    heig=150;
    
    if ([dict objectForKey:@"REMARK1"]==nil) {
        NSString* positionstr2;
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 300,310)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UILabel* aboutmelbl = [[UILabel alloc] init];
    [aboutmelbl setFrame:CGRectMake(20, 0, 250, 40)];
    aboutmelbl.textAlignment = NSTextAlignmentLeft;
    aboutmelbl.backgroundColor=[UIColor clearColor];
    [aboutmelbl setTextColor: [UIColor blackColor]];
    [demoView addSubview:aboutmelbl];
    aboutmelbl.lineBreakMode = NSLineBreakByWordWrapping;
    aboutmelbl.numberOfLines = 0;
    UIFont *text1Font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    NSString* positionstr1=@"Remark1:- ";
    NSString* positionstr2= ([dict objectForKey:@"remark1"]==nil)? @"":[dict objectForKey:@"remark1"];
    NSMutableAttributedString *attributedString1 =
    [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIFont *text2Font2 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    NSMutableAttributedString *attributedString2 =
    [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
    [attributedString1 appendAttributedString:attributedString2];
    aboutmelbl.attributedText = attributedString1;
    
    UILabel* remark2lbl = [[UILabel alloc] init];
    [remark2lbl setFrame:CGRectMake(20, 40, 250, 40)];
    remark2lbl.textAlignment = NSTextAlignmentLeft;
    remark2lbl.backgroundColor=[UIColor clearColor];
    [remark2lbl setTextColor: [UIColor blackColor]];
    [demoView addSubview:remark2lbl];
    remark2lbl.lineBreakMode = NSLineBreakByWordWrapping;
    remark2lbl.numberOfLines = 0;
    NSString* positionstr3=@"Remark2:-";
    NSString*  positionstr4 = ([dict objectForKey:@"remark2"]==nil) ? @"" : [dict objectForKey:@"remark2"];
    NSMutableAttributedString *attributedString3 =
    [[NSMutableAttributedString alloc] initWithString:positionstr3 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString4 =
    [[NSMutableAttributedString alloc] initWithString:positionstr4 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
    [attributedString3 appendAttributedString:attributedString4];
    remark2lbl.attributedText = attributedString3;
    
    UILabel* remark3lbl = [[UILabel alloc] init];
    [remark3lbl setFrame:CGRectMake(20, 80, 250, 40)];
    remark3lbl.textAlignment = NSTextAlignmentLeft;
    remark3lbl.backgroundColor=[UIColor clearColor];
    [remark3lbl setTextColor: [UIColor blackColor]];
    [demoView addSubview:remark3lbl];
    remark3lbl.lineBreakMode = NSLineBreakByWordWrapping;
    remark3lbl.numberOfLines = 0;
    NSString* positionstr5=@"Remark3:-";
    NSString* positionstr6=([dict objectForKey:@"remark3"]==nil) ? @"" : [dict objectForKey:@"remark3"];
    NSMutableAttributedString *attributedString5 =
    [[NSMutableAttributedString alloc] initWithString:positionstr5 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString6 =
    [[NSMutableAttributedString alloc] initWithString:positionstr6 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
    [attributedString5 appendAttributedString:attributedString6];
    remark3lbl.attributedText = attributedString5;
    
    UILabel* remark4lbl = [[UILabel alloc] init];
    [remark4lbl setFrame:CGRectMake(20, 120, 250, 40)];
    remark4lbl.textAlignment = NSTextAlignmentLeft;
    remark4lbl.backgroundColor=[UIColor clearColor];
    [remark4lbl setTextColor: [UIColor blackColor]];
    [demoView addSubview:remark4lbl];
    remark4lbl.lineBreakMode = NSLineBreakByWordWrapping;
    remark4lbl.numberOfLines = 0;
    NSString* positionstr7=@"Remark4:-";
    NSString* positionstr8=([dict objectForKey:@"remark4"]==nil) ? @"" : [dict objectForKey:@"remark4"];
    NSMutableAttributedString *attributedString7 =
    [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString8 =
    [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
    [attributedString7 appendAttributedString:attributedString8];
    remark4lbl.attributedText = attributedString5;
    
    UILabel* remark5lbl = [[UILabel alloc] init];
    [remark5lbl setFrame:CGRectMake(20, 160, 250, 40)];
    remark5lbl.textAlignment = NSTextAlignmentLeft;
    remark5lbl.backgroundColor=[UIColor clearColor];
    [remark5lbl setTextColor: [UIColor blackColor]];
    [demoView addSubview:remark5lbl];
    remark5lbl.lineBreakMode = NSLineBreakByWordWrapping;
    remark5lbl.numberOfLines = 0;
    NSString* positionstr9=@"Remark5:-";
    NSString* positionstr10=([dict objectForKey:@"remark5"]==nil) ? @"" : [dict objectForKey:@"remark5"];
    NSMutableAttributedString *attributedString9 =
    [[NSMutableAttributedString alloc] initWithString:positionstr9 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *attributedString10 =
    [[NSMutableAttributedString alloc] initWithString:positionstr10 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
    [attributedString9 appendAttributedString:attributedString10];
    remark5lbl.attributedText = attributedString9;
    
    remarktxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,200,280,40)];
    remarktxt.textAlignment=NSTextAlignmentLeft;
    remarktxt.delegate = self;
    remarktxt.textColor=[UIColor blackColor];
    [remarktxt setBackgroundColor:[UIColor clearColor]];
    remarktxt.leftViewMode = UITextFieldViewModeAlways;
    [remarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
    remarktxt.returnKeyType=UIReturnKeyDone;
    remarktxt.selectedLineColor = [UIColor redColor];
    remarktxt.selectedPlaceHolderColor = [UIColor redColor];
    remarktxt.placeHolderColor = [UIColor grayColor];
    remarktxt.placeholder=@"Remark";
    remarktxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:remarktxt];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,250,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,250,125,40)];
    [savebtn setTitle:@"Submit" forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(submit)
      forControlEvents:UIControlEventTouchUpInside];
    savebtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    [savebtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    savebtn.layer.borderColor = [UIColor grayColor].CGColor;
    savebtn.layer.borderWidth = 0.5;
    [demoView addSubview:savebtn];
    return demoView;
    
}
-(void)submit
{
    NSDictionary *dict=[bookingarr objectAtIndex:index];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:remarktxt.text  forKey:@"remark"];
    [params setObject:[dict objectForKey:@"bknum"]  forKey:@"bookingno"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@updateesc.php?",[prefs objectForKey:@"Link"]];
    // NSString*   urlString=@"http://13.126.129.245/xrbia/mobilecrm/cp/updatebcac.php?";
    UIActivityIndicatorView *actvityindicatior = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    actvityindicatior.frame = CGRectMake(20, 120, 250, 40);
    [demoView addSubview:actvityindicatior];
    [actvityindicatior bringSubviewToFront:TakePhotoView];
    
    [actvityindicatior startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        if ([[userDict objectForKey:@"status"]integerValue]==1){
            [TakePhotoView close];
        }
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [actvityindicatior stopAnimating];
        [self getlist];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [actvityindicatior stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)openurl:(UIButton*)btn
{
        NSDictionary *dict=[bookingarr objectAtIndex:btn.tag];
        //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dict objectForKey:@"phone_mobile"]]]];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"xrbia"  forKey:@"userName"];
        [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
        [params setObject:[dict objectForKey:@"mobile"] forKey:@"custNumber"];
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
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"status"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            [indicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    
}
-(void)filter: (id) sender
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    heig=150;
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-150, 300,200)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
    [topButton setTitle:@"Status:" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
    UIButton *checkboxbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 30,20)];
    checkboxbtn.font=[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [checkboxbtn setTitle:@"\uE836" forState:UIControlStateNormal];
    [checkboxbtn setTitle:@"\uE837" forState:UIControlStateSelected];
    [checkboxbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [checkboxbtn addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:checkboxbtn];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 100, 40)];
    namelbl.font=[UIFont systemFontOfSize:15];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =@"Paid";
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    [demoView addSubview:namelbl];
    
    UIButton *checkboxbtn2 = [[UIButton alloc] initWithFrame:CGRectMake(160, 50, 30,20)];
    checkboxbtn2.font=[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [checkboxbtn2 setTitle:@"\uE836" forState:UIControlStateNormal];
    [checkboxbtn2 setTitle:@"\uE837" forState:UIControlStateSelected];
    [checkboxbtn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [checkboxbtn2 addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:checkboxbtn2];
    
    UILabel*  namelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(190, 40, 100, 40)];
    namelbl2.font=[UIFont systemFontOfSize:15];
    namelbl2.textAlignment = NSTextAlignmentLeft;
    namelbl2.text =@"Not Paid";
    namelbl2.backgroundColor = [UIColor clearColor];
    namelbl2.textColor=[UIColor blackColor];
    [demoView addSubview:namelbl2];
    
    projectstxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,90,280,40)];
    projectstxt.textAlignment=NSTextAlignmentLeft;
    projectstxt.delegate = self;
    projectstxt.textColor=[UIColor blackColor];
    [projectstxt setBackgroundColor:[UIColor clearColor]];
    projectstxt.leftViewMode = UITextFieldViewModeAlways;
    [projectstxt setKeyboardType:UIKeyboardTypeEmailAddress];
    projectstxt.returnKeyType=UIReturnKeyDone;
    projectstxt.selectedLineColor = [UIColor redColor];
    projectstxt.selectedPlaceHolderColor = [UIColor redColor];
    projectstxt.placeHolderColor = [UIColor grayColor];
    projectstxt.placeholder=@"Projects";
    projectstxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:projectstxt];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,150,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,150,125,40)];
    [savebtn setTitle:@"Search" forState:UIControlStateNormal];
    [savebtn addTarget:self
                action:@selector(closeAlert:)
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
-(void)closeAlert:(id)sender{
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    demoView.hidden=YES;
    [bgview removeFromSuperview];
    
    [TakePhotoView close];
}
-(void)check:(UIButton*) sender
{
    if (sender.isSelected) {
        sender.selected=NO;
    }
    else
    {
        sender.selected=YES;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor blackColor]];
    [lblRow setText:rowItem];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    lblRow.font=fonts;
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        if (pickerView ==projectpicker)
    {
        projectstr=[[NSString alloc]init];
        projectstr=[NSString stringWithFormat:@"%@",[projectarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
    
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    return componentWidth;
}
-(NSString*)convertdate:(NSString*)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateFromString = [dateFormatter dateFromString:str];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
    return stringDate;
}
-(NSString*)shownumber:(NSString*)str
{
    str= [NSString stringWithFormat:@"%0.02f",[str doubleValue]];
    float value=[str floatValue]+0.002;
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setPositiveFormat:@"##,##,##,###"];
    formatter.maximumFractionDigits = 02;
    NSString*  defalutstr=[NSString stringWithFormat:@"₹%@",[formatter stringFromNumber:[NSNumber numberWithFloat:value]]];
    
    if ([defalutstr rangeOfString:@"."].location == NSNotFound) {
        defalutstr = [defalutstr stringByAppendingString:@".00"]; //str is now "hello world"
    } else {
        return defalutstr;
    }
    //
    return defalutstr;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    
    
    if (textField ==projectstxt) {
        projectarr=[[NSMutableArray alloc]initWithObjects:@"Ambi",@"Riverfront",@"Adobe-Jambhul",@"Hinjewadi", nil];
        
        projectpicker = [[UIPickerView alloc] init];
        [projectpicker setDataSource: self];
        [projectpicker setDelegate: self];
        projectpicker.backgroundColor = [UIColor whiteColor];
        [projectpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        projectpicker.showsSelectionIndicator = YES;
        [projectpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: projectpicker];
        projectpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            projectoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            projectoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [projectoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed4)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        projectoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:projectoolbar];
        
        projectoolbar.hidden=NO;
        [projectstxt resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(BOOL)textFieldShouldReturn:(ACFloatingTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)doneBtnPressed4{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    
    if ([projectstr isEqualToString:@""] || projectstr==nil) {
        if (projectarr.count>0) {
            projectstxt.text=[projectarr objectAtIndex:0];
        }
    }
    else{
        projectstxt.text=projectstr;
    }
}

-(IBAction)cancelBtnpress{
    
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
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
