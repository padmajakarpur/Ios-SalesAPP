//
//  PerformanceViewController.m
//  Sales App
//
//  Created by Infinitum on 21/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "PerformanceViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface PerformanceViewController ()

@end
@implementation PerformanceViewController
@synthesize tableViewHome,indicator,teamtableview;
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
        horizontallbl.text=@"MPS";
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    //[self.view addSubview:backgroundview];
    
    teamtableview = [[UIScrollView alloc] init];
    [teamtableview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.12, screenRect.size.width,screenRect.size.height*.88)];
    teamtableview.backgroundColor=[UIColor clearColor];
    teamtableview.delegate = self;
    teamtableview.bounces=NO;
    [self.view addSubview:teamtableview];
    
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
  //  [self getview];
    
        _teamarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        
        // [params setObject:@"e79e4496-95eb-dba6-d86c-599acc022070"  forKey:@"empid"];
        [params setObject:@"H"  forKey:@"mode"];
    NSString * urlString = [[NSString alloc]initWithFormat:@"%@getPerformanceData.php",[prefs objectForKey:@"Link"]];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"empid"];
     NSString *    keystr=@"performance";    
        [indicator startAnimating];
        
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            _teamarr=[[NSMutableArray alloc]init];
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            _teamarr=[dic objectForKey:keystr];
            [self getview];
            [indicator stopAnimating];
        }
             failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
}
-(void)getview
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
