//
//  BACViewController.m
//  Sales App
//
//  Created by Infinitum on 09/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BACViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"
#import "CollectChequeViewController.h"
@interface BACViewController ()

@end
@implementation BACViewController
@synthesize tableViewHome,indicator,bgview,demoView,projectpicker,projectoolbar,projectstr,projectarr,projectstxt,bookingarr,TakePhotoView,remarktxt,comestr,teamtableview,segmentedControl,searchview,totalarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
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
    [self.view addSubview:navigationbtn];;
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"BAC";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    if ([comestr isEqualToString:@"saleshead"]) {
        horizontallbl.text=@"Escalation";
        [self createview];
    }
    else
    {
        
        UIButton* emailbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.90,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
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
    }
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    //    UIButton *filterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.03,screenRect.size.width*0.15,screenRect.size.height*0.07)];
//    filterbtn.layer.cornerRadius = 4.0f;
//    [filterbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [filterbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    filterbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [filterbtn addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
//    [filterbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
//    [filterbtn setTitle:@"Filter" forState:UIControlStateNormal];
//    [self.view addSubview:filterbtn];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewHome];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Sales Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
        NSArray *itemArray = [NSArray arrayWithObjects: @"My", @"Team", nil];
       segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.12, screenRect.size.width*0.80,screenRect.size.height*0.05);
        [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 0;
        [self.view addSubview:segmentedControl];
        
          tableViewHome.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.19, screenRect.size.width,screenRect.size.height*.79);
    }
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
    if ([comestr isEqualToString:@"saleshead"]) {
        [self getteamdata];
    }
    else
    {
        
    [self getbac];
    }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        tableViewHome.hidden=NO;
        teamtableview.hidden=YES;
        //backgroundview.hidden=NO;
    }
    if(segment.selectedSegmentIndex == 1)
    {
        // code for the first button
        tableViewHome.hidden=YES;
        teamtableview.hidden=NO;
      //  backgroundview.hidden=YES;
        [self getteamdata];
    }
}
-(void)openurl:(UIButton*)btn
{
    NSMutableDictionary *dict=[bookingarr objectAtIndex:btn.tag];
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
            [self savedata:dict:[userDict objectForKey:@"message"]];
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
-(void)savedata:(NSMutableDictionary*)dict :(NSString*)message
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
    [params setObject:@"Collection" forKey:@"module"];
    [params setObject:[dict objectForKey:@"mobile"] forKey:@"mobile"];
    [params setObject:[dict objectForKey:@"name1"] forKey:@"name"];
    [params setObject:[dict objectForKey:@"proj_name"] forKey:@"projectname"];
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"userid"];
    [params setObject:datestr forKey:@"date"];
    [params setObject:message forKey:@"message"];
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
-(void)email
{
    UIActivityIndicatorView *  actyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actyindicator.frame = self.view.frame;
    actyindicator.color=[UIColor grayColor];
    actyindicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:actyindicator];
    [actyindicator bringSubviewToFront:self.view];
    actyindicator.layer.cornerRadius=15.0f;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
    
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Sales Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
        [params setObject:@"bac_header"  forKey:@"table_name"];
        [params setObject:@"mg_empcode"  forKey:@"field_name"];
    }
    else
    {
        [params setObject:@"bac_details"  forKey:@"table_name"];
        [params setObject:@"sr_empcode"  forKey:@"field_name"];
    }
    [actyindicator startAnimating];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    NSString* urlString = @"http://13.126.129.245/xrbia/mobilecrm/sales/sendTableData.php?";
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                      length:[responseObject length] encoding: NSUTF8StringEncoding];
        NSLog(@"content %@",content);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:content delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        [actyindicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [actyindicator stopAnimating];
    }];
}
-(void)getteamdata
{
    _teamarr=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
    [params setObject:@"getBookings"  forKey:@"requestType"];
    [params setObject:@"BT" forKey:@"mode"];
    if ([comestr isEqualToString:@"saleshead"]) {
        [params setObject:@"HT" forKey:@"mode"];
    }
    //  NSString*   urlString = @"http://13.126.129.245/xrbia/mobilecrm/cp/getbac.php?";
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbac.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        _teamarr=[[NSMutableArray alloc]init];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        _teamarr=[dic objectForKey:@"bookings"];
        [indicator stopAnimating];
        [self createview];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)getbac
{
    bookingarr=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
    [params setObject:@"getBookings"  forKey:@"requestType"];
    [params setObject:@"BS" forKey:@"mode"];

    //  NSString*   urlString = @"http://13.126.129.245/xrbia/mobilecrm/cp/getbac.php?";
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbac.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        bookingarr=[[NSMutableArray alloc]init];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        bookingarr=[dic objectForKey:@"bookings"];
        if (bookingarr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data avaible"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [indicator stopAnimating];
        [tableViewHome reloadData];
        totalarr=[bookingarr mutableCopy];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)createview
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [teamtableview removeFromSuperview];
    teamtableview = [[UIScrollView alloc] init];
    [teamtableview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.20, screenRect.size.width,screenRect.size.height*.79)];
    teamtableview.bounces = NO;
    teamtableview.backgroundColor=[UIColor clearColor];
    teamtableview.delegate = self;
    [self.view addSubview:teamtableview];
    
    int hig=screenRect.size.height*0.00;
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*1.5,screenRect.size.height*0.07)];
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
        namelbl.text = @"Total\n cases";
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
        datelbl.text = @"Total\ncollection";
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
        cashlbl.text = @"Collection Balance";
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
        expencelbl.text = @"BAC Balance";
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
        OCramt.text = @"OCR Balance";
        OCramt.backgroundColor = [UIColor clearColor];
        OCramt.textColor=[UIColor blackColor];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        [[OCramt layer] setBorderWidth:1.0f];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        OCramt.numberOfLines = 0;
        [headerView addSubview:OCramt];
        [teamtableview addSubview:headerView];
    }
    hig=hig+screenRect.size.height*0.07;
    for (int i=0; i<_teamarr.count; i++) {
        
        NSMutableDictionary *dict=[_teamarr objectAtIndex:i];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width*1.5,screenRect.size.height*0.07)];
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
        namelbl.text =[dict objectForKey:@"no_total_case"];
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
        datelbl.text =[dict objectForKey:@"amt_collected"];
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
        cashlbl.text = [NSString stringWithFormat:@"%0.2f",value];
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
        expencelbl.text =[dict objectForKey:@"bac_balance"];
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
        OCramt.text =[dict objectForKey:@"ocr_balance"];
        OCramt.backgroundColor = [UIColor clearColor];
        OCramt.textColor=[UIColor blackColor];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        [[OCramt layer] setBorderWidth:1.0f];
        OCramt.lineBreakMode = NSLineBreakByWordWrapping;
        OCramt.numberOfLines = 0;
        [headerView addSubview:OCramt];
        [teamtableview addSubview:headerView];
        hig=hig+screenRect.size.height*0.07;
    }
    teamtableview.contentSize = CGSizeMake(screenRect.size.width*1.5, hig);
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
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSDictionary *dict=[bookingarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (tableView==tableViewHome) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.54)];
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
        tottalbl.text =[NSString stringWithFormat:@"Total Collection"];
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
        balancelbl.text =[NSString stringWithFormat:@"Collection Balance"];
        balancelbl.backgroundColor = [UIColor clearColor];
        balancelbl.textColor=[UIColor blackColor];
        balancelbl.lineBreakMode = NSLineBreakByWordWrapping;
        balancelbl.numberOfLines = 0;
        [headerView addSubview:balancelbl];
        
        UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        balancelbl2.textAlignment = NSTextAlignmentLeft;
        balancelbl2.text =[dict objectForKey:@"coll_bac"];
        balancelbl2.backgroundColor = [UIColor clearColor];
        balancelbl2.textColor=[UIColor blackColor];
        balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        balancelbl2.numberOfLines = 0;
        [headerView addSubview:balancelbl2];
        
        UILabel*  baclbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        baclbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        baclbl.textAlignment = NSTextAlignmentLeft;
        baclbl.text =[NSString stringWithFormat:@"BAC Amount"];
        baclbl.backgroundColor = [UIColor clearColor];
        baclbl.textColor=[UIColor blackColor];
        baclbl.lineBreakMode = NSLineBreakByWordWrapping;
        baclbl.numberOfLines = 0;
        [headerView addSubview:baclbl];
        
        UILabel*  baclbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        baclbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        baclbl2.textAlignment = NSTextAlignmentLeft;
        baclbl2.text =[dict objectForKey:@"bac_amt"];
        baclbl2.backgroundColor = [UIColor clearColor];
        baclbl2.textColor=[UIColor blackColor];
        baclbl2.lineBreakMode = NSLineBreakByWordWrapping;
        baclbl2.numberOfLines = 0;
        [headerView addSubview:baclbl2];
        
        UILabel*  baclbalance = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        baclbalance.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        baclbalance.textAlignment = NSTextAlignmentLeft;
        baclbalance.text =[NSString stringWithFormat:@"BAC Balance"];
        baclbalance.backgroundColor = [UIColor clearColor];
        baclbalance.textColor=[UIColor blackColor];
        baclbalance.lineBreakMode = NSLineBreakByWordWrapping;
        baclbalance.numberOfLines = 0;
        [headerView addSubview:baclbalance];
        
        UILabel*  baclbalance2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        baclbalance2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        baclbalance2.textAlignment = NSTextAlignmentLeft;
        baclbalance2.text =[dict objectForKey:@"bac_balance"];
        baclbalance2.backgroundColor = [UIColor clearColor];
        baclbalance2.textColor=[UIColor blackColor];
        baclbalance2.lineBreakMode = NSLineBreakByWordWrapping;
        baclbalance2.numberOfLines = 0;
        [headerView addSubview:baclbalance2];
        
        UILabel*  ocrlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.24,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        ocrlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        ocrlbl.textAlignment = NSTextAlignmentLeft;
        ocrlbl.text =[NSString stringWithFormat:@"OCR Amount"];
        ocrlbl.backgroundColor = [UIColor clearColor];
        ocrlbl.textColor=[UIColor blackColor];
        ocrlbl.lineBreakMode = NSLineBreakByWordWrapping;
        ocrlbl.numberOfLines = 0;
        [headerView addSubview:ocrlbl];
        
        UILabel*  ocrlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.28,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        ocrlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        ocrlbl2.textAlignment = NSTextAlignmentLeft;
        ocrlbl2.text =[dict objectForKey:@"ocr_amt"];
        ocrlbl2.backgroundColor = [UIColor clearColor];
        ocrlbl2.textColor=[UIColor blackColor];
        ocrlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        ocrlbl2.numberOfLines = 0;
        [headerView addSubview:ocrlbl2];
        
        UILabel*  ocrbalance = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.24,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        ocrbalance.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        ocrbalance.textAlignment = NSTextAlignmentLeft;
        ocrbalance.text =[NSString stringWithFormat:@"OCR Balance"];
        ocrbalance.backgroundColor = [UIColor clearColor];
        ocrbalance.textColor=[UIColor blackColor];
        ocrbalance.lineBreakMode = NSLineBreakByWordWrapping;
        ocrbalance.numberOfLines = 0;
        [headerView addSubview:ocrbalance];

        UILabel*  ocrbalance2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.28,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        ocrbalance2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        ocrbalance2.textAlignment = NSTextAlignmentLeft;
        ocrbalance2.text =[dict objectForKey:@"ocr_balance"];
        ocrbalance2.backgroundColor = [UIColor clearColor];
        ocrbalance2.textColor=[UIColor blackColor];
        ocrbalance2.lineBreakMode = NSLineBreakByWordWrapping;
        ocrbalance2.numberOfLines = 0;
                [headerView addSubview:ocrbalance2];
        
        UILabel*  custlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.32,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        custlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        custlbl.textAlignment = NSTextAlignmentLeft;
        custlbl.text =[NSString stringWithFormat:@"Customer Name"];
        custlbl.backgroundColor = [UIColor clearColor];
        custlbl.textColor=[UIColor blackColor];
        custlbl.lineBreakMode = NSLineBreakByWordWrapping;
        custlbl.numberOfLines = 0;
        [headerView addSubview:custlbl];
        
        UILabel*  custlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.36,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        custlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        custlbl2.textAlignment = NSTextAlignmentLeft;
        custlbl2.text =[dict objectForKey:@"name1"];
        custlbl2.backgroundColor = [UIColor clearColor];
        custlbl2.textColor=[UIColor blackColor];
        custlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        custlbl2.numberOfLines = 0;
        [headerView addSubview:custlbl2];
        
        UILabel*  mobilelb = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.32,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        mobilelb.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        mobilelb.textAlignment = NSTextAlignmentLeft;
        mobilelb.text =[NSString stringWithFormat:@"Mobile No"];
        mobilelb.backgroundColor = [UIColor clearColor];
        mobilelb.textColor=[UIColor blackColor];
        mobilelb.lineBreakMode = NSLineBreakByWordWrapping;
        mobilelb.numberOfLines = 0;
        [headerView addSubview:mobilelb];
   
   
        UILabel*  mobilelb2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.36,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        mobilelb2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        mobilelb2.textAlignment = NSTextAlignmentLeft;
        NSString * str=[dict objectForKey:@"mobile"];
        if ([[dict objectForKey:@"mobile"] length] > 4)
        {
            str = [str substringToIndex:[str length] - 4];
            str = [str stringByAppendingString:@"XXXX"];
        }
        mobilelb2.text =str;
        mobilelb2.backgroundColor = [UIColor clearColor];
        mobilelb2.textColor=[UIColor blackColor];
        mobilelb2.lineBreakMode = NSLineBreakByWordWrapping;
        mobilelb2.numberOfLines = 0;
        [headerView addSubview:mobilelb2];
        
        UILabel*  sdcamt = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.40,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        sdcamt.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        sdcamt.textAlignment = NSTextAlignmentLeft;
        sdcamt.text =[NSString stringWithFormat:@"SDC Amount"];
        sdcamt.backgroundColor = [UIColor clearColor];
        sdcamt.textColor=[UIColor blackColor];
        sdcamt.lineBreakMode = NSLineBreakByWordWrapping;
        sdcamt.numberOfLines = 0;
        [headerView addSubview:sdcamt];
        
        UILabel*  sdcamtlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.44,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        sdcamtlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        sdcamtlbl.textAlignment = NSTextAlignmentLeft;
        sdcamtlbl.text =[dict objectForKey:@"sdc_amt"];
        sdcamtlbl.backgroundColor = [UIColor clearColor];
        sdcamtlbl.textColor=[UIColor blackColor];
        sdcamtlbl.lineBreakMode = NSLineBreakByWordWrapping;
        sdcamtlbl.numberOfLines = 0;
        [headerView addSubview:sdcamtlbl];
        
        UILabel*  Sdcbal = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.40,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        Sdcbal.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Sdcbal.textAlignment = NSTextAlignmentLeft;
        Sdcbal.text =[NSString stringWithFormat:@"SDC Balance"];
        Sdcbal.backgroundColor = [UIColor clearColor];
        Sdcbal.textColor=[UIColor blackColor];
        Sdcbal.lineBreakMode = NSLineBreakByWordWrapping;
        Sdcbal.numberOfLines = 0;
        [headerView addSubview:Sdcbal];
        
        
        UILabel*  Sdcbal2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.44,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        Sdcbal2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        Sdcbal2.textAlignment = NSTextAlignmentLeft;
        Sdcbal2.text =[dict objectForKey:@"sdc_balance"];
        Sdcbal2.backgroundColor = [UIColor clearColor];
        Sdcbal2.textColor=[UIColor blackColor];
        Sdcbal2.lineBreakMode = NSLineBreakByWordWrapping;
        Sdcbal2.numberOfLines = 0;
        [headerView addSubview:Sdcbal2];
        
        
        UIButton *checkbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.49,screenRect.size.width*0.08,screenRect.size.height*.05)];
        [checkbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        checkbtn.layer.masksToBounds=YES;
        //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [checkbtn setImage:[UIImage imageNamed:@"cheque .png"] forState:UIControlStateNormal];
        [headerView addSubview:checkbtn];
        
        UIButton *checkbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.49,screenRect.size.width*0.27,screenRect.size.height*.05)];
        [checkbtn2 setBackgroundColor:[UIColor clearColor]];
        [checkbtn2 addTarget:self action:@selector(addcheque:) forControlEvents:UIControlEventTouchUpInside];
        checkbtn2.tag=indexPath.row;
        [checkbtn2 setTitle:@"Collect cheque" forState:UIControlStateNormal];
        [checkbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        checkbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        checkbtn2.titleLabel.font=font;
        [headerView addSubview:checkbtn2];
        
        UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.485,screenRect.size.width*0.90,screenRect.size.height*0.003)];
        linelbl.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:linelbl];
        
        UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.52,screenRect.size.height*0.49,screenRect.size.width*0.08,screenRect.size.height*.05)];
        [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        savebtn.layer.masksToBounds=YES;
        //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
        [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
        [headerView addSubview:savebtn];

        
        UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.60,screenRect.size.height*0.49,screenRect.size.width*0.10,screenRect.size.height*.05)];
        [phonebtn2 setBackgroundColor:[UIColor clearColor]];
        [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
        phonebtn2.tag=indexPath.row;
        [phonebtn2 setTitle:@"Call" forState:UIControlStateNormal];
        [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        phonebtn2.titleLabel.font=font;
        [headerView addSubview:phonebtn2];

        UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.70,screenRect.size.height*0.49,screenRect.size.width*0.08,screenRect.size.height*.05)];
        [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        editbtn.layer.masksToBounds=YES;
        //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
        [editbtn setTitle:@"\uE90E" forState:UIControlStateNormal];
        [headerView addSubview:editbtn];
        
        UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.78,screenRect.size.height*0.49,screenRect.size.width*0.20,screenRect.size.height*.05)];
        [editbtn2 setBackgroundColor:[UIColor clearColor]];
        [editbtn2 addTarget:self action:@selector(remark:) forControlEvents:UIControlEventTouchUpInside];
        editbtn2.tag=indexPath.row;
        [editbtn2 setTitle:@"Remark" forState:UIControlStateNormal];
        [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        editbtn2.titleLabel.font=font;
        [headerView addSubview:editbtn2];
        [cell.contentView addSubview:headerView];
    }
    if (tableView==teamtableview) {
        
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}
-(void)addcheque:(UIButton*)btn
{
     CollectChequeViewController *mainvc=[[CollectChequeViewController alloc] initWithNibName:@"CollectChequeViewController" bundle:nil];
    mainvc.dict=[bookingarr objectAtIndex:btn.tag];
    [self.navigationController presentViewController:mainvc animated:YES completion:nil];
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
        return screenRect.size.height*0.55;
    }
    else
    {
        return screenRect.size.height*0.0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)remark:(UIButton*)btn
{
    index=btn.tag;
    [TakePhotoView removeFromSuperview];
    TakePhotoView = [[CustomIOS7AlertView alloc] init];
    [TakePhotoView setContainerView:[self signImageSetAlert]];
    [TakePhotoView setDelegate:self];
    [TakePhotoView setUseMotionEffects:true];
    [TakePhotoView show];
}
-(void)back
{
    bookingarr=[[NSMutableArray alloc]init];
    [searchview removeFromSuperview];
    [bookingarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
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
        remark4lbl.attributedText = attributedString7;
        
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
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@updatebcac.php?",[prefs objectForKey:@"Link"]];
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
        [self getbac];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [actvityindicatior stopAnimating];
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_searchtext) {
        if ([comestr isEqualToString:@"bac"] ) {
            bookingarr= [[NSMutableArray alloc]init];
            NSString*  textstr=textField.text;
            if ([string isEqualToString:@""]) {
                textstr= [textstr substringToIndex:[textstr length]-1];
            }
            else
            {
                textstr=[NSString stringWithFormat:@"%@%@",textField.text,string];
            }
            for (int i=0; i<totalarr.count; i++) {
                NSDictionary *tempdict=[totalarr objectAtIndex:i];
                NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"proj_name"]];
                if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"unit_no"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"name1"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"mobile"] uppercaseString] containsString:[textstr uppercaseString]]) {
                    [bookingarr addObject:[totalarr objectAtIndex:i]];
                }
            }
            if (textstr.length<1) {
                [bookingarr addObjectsFromArray:totalarr];
            }
            [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
        }
      
    return YES;
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
