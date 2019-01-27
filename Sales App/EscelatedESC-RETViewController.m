//
//  EscelatedESC-RETViewController.m
//  Sales App
//
//  Created by Infinitum on 11/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "EscelatedESC-RETViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "HomeViewController.h"


@interface EscelatedESC_RETViewController ()

@end

@implementation EscelatedESC_RETViewController
@synthesize tableViewHome,indicator,comestr,teamtableview,bookingarr,TakePhotoView,demoView,remarktxt,segmentedControl,btn1Dashboard,btn2Dashboard,btn3Dashboard;
UIButton *backButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
//
//    SWRevealViewController *revealController = [self revealViewController];
//    //    [revealController panGestureRecognizer];
//    [revealController tapGestureRecognizer];
//
//    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
//    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
//    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    [navigationbtn setTitle:@"\uE5D2" forState:UIControlStateNormal];
//    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [navigationbtn.titleLabel setFont:customFontdregs];
//    [navigationbtn setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:navigationbtn];;
//
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
     horizontallbl.text=@"TODAY'S FOLLOWUP";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];

   [self addBackButtonWithImageName:@"backwhite"];
   [navigationView addSubview:backButton];
}
- (void)addBackButtonWithImageName:(NSString *)imageName {
    // init your custom button, or your custom view
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 40, 40); // custom frame
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    // set left barButtonItem with custom view
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    

}
-(void)backButtonTapped:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:true];
}

//}
    
//
////    UIButton* emailbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
////    [emailbtn addTarget:self action:@selector(email) forControlEvents:UIControlEventTouchUpInside];
////    [emailbtn.titleLabel setFont:customFontdregs];
////    [emailbtn setBackgroundColor:[UIColor clearColor]];
////    [self.view addSubview:emailbtn];;
////    [emailbtn setImage:[UIImage imageNamed:@"email.png"] forState:UIControlStateNormal];
//
//    if ([comestr isEqualToString:@"ESC\nEscalated"]) {
//        horizontallbl.text=@"Escalated ESC";
//    }
//    else{
//        horizontallbl.text=@"Escalated Retention";
//    }
//    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
//    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
//    [self.view addSubview:backgroundview];

//    tableViewHome = [[UITableView alloc] init];
//    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89)];
//    tableViewHome.backgroundColor=[UIColor clearColor];
//    tableViewHome.delegate = self;
//    tableViewHome.dataSource = self;
//    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:tableViewHome];
//
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
//        NSArray *itemArray = [NSArray arrayWithObjects: @"My", @"Team", nil];
//        segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
//        segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.12, screenRect.size.width*0.80,screenRect.size.height*0.05);
//        [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
//        segmentedControl.selectedSegmentIndex = 0;
//        [self.view addSubview:segmentedControl];
//
//        tableViewHome.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.19, screenRect.size.width,screenRect.size.height*.79);
//    }
//    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
//    indicator.color=[UIColor whiteColor];
//    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
//    [self.view addSubview:indicator];
//    [indicator bringSubviewToFront:self.view];
//    indicator.layer.cornerRadius=15.0f;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [self getbac];
//}
//- (void)MySegmentControlAction:(UISegmentedControl *)segment
//{
//    if(segment.selectedSegmentIndex == 0)
//    {
//        // code for the first button
//        tableViewHome.hidden=NO;
//        teamtableview.hidden=YES;
//        //backgroundview.hidden=NO;
//    }
//    if(segment.selectedSegmentIndex == 1)
//    {
//        // code for the first button
//        tableViewHome.hidden=YES;
//        teamtableview.hidden=NO;
//        //  backgroundview.hidden=YES;
//        [self getteamdata];
//    }
//}
//-(void)getteamdata
//{
//    NSString *keystr;
//    _teamarr=[[NSMutableArray alloc]init];
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
//    NSString* urlString=[[NSString alloc]init];;
//
//    if ([comestr isEqualToString:@"ESC\nEscalated"])
//     {
//        urlString = [[NSString alloc]initWithFormat:@"%@getescphead.php?",[prefs objectForKey:@"Link"]];
//         keystr=@"";
//         [params setObject:@"escphead"  forKey:@"requestType"];
//    }
//    else
//    {
//        urlString = [[NSString alloc]initWithFormat:@"%@getretphead.php?",[prefs objectForKey:@"Link"]];
//        keystr=@"retphead";
//        [params setObject:@"getretpHead"  forKey:@"requestType"];
//    }
//    [indicator startAnimating];
//
//    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        _teamarr=[[NSMutableArray alloc]init];
//        NSLog(@"JSON: %@", userDict);
//        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//        _teamarr=[dic objectForKey:keystr];
//        if (_teamarr.count==0) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data avaible"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        [indicator stopAnimating];
//        [self createview];
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [indicator stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
//}
//-(void)getbac
//{
//
//    bookingarr=[[NSMutableArray alloc]init];
//    NSString * keystr;
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
//
//    NSString* urlString=[[NSString alloc]init];;
//    if ([comestr isEqualToString:@"ESC\nEscalated"])
//    {
//        urlString = [[NSString alloc]initWithFormat:@"%@getescpitem.php?",[prefs objectForKey:@"Link"]];
//        keystr=@"escpitem";
//        [params setObject:@"getescpItem"  forKey:@"requestType"];
//    }
//    else
//    {
//        urlString = [[NSString alloc]initWithFormat:@"%@getretpitem.php?",[prefs objectForKey:@"Link"]];
//        keystr=@"retpitem";
//        [params setObject:@"getretpItem"  forKey:@"requestType"];
//    }
//    [indicator startAnimating];
//    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        bookingarr=[[NSMutableArray alloc]init];
//        NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
//                                                      length:[responseObject length] encoding: NSUTF8StringEncoding];
//        //  NSLog(@"content %@",content);
//
//        NSLog(@"JSON: %@", userDict);
//        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//        bookingarr=[dic objectForKey:keystr];
//        [indicator stopAnimating];
//        [tableViewHome reloadData];
//        if (bookingarr.count==0) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [indicator stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
//}
//-(void)createview
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    [teamtableview removeFromSuperview];
//    teamtableview = [[UIScrollView alloc] init];
//    [teamtableview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.20, screenRect.size.width,screenRect.size.height*.79)];
//    teamtableview.bounces = NO;
//    teamtableview.backgroundColor=[UIColor clearColor];
//    teamtableview.delegate = self;
//    [self.view addSubview:teamtableview];
//
//    int hig=screenRect.size.height*0.00;
//    {
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*2.25,screenRect.size.height*0.07)];
//        headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
//
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
//        lineView.backgroundColor = [UIColor lightGrayColor];
//        [headerView addSubview:lineView];
//
//        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
//        //    lineView2.backgroundColor = [UIColor grayColor];
//        //    [headerView addSubview:lineView2];
//
//        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
//        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//        Srnolbl.textAlignment = NSTextAlignmentCenter;
//        Srnolbl.text = @"Emp Name";
//        Srnolbl.backgroundColor = [UIColor clearColor];
//        Srnolbl.textColor=[UIColor blackColor];
//        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
//        Srnolbl.numberOfLines = 0;
//        [[Srnolbl layer] setBorderWidth:1.0f];
//        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
//        [headerView addSubview:Srnolbl];
//
//        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
//        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        namelbl.textAlignment = NSTextAlignmentCenter;
//        namelbl.text = @"NO TOTAL CASE";
//        namelbl.backgroundColor = [UIColor clearColor];
//        namelbl.textColor=[UIColor blackColor];
//        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        namelbl.numberOfLines = 0;
//        [[namelbl layer] setBorderWidth:1.0f];
//        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
//        [headerView addSubview:namelbl];
//
//        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        datelbl.textAlignment = NSTextAlignmentCenter;
//        datelbl.text = @"AV TOTAL CASE";
//        datelbl.backgroundColor = [UIColor clearColor];
//        datelbl.textColor=[UIColor blackColor];
//        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        [[datelbl layer] setBorderWidth:1.0f];
//        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        datelbl.numberOfLines = 0;
//        [headerView addSubview:datelbl];
//
//        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        cashlbl.textAlignment = NSTextAlignmentCenter;
//        cashlbl.text = @"NO DONE CASE";
//        cashlbl.backgroundColor = [UIColor clearColor];
//        cashlbl.textColor=[UIColor blackColor];
//        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
//        [[cashlbl layer] setBorderWidth:1.0f];
//        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
//        cashlbl.numberOfLines = 0;
//        [headerView addSubview:cashlbl];
//
//        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        expencelbl.textAlignment = NSTextAlignmentCenter;
//        expencelbl.text = @"AV DONE CASE";
//        expencelbl.backgroundColor = [UIColor clearColor];
//        expencelbl.textColor=[UIColor blackColor];
//        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        [[expencelbl layer] setBorderWidth:1.0f];
//        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        expencelbl.numberOfLines = 0;
//        [headerView addSubview:expencelbl];
//
//
//        UILabel*  OCramt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.25,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        OCramt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        OCramt.textAlignment = NSTextAlignmentCenter;
//        OCramt.text = @"NO TBD CASE";
//        OCramt.backgroundColor = [UIColor clearColor];
//        OCramt.textColor=[UIColor blackColor];
//        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
//        [[OCramt layer] setBorderWidth:1.0f];
//        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
//        OCramt.numberOfLines = 0;
//        [headerView addSubview:OCramt];
//        [teamtableview addSubview:headerView];
//
//        UILabel* avtbdcases  = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.5,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        avtbdcases.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        avtbdcases.textAlignment = NSTextAlignmentCenter;
//        avtbdcases.text = @"AV TBD CASE";
//        avtbdcases.backgroundColor = [UIColor clearColor];
//        avtbdcases.textColor=[UIColor blackColor];
//        avtbdcases.lineBreakMode = NSLineBreakByWordWrapping;
//        [[avtbdcases layer] setBorderWidth:1.0f];
//        avtbdcases.lineBreakMode = NSLineBreakByWordWrapping;
//        avtbdcases.numberOfLines = 0;
//        [headerView addSubview:avtbdcases];
//        [teamtableview addSubview:headerView];
//
//        UILabel*  nocancase = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        nocancase.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        nocancase.textAlignment = NSTextAlignmentCenter;
//        nocancase.text = @"NO CAN CASE";
//        nocancase.backgroundColor = [UIColor clearColor];
//        nocancase.textColor=[UIColor blackColor];
//        nocancase.lineBreakMode = NSLineBreakByWordWrapping;
//        [[nocancase layer] setBorderWidth:1.0f];
//        nocancase.lineBreakMode = NSLineBreakByWordWrapping;
//        nocancase.numberOfLines = 0;
//        [headerView addSubview:nocancase];
//        [teamtableview addSubview:headerView];
//
//        UILabel*  avcancase = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*2.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        avcancase.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        avcancase.textAlignment = NSTextAlignmentCenter;
//        avcancase.text = @"AV CAN CASE";
//        avcancase.backgroundColor = [UIColor clearColor];
//        avcancase.textColor=[UIColor blackColor];
//        avcancase.lineBreakMode = NSLineBreakByWordWrapping;
//        [[avcancase layer] setBorderWidth:1.0f];
//        avcancase.lineBreakMode = NSLineBreakByWordWrapping;
//        avcancase.numberOfLines = 0;
//        [headerView addSubview:avcancase];
//        [teamtableview addSubview:headerView];
//        if ([comestr isEqualToString:@"ESC\nEscalated"])
//        {
//            nocancase.text = @"NO RET CASEE";
//            avcancase.text = @"AV RET CASE";
//        }
//    }
//    hig=hig+screenRect.size.height*0.07;
//    for (int i=0; i<_teamarr.count; i++) {
//
//        NSMutableDictionary *dict=[_teamarr objectAtIndex:i];
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width*2.25,screenRect.size.height*0.07)];
//        headerView.backgroundColor=[UIColor whiteColor];
//
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
//        lineView.backgroundColor = [UIColor clearColor];
//        [headerView addSubview:lineView];
//
//        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
//        //    lineView2.backgroundColor = [UIColor grayColor];
//        //    [headerView addSubview:lineView2];
//
//        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
//        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//        Srnolbl.textAlignment = NSTextAlignmentCenter;
//        Srnolbl.text = [dict objectForKey:@"sr_empname"];
//        Srnolbl.backgroundColor = [UIColor clearColor];
//        Srnolbl.textColor=[UIColor blackColor];
//        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
//        Srnolbl.numberOfLines = 0;
//        [[Srnolbl layer] setBorderWidth:1.0f];
//        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
//        [headerView addSubview:Srnolbl];
//
//        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
//        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        namelbl.textAlignment = NSTextAlignmentCenter;
//        namelbl.text =[dict objectForKey:@"no_total_case"];
//        namelbl.backgroundColor = [UIColor clearColor];
//        namelbl.textColor=[UIColor blackColor];
//        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        namelbl.numberOfLines = 0;
//        [[namelbl layer] setBorderWidth:1.0f];
//        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
//        [headerView addSubview:namelbl];
//
//        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        datelbl.textAlignment = NSTextAlignmentCenter;
//        datelbl.text =[dict objectForKey:@"av_total_case"];
//        datelbl.backgroundColor = [UIColor clearColor];
//        datelbl.textColor=[UIColor blackColor];
//        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        [[datelbl layer] setBorderWidth:1.0f];
//        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        datelbl.numberOfLines = 0;
//        [headerView addSubview:datelbl];
//
//        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        cashlbl.textAlignment = NSTextAlignmentCenter;
//        float value=[[dict objectForKey:@"bac_balance"]floatValue]+[[dict objectForKey:@"ocr_balance"]floatValue];
//        cashlbl.text = [dict objectForKey:@"no_done_case"];
//        cashlbl.backgroundColor = [UIColor clearColor];
//        cashlbl.textColor=[UIColor blackColor];
//        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
//        [[cashlbl layer] setBorderWidth:1.0f];
//        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
//        cashlbl.numberOfLines = 0;
//        [headerView addSubview:cashlbl];
//
//        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        expencelbl.textAlignment = NSTextAlignmentCenter;
//        expencelbl.text =[dict objectForKey:@"av_done_case"];
//        expencelbl.backgroundColor = [UIColor clearColor];
//        expencelbl.textColor=[UIColor blackColor];
//        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        [[expencelbl layer] setBorderWidth:1.0f];
//        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
//        expencelbl.numberOfLines = 0;
//        [headerView addSubview:expencelbl];
//
//        UILabel*  OCramt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.25,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        OCramt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        OCramt.textAlignment = NSTextAlignmentCenter;
//        OCramt.text =[dict objectForKey:@"no_tbd_case"];
//        OCramt.backgroundColor = [UIColor clearColor];
//        OCramt.textColor=[UIColor blackColor];
//        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
//        [[OCramt layer] setBorderWidth:1.0f];
//        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
//        OCramt.numberOfLines = 0;
//        [headerView addSubview:OCramt];
//        [teamtableview addSubview:headerView];
//        hig=hig+screenRect.size.height*0.07;
//
//        UILabel* avtbdcases  = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.5,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        avtbdcases.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        avtbdcases.textAlignment = NSTextAlignmentCenter;
//        avtbdcases.text =[dict objectForKey:@"av_tbd_case"];
//        avtbdcases.backgroundColor = [UIColor clearColor];
//        avtbdcases.textColor=[UIColor blackColor];
//        avtbdcases.lineBreakMode = NSLineBreakByWordWrapping;
//        [[avtbdcases layer] setBorderWidth:1.0f];
//        avtbdcases.lineBreakMode = NSLineBreakByWordWrapping;
//        avtbdcases.numberOfLines = 0;
//        [headerView addSubview:avtbdcases];
//        [teamtableview addSubview:headerView];
//
//        UILabel*  nocancase = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*1.75,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        nocancase.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        nocancase.textAlignment = NSTextAlignmentCenter;
//        nocancase.text = [dict objectForKey:@"no_can_case"];
//        nocancase.backgroundColor = [UIColor clearColor];
//        nocancase.textColor=[UIColor blackColor];
//        nocancase.lineBreakMode = NSLineBreakByWordWrapping;
//        [[nocancase layer] setBorderWidth:1.0f];
//        nocancase.lineBreakMode = NSLineBreakByWordWrapping;
//        nocancase.numberOfLines = 0;
//        [headerView addSubview:nocancase];
//        [teamtableview addSubview:headerView];
//
//        UILabel*  avcancase = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*2.0,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
//        avcancase.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
//        avcancase.textAlignment = NSTextAlignmentCenter;
//        avcancase.text = [dict objectForKey:@"av_can_case"];
//        avcancase.backgroundColor = [UIColor clearColor];
//        avcancase.textColor=[UIColor blackColor];
//        avcancase.lineBreakMode = NSLineBreakByWordWrapping;
//        [[avcancase layer] setBorderWidth:1.0f];
//        avcancase.lineBreakMode = NSLineBreakByWordWrapping;
//        avcancase.numberOfLines = 0;
//        [headerView addSubview:avcancase];
//        [teamtableview addSubview:headerView];
//        if ([comestr isEqualToString:@"ESC\nEscalated"])
//        {
//            nocancase.text = [dict objectForKey:@"no_ret_case"];
//            avcancase.text = [dict objectForKey:@"av_ret_case"];
//        }
//
//    }
//    teamtableview.contentSize = CGSizeMake(screenRect.size.width*2.25, hig);
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (tableView==tableViewHome) {
//        return bookingarr.count;
//    }
//    else
//    {
//        return 0;
//    }
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//
//    NSDictionary *dict=[bookingarr objectAtIndex:indexPath.row];
//    static NSString *MyIdentifier = @"MyIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//
//
//    if (tableView==tableViewHome) {
//
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:MyIdentifier];
//        if ([comestr isEqualToString:@"ESC\nEscalated"])
//        {
//            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.32)];
//            headerView.backgroundColor=[UIColor whiteColor];
//            headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
//            headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
//            headerView.layer.shadowOpacity = 1.0f;
//            headerView.layer.shadowRadius = 0.0f;
//            headerView.layer.masksToBounds = NO;
//            headerView.backgroundColor=[UIColor whiteColor];
//
//            UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            Srnolbl.textAlignment = NSTextAlignmentLeft;
//            Srnolbl.text =[NSString stringWithFormat:@"Proj Name"];
//            Srnolbl.backgroundColor = [UIColor clearColor];
//            Srnolbl.textColor=[UIColor blackColor];
//            Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
//            Srnolbl.numberOfLines = 0;
//            [headerView addSubview:Srnolbl];
//
//            UILabel*  projectlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            projectlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            projectlbl.textAlignment = NSTextAlignmentLeft;
//            projectlbl.text =[dict objectForKey:@"proj_name"];
//            projectlbl.backgroundColor = [UIColor clearColor];
//            projectlbl.textColor=[UIColor blackColor];
//            projectlbl.lineBreakMode = NSLineBreakByWordWrapping;
//            projectlbl.numberOfLines = 0;
//
//            [headerView addSubview:projectlbl];
//
//            UILabel*  Unitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.0,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            Unitlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            Unitlbl.textAlignment = NSTextAlignmentLeft;
//            Unitlbl.text =[NSString stringWithFormat:@"Unit no"];
//            Unitlbl.backgroundColor = [UIColor clearColor];
//            Unitlbl.textColor=[UIColor blackColor];
//            Unitlbl.lineBreakMode = NSLineBreakByWordWrapping;
//            Unitlbl.numberOfLines = 0;
//            [headerView addSubview:Unitlbl];
//
//            UILabel*  unit2lbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            unit2lbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            unit2lbl.textAlignment = NSTextAlignmentLeft;
//            unit2lbl.text =[dict objectForKey:@"unit_no"];
//            unit2lbl.backgroundColor = [UIColor clearColor];
//            unit2lbl.textColor=[UIColor blackColor];
//            unit2lbl.lineBreakMode = NSLineBreakByWordWrapping;
//            unit2lbl.numberOfLines = 0;
//            [headerView addSubview:unit2lbl];
//
//            UILabel*  tottalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            tottalbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            tottalbl.textAlignment = NSTextAlignmentLeft;
//            tottalbl.text =[NSString stringWithFormat:@"Agreement value"];
//            tottalbl.backgroundColor = [UIColor clearColor];
//            tottalbl.textColor=[UIColor blackColor];
//            tottalbl.lineBreakMode = NSLineBreakByWordWrapping;
//            tottalbl.numberOfLines = 0;
//            [headerView addSubview:tottalbl];
//
//            UILabel*  totalcoll2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            totalcoll2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            totalcoll2.textAlignment = NSTextAlignmentLeft;
//            totalcoll2.text =[dict objectForKey:@"agvalue"];
//            totalcoll2.backgroundColor = [UIColor clearColor];
//            totalcoll2.textColor=[UIColor blackColor];
//            totalcoll2.lineBreakMode = NSLineBreakByWordWrapping;
//            totalcoll2.numberOfLines = 0;
//            [headerView addSubview:totalcoll2];
//
//            UILabel*  balancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            balancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            balancelbl.textAlignment = NSTextAlignmentLeft;
//            balancelbl.text =[NSString stringWithFormat:@"Scheme"];
//            balancelbl.backgroundColor = [UIColor clearColor];
//            balancelbl.textColor=[UIColor blackColor];
//            balancelbl.lineBreakMode = NSLineBreakByWordWrapping;
//            balancelbl.numberOfLines = 0;
//            [headerView addSubview:balancelbl];
//
//            UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            balancelbl2.textAlignment = NSTextAlignmentLeft;
//            balancelbl2.text =[dict objectForKey:@"scheme"];
//            balancelbl2.backgroundColor = [UIColor clearColor];
//            balancelbl2.textColor=[UIColor blackColor];
//            balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
//            balancelbl2.numberOfLines = 0;
//            [headerView addSubview:balancelbl2];
//
//            UILabel*  baclbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            baclbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            baclbl.textAlignment = NSTextAlignmentLeft;
//            baclbl.text =[NSString stringWithFormat:@"ESC Date"];
//            baclbl.backgroundColor = [UIColor clearColor];
//            baclbl.textColor=[UIColor blackColor];
//            baclbl.lineBreakMode = NSLineBreakByWordWrapping;
//            baclbl.numberOfLines = 0;
//            [headerView addSubview:baclbl];
//
//            UILabel*  baclbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            baclbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            baclbl2.textAlignment = NSTextAlignmentLeft;
//            baclbl2.text =[dict objectForKey:@"bkdate"];
//            baclbl2.backgroundColor = [UIColor clearColor];
//            baclbl2.textColor=[UIColor blackColor];
//            baclbl2.lineBreakMode = NSLineBreakByWordWrapping;
//            baclbl2.numberOfLines = 0;
//            [headerView addSubview:baclbl2];
//
//            UILabel*  baclbalance = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            baclbalance.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            baclbalance.textAlignment = NSTextAlignmentLeft;
//            baclbalance.text =[NSString stringWithFormat:@"ESC Escalated to"];
//            baclbalance.backgroundColor = [UIColor clearColor];
//            baclbalance.textColor=[UIColor blackColor];
//            baclbalance.lineBreakMode = NSLineBreakByWordWrapping;
//            baclbalance.numberOfLines = 0;
//            [headerView addSubview:baclbalance];
//
//            UILabel*  baclbalance2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            baclbalance2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            baclbalance2.textAlignment = NSTextAlignmentLeft;
//            baclbalance2.text =[dict objectForKey:@"ret_to_empname"];
//            baclbalance2.backgroundColor = [UIColor clearColor];
//            baclbalance2.textColor=[UIColor blackColor];
//            baclbalance2.lineBreakMode = NSLineBreakByWordWrapping;
//            baclbalance2.numberOfLines = 0;
//            [headerView addSubview:baclbalance2];
//
//            UILabel*  custlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.24,screenRect.size.width*0.70,screenRect.size.height*0.04)];
//            custlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            custlbl.textAlignment = NSTextAlignmentLeft;
//            custlbl.text =[NSString stringWithFormat:@"Customer Name"];
//            custlbl.backgroundColor = [UIColor clearColor];
//            custlbl.textColor=[UIColor blackColor];
//            custlbl.lineBreakMode = NSLineBreakByWordWrapping;
//            custlbl.numberOfLines = 0;
//            [headerView addSubview:custlbl];
//
//            UILabel*  custlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.28,screenRect.size.width*0.70,screenRect.size.height*0.035)];
//            custlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            custlbl2.textAlignment = NSTextAlignmentLeft;
//            custlbl2.text =[dict objectForKey:@"name1"];
//            custlbl2.backgroundColor = [UIColor clearColor];
//            custlbl2.textColor=[UIColor blackColor];
//            custlbl2.lineBreakMode = NSLineBreakByWordWrapping;
//            custlbl2.numberOfLines = 0;
//            [headerView addSubview:custlbl2];
//
//            [cell.contentView addSubview:headerView];
//        }
//        else
//        {
//            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.24)];
//            headerView.backgroundColor=[UIColor whiteColor];
//            headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
//            headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
//            headerView.layer.shadowOpacity = 1.0f;
//            headerView.layer.shadowRadius = 0.0f;
//            headerView.layer.masksToBounds = NO;
//            headerView.backgroundColor=[UIColor whiteColor];
//
//            UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            Srnolbl.textAlignment = NSTextAlignmentLeft;
//            Srnolbl.text =[NSString stringWithFormat:@"Proj Name"];
//            Srnolbl.backgroundColor = [UIColor clearColor];
//            Srnolbl.textColor=[UIColor blackColor];
//            Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
//            Srnolbl.numberOfLines = 0;
//            [headerView addSubview:Srnolbl];
//
//            UILabel*  projectlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            projectlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            projectlbl.textAlignment = NSTextAlignmentLeft;
//            projectlbl.text =[dict objectForKey:@"proj_name"];
//            projectlbl.backgroundColor = [UIColor clearColor];
//            projectlbl.textColor=[UIColor blackColor];
//            projectlbl.lineBreakMode = NSLineBreakByWordWrapping;
//            projectlbl.numberOfLines = 0;
//
//            [headerView addSubview:projectlbl];
//
//            UILabel*  Unitlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.0,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            Unitlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            Unitlbl.textAlignment = NSTextAlignmentLeft;
//            Unitlbl.text =[NSString stringWithFormat:@"Unit no"];
//            Unitlbl.backgroundColor = [UIColor clearColor];
//            Unitlbl.textColor=[UIColor blackColor];
//            Unitlbl.lineBreakMode = NSLineBreakByWordWrapping;
//            Unitlbl.numberOfLines = 0;
//            [headerView addSubview:Unitlbl];
//
//            UILabel*  unit2lbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.04,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            unit2lbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            unit2lbl.textAlignment = NSTextAlignmentLeft;
//            unit2lbl.text =[dict objectForKey:@"unit_no"];
//            unit2lbl.backgroundColor = [UIColor clearColor];
//            unit2lbl.textColor=[UIColor blackColor];
//            unit2lbl.lineBreakMode = NSLineBreakByWordWrapping;
//            unit2lbl.numberOfLines = 0;
//            [headerView addSubview:unit2lbl];
//
//            UILabel*  tottalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            tottalbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            tottalbl.textAlignment = NSTextAlignmentLeft;
//            tottalbl.text =[NSString stringWithFormat:@"Agreement value"];
//            tottalbl.backgroundColor = [UIColor clearColor];
//            tottalbl.textColor=[UIColor blackColor];
//            tottalbl.lineBreakMode = NSLineBreakByWordWrapping;
//            tottalbl.numberOfLines = 0;
//            [headerView addSubview:tottalbl];
//
//            UILabel*  totalcoll2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            totalcoll2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            totalcoll2.textAlignment = NSTextAlignmentLeft;
//            totalcoll2.text =[dict objectForKey:@"agvalue"];
//            totalcoll2.backgroundColor = [UIColor clearColor];
//            totalcoll2.textColor=[UIColor blackColor];
//            totalcoll2.lineBreakMode = NSLineBreakByWordWrapping;
//            totalcoll2.numberOfLines = 0;
//            [headerView addSubview:totalcoll2];
//
//            UILabel*  balancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
//            balancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            balancelbl.textAlignment = NSTextAlignmentLeft;
//            balancelbl.text =[NSString stringWithFormat:@"Scheme"];
//            balancelbl.backgroundColor = [UIColor clearColor];
//            balancelbl.textColor=[UIColor blackColor];
//            balancelbl.lineBreakMode = NSLineBreakByWordWrapping;
//            balancelbl.numberOfLines = 0;
//            [headerView addSubview:balancelbl];
//
//            UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
//            balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            balancelbl2.textAlignment = NSTextAlignmentLeft;
//            balancelbl2.text =[dict objectForKey:@"scheme"];
//            balancelbl2.backgroundColor = [UIColor clearColor];
//            balancelbl2.textColor=[UIColor blackColor];
//            balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
//            balancelbl2.numberOfLines = 0;
//            [headerView addSubview:balancelbl2];
//
//
//            UILabel*  custlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.16,screenRect.size.width*0.70,screenRect.size.height*0.04)];
//            custlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
//            custlbl.textAlignment = NSTextAlignmentLeft;
//            custlbl.text =[NSString stringWithFormat:@"Customer Name"];
//            custlbl.backgroundColor = [UIColor clearColor];
//            custlbl.textColor=[UIColor blackColor];
//            custlbl.lineBreakMode = NSLineBreakByWordWrapping;
//            custlbl.numberOfLines = 0;
//            [headerView addSubview:custlbl];
//
//            UILabel*  custlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.70,screenRect.size.height*0.035)];
//            custlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
//            custlbl2.textAlignment = NSTextAlignmentLeft;
//            custlbl2.text =[dict objectForKey:@"name1"];
//            custlbl2.backgroundColor = [UIColor clearColor];
//            custlbl2.textColor=[UIColor blackColor];
//            custlbl2.lineBreakMode = NSLineBreakByWordWrapping;
//            custlbl2.numberOfLines = 0;
//            [headerView addSubview:custlbl2];
//
//            [cell.contentView addSubview:headerView];
//        }
//    }
//    cell.textLabel.textAlignment = NSTextAlignmentLeft;
//    cell.contentMode= UIViewContentModeLeft;
//
//    cell.backgroundColor = [UIColor clearColor];
//    [cell.contentView setBackgroundColor:[UIColor clearColor]];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    LeadViewController *mainvc=[[LeadViewController alloc] initWithNibName:@"LeadViewController" bundle:nil];
//    //    [self.navigationController pushViewController:mainvc animated:YES];
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    if (tableView==tableViewHome)
//    {
//        if ([comestr isEqualToString:@"ESC\nEscalated"])
//        {
//            return screenRect.size.height*0.33;
//        }
//        else
//        return screenRect.size.height*0.25;
//    }
//    else
//    {
//        return screenRect.size.height*0.0;
//    }
//}
//
//-(void)remark:(UIButton*)btn
//{
//    index=btn.tag;
//    [TakePhotoView removeFromSuperview];
//    TakePhotoView = [[CustomIOS7AlertView alloc] init];
//    [TakePhotoView setContainerView:[self signImageSetAlert]];
//    [TakePhotoView setDelegate:self];
//    [TakePhotoView setUseMotionEffects:true];
//    [TakePhotoView show];
//}
//-(UIView *)signImageSetAlert{
//    NSDictionary *dict=[bookingarr objectAtIndex:index];
//    int heig=0;
//    heig=150;
//    if ([dict objectForKey:@"REMARK1"]==nil) {
//        NSString* positionstr2;
//    }
//
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    demoView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 300,310)];
//    [demoView setBackgroundColor:[UIColor whiteColor]];
//    demoView.layer.cornerRadius=5;
//    [demoView.layer setMasksToBounds:YES];
//    [demoView.layer setBorderWidth:1.0];
//    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
//
//    UILabel* aboutmelbl = [[UILabel alloc] init];
//    [aboutmelbl setFrame:CGRectMake(20, 0, 250, 40)];
//    aboutmelbl.textAlignment = NSTextAlignmentLeft;
//    aboutmelbl.backgroundColor=[UIColor clearColor];
//    [aboutmelbl setTextColor: [UIColor blackColor]];
//    [demoView addSubview:aboutmelbl];
//    aboutmelbl.lineBreakMode = NSLineBreakByWordWrapping;
//    aboutmelbl.numberOfLines = 0;
//    UIFont *text1Font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
//    NSString* positionstr1=@"Remark1:- ";
//    NSString* positionstr2= ([dict objectForKey:@"remark1"]==nil)? @"":[dict objectForKey:@"remark1"];
//    NSMutableAttributedString *attributedString1 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
//    UIFont *text2Font2 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
//    NSMutableAttributedString *attributedString2 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [attributedString1 appendAttributedString:attributedString2];
//    aboutmelbl.attributedText = attributedString1;
//
//    UILabel* remark2lbl = [[UILabel alloc] init];
//    [remark2lbl setFrame:CGRectMake(20, 40, 250, 40)];
//    remark2lbl.textAlignment = NSTextAlignmentLeft;
//    remark2lbl.backgroundColor=[UIColor clearColor];
//    [remark2lbl setTextColor: [UIColor blackColor]];
//    [demoView addSubview:remark2lbl];
//    remark2lbl.lineBreakMode = NSLineBreakByWordWrapping;
//    remark2lbl.numberOfLines = 0;
//    NSString* positionstr3=@"Remark2:-";
//    NSString*  positionstr4 = ([dict objectForKey:@"remark2"]==nil) ? @"" : [dict objectForKey:@"remark2"];
//    NSMutableAttributedString *attributedString3 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr3 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
//    NSMutableAttributedString *attributedString4 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr4 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [attributedString3 appendAttributedString:attributedString4];
//    remark2lbl.attributedText = attributedString3;
//
//    UILabel* remark3lbl = [[UILabel alloc] init];
//    [remark3lbl setFrame:CGRectMake(20, 80, 250, 40)];
//    remark3lbl.textAlignment = NSTextAlignmentLeft;
//    remark3lbl.backgroundColor=[UIColor clearColor];
//    [remark3lbl setTextColor: [UIColor blackColor]];
//    [demoView addSubview:remark3lbl];
//    remark3lbl.lineBreakMode = NSLineBreakByWordWrapping;
//    remark3lbl.numberOfLines = 0;
//    NSString* positionstr5=@"Remark3:-";
//    NSString* positionstr6=([dict objectForKey:@"remark3"]==nil) ? @"" : [dict objectForKey:@"remark3"];
//    NSMutableAttributedString *attributedString5 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr5 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
//    NSMutableAttributedString *attributedString6 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr6 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [attributedString5 appendAttributedString:attributedString6];
//    remark3lbl.attributedText = attributedString5;
//
//    UILabel* remark4lbl = [[UILabel alloc] init];
//    [remark4lbl setFrame:CGRectMake(20, 120, 250, 40)];
//    remark4lbl.textAlignment = NSTextAlignmentLeft;
//    remark4lbl.backgroundColor=[UIColor clearColor];
//    [remark4lbl setTextColor: [UIColor blackColor]];
//    [demoView addSubview:remark4lbl];
//    remark4lbl.lineBreakMode = NSLineBreakByWordWrapping;
//    remark4lbl.numberOfLines = 0;
//    NSString* positionstr7=@"Remark4:-";
//    NSString* positionstr8=([dict objectForKey:@"remark4"]==nil) ? @"" : [dict objectForKey:@"remark4"];
//    NSMutableAttributedString *attributedString7 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
//    NSMutableAttributedString *attributedString8 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [attributedString7 appendAttributedString:attributedString8];
//    remark4lbl.attributedText = attributedString7;
//
//    UILabel* remark5lbl = [[UILabel alloc] init];
//    [remark5lbl setFrame:CGRectMake(20, 160, 250, 40)];
//    remark5lbl.textAlignment = NSTextAlignmentLeft;
//    remark5lbl.backgroundColor=[UIColor clearColor];
//    [remark5lbl setTextColor: [UIColor blackColor]];
//    [demoView addSubview:remark5lbl];
//    remark5lbl.lineBreakMode = NSLineBreakByWordWrapping;
//    remark5lbl.numberOfLines = 0;
//    NSString* positionstr9=@"Remark5:-";
//    NSString* positionstr10=([dict objectForKey:@"remark5"]==nil) ? @"" : [dict objectForKey:@"remark5"];
//    NSMutableAttributedString *attributedString9 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr9 attributes:@{NSFontAttributeName : text1Font1,NSForegroundColorAttributeName:[UIColor blackColor]}];
//    NSMutableAttributedString *attributedString10 =
//    [[NSMutableAttributedString alloc] initWithString:positionstr10 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [attributedString9 appendAttributedString:attributedString10];
//    remark5lbl.attributedText = attributedString9;
//
//    remarktxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,200,280,40)];
//    remarktxt.textAlignment=NSTextAlignmentLeft;
//    remarktxt.delegate = self;
//    remarktxt.textColor=[UIColor blackColor];
//    [remarktxt setBackgroundColor:[UIColor clearColor]];
//    remarktxt.leftViewMode = UITextFieldViewModeAlways;
//    [remarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
//    remarktxt.returnKeyType=UIReturnKeyDone;
//    remarktxt.selectedLineColor = [UIColor redColor];
//    remarktxt.selectedPlaceHolderColor = [UIColor redColor];
//    remarktxt.placeHolderColor = [UIColor grayColor];
//    remarktxt.placeholder=@"Remark";
//    remarktxt.font = [UIFont systemFontOfSize:14];
//    [demoView addSubview:remarktxt];
//
//    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,250,125,40)];
//    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(closeAlert:) forControlEvents:UIControlEventTouchUpInside];
//    cancelBtn.font=[UIFont systemFontOfSize:14];
//    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
//    cancelBtn.tag=5;
//    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
//    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
//    cancelBtn.layer.borderWidth = 0.5;
//    [demoView addSubview:cancelBtn];
//
//    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,250,125,40)];
//    [savebtn setTitle:@"Submit" forState:UIControlStateNormal];
//    [savebtn addTarget:self action:@selector(submit)
//      forControlEvents:UIControlEventTouchUpInside];
//    savebtn.font=[UIFont systemFontOfSize:14];
//    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
//    [savebtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
//    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [savebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    savebtn.layer.borderColor = [UIColor grayColor].CGColor;
//    savebtn.layer.borderWidth = 0.5;
//    [demoView addSubview:savebtn];
//
//    return demoView;
//}
//-(void)submit
//{
//    NSDictionary *dict=[bookingarr objectAtIndex:index];
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:remarktxt.text  forKey:@"remark"];
//    [params setObject:[dict objectForKey:@"bknum"]  forKey:@"bookingno"];
//    NSString*   urlString;
//
//    if ([comestr isEqualToString:@"Retention"])
//        urlString = [[NSString alloc]initWithFormat:@"%@updateret.php?",[prefs objectForKey:@"Link"]];
//    else
//        urlString = [[NSString alloc]initWithFormat:@"%@updateesc.php?",[prefs objectForKey:@"Link"]];
//
//    // NSString*   urlString=@"http://13.126.129.245/xrbia/mobilecrm/cp/updatebcac.php?";
//    UIActivityIndicatorView *actvityindicatior = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    actvityindicatior.frame = CGRectMake(20, 120, 250, 40);
//    [demoView addSubview:actvityindicatior];
//    [actvityindicatior bringSubviewToFront:TakePhotoView];
//
//    [actvityindicatior startAnimating];
//
//    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"JSON: %@", userDict);
//        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//        if ([[userDict objectForKey:@"status"]integerValue]==1){
//            [TakePhotoView close];
//        }
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [actvityindicatior stopAnimating];
//        [self getbac];
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [actvityindicatior stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
//}
//-(void)closeAlert:(id)sender{
//    [TakePhotoView close];
//}
//
//-(void)openurl:(UIButton*)btn
//{
//
//    NSDictionary *dict=[bookingarr objectAtIndex:btn.tag];
//    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dict objectForKey:@"phone_mobile"]]]];
//
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"xrbia"  forKey:@"userName"];
//    [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
//    [params setObject:[dict objectForKey:@"mobile"] forKey:@"custNumber"];
//    [params setObject:[prefs objectForKey:@"user_name"] forKey:@"phoneName"];
//    [params setObject:[prefs objectForKey:@"did_no"] forKey:@"did"];
//    [params setObject:@"1000" forKey:@"callLimit"];
//    [params setObject:@"sap_test" forKey:@"uui"];
//    //
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [indicator startAnimating];
//    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//
//        NSLog(@"JSON: %@", userDict);
//
//        if ([[userDict objectForKey:@"status"]isEqualToString:@"queued"]) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"status"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        [indicator stopAnimating];
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [indicator stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
//
//}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//}

//- (IBAction)btnSalesClicked:(id)sender {
//    SalesVC *ObjSalesVC = [[SalesVC alloc] initWithNibName:@"SalesVC" bundle:nil];
//
//    [[self navigationController] pushViewController:ObjSalesVC animated:YES];
//}
- (IBAction)btnBACClicked:(id)sender {
  
    TodayBookingBACVC *vc2 = [[TodayBookingBACVC alloc] initWithNibName:@"TodayBookingBACVC" bundle:nil];
    
    [[self navigationController] pushViewController:vc2 animated:YES];
}
//- (IBAction)btnOCRClicked:(id)sender {
//}
//- (IBAction)btnSDCClicked:(id)sender {
//}
//- (IBAction)btnBackClicked:(id)sender {
//    [self.navigationController popViewControllerAnimated:true];
//}
- (IBAction)btnOCRClicked:(id)sender {
    TodayBookingBACVC *vc2 = [[TodayBookingBACVC alloc] initWithNibName:@"TodayBookingBACVC" bundle:nil];
    vc2.ocrStr = @"OCRStr";
    [[self navigationController] pushViewController:vc2 animated:YES];
    
}
- (IBAction)btnSDCClicked:(id)sender {
    TodayBookingBACVC *vc = [[TodayBookingBACVC alloc] initWithNibName:@"TodayBookingBACVC" bundle:nil];
    vc.sdcStr = @"SDCStr";
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction)btnSalesClicked:(id)sender {
    SalesVC *Objvc = [[SalesVC alloc] initWithNibName:@"SalesVC" bundle:nil];
   
    [[self navigationController] pushViewController:Objvc animated:YES];
}

@end
