//
//  ROXViewController.m
//  Sales App
//
//  Created by Infinitum on 10/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "ROXViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"
@interface ROXViewController ()

@end

@implementation ROXViewController
@synthesize tableViewHome,indicator,bgview,demoView,projectpicker,projectoolbar,projectstr,projectarr,projectstxt,bookingarr,teamtableview,TakePhotoView,remarktxt,searchview,totalarr,numberToolbarzip,datePicker;

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
    horizontallbl.text=@"ROX";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
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
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.12, screenRect.size.width*0.80,screenRect.size.height*0.05);
        [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 0;
        [self.view addSubview:segmentedControl];
        
        tableViewHome.frame=CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.18, screenRect.size.width,screenRect.size.height*.82);
        
        teamtableview = [[UITableView alloc] init];
        [teamtableview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.20, screenRect.size.width,screenRect.size.height*.79)];
        teamtableview.backgroundColor=[UIColor clearColor];
        teamtableview.delegate = self;
        teamtableview.dataSource = self;
        teamtableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:teamtableview];
        teamtableview.hidden=YES;
    }
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
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
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getrox];
}
-(void)getrox
{
    bookingarr=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
    [params setObject:@"getBookings"  forKey:@"requestType"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getrox.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        bookingarr=[[NSMutableArray alloc]init];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        bookingarr=[dic objectForKey:@"bookings"];
        totalarr=[bookingarr mutableCopy];
        [indicator stopAnimating];
        [tableViewHome reloadData];
        if (bookingarr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
  
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
    
        [params setObject:@"rox_details"  forKey:@"table_name"];
        [params setObject:@"sr_empcode"  forKey:@"field_name"];
    
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_searchtext) {
      {
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
                NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_id"]];
                if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"unit_no"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"name"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"mobile"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"mobile2"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"email"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"peradd"] uppercaseString] containsString:[textstr uppercaseString]]) {
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bookingarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSDictionary *dict=[bookingarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.38)];
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
        projectlbl.text =[dict objectForKey:@"project_id"];
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
        tottalbl.text =[NSString stringWithFormat:@"Customer Name"];
        tottalbl.backgroundColor = [UIColor clearColor];
        tottalbl.textColor=[UIColor blackColor];
        tottalbl.lineBreakMode = NSLineBreakByWordWrapping;
        tottalbl.numberOfLines = 0;
        [headerView addSubview:tottalbl];

        UILabel*  totalcoll2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        totalcoll2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        totalcoll2.textAlignment = NSTextAlignmentLeft;
        totalcoll2.text =[dict objectForKey:@"name"];
        totalcoll2.backgroundColor = [UIColor clearColor];
        totalcoll2.textColor=[UIColor blackColor];
        totalcoll2.lineBreakMode = NSLineBreakByWordWrapping;
        totalcoll2.numberOfLines = 0;
        [headerView addSubview:totalcoll2];

        UILabel*  balancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.08,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        balancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        balancelbl.textAlignment = NSTextAlignmentLeft;
        balancelbl.text =[NSString stringWithFormat:@"Email ID"];
        balancelbl.backgroundColor = [UIColor clearColor];
        balancelbl.textColor=[UIColor blackColor];
        balancelbl.lineBreakMode = NSLineBreakByWordWrapping;
        balancelbl.numberOfLines = 0;
        [headerView addSubview:balancelbl];

        UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.12,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        balancelbl2.textAlignment = NSTextAlignmentLeft;
        balancelbl2.text =[dict objectForKey:@"email"];
        balancelbl2.backgroundColor = [UIColor clearColor];
        balancelbl2.textColor=[UIColor blackColor];
        balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        balancelbl2.numberOfLines = 0;
        [headerView addSubview:balancelbl2];

        UILabel*  baclbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        baclbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        baclbl.textAlignment = NSTextAlignmentLeft;
        baclbl.text =[NSString stringWithFormat:@"Mobile1"];
        baclbl.backgroundColor = [UIColor clearColor];
        baclbl.textColor=[UIColor blackColor];
        baclbl.lineBreakMode = NSLineBreakByWordWrapping;
        baclbl.numberOfLines = 0;
        [headerView addSubview:baclbl];

        UILabel*  baclbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        baclbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        baclbl2.textAlignment = NSTextAlignmentLeft;
        NSString * str=[dict objectForKey:@"mobile"];
        if ([[dict objectForKey:@"mobile"] length] > 4)
        {
            str = [str substringToIndex:[str length] - 4];
            str = [str stringByAppendingString:@"XXXX"];
        }
        baclbl2.text =str;
        baclbl2.backgroundColor = [UIColor clearColor];
        baclbl2.textColor=[UIColor blackColor];
        baclbl2.lineBreakMode = NSLineBreakByWordWrapping;
        baclbl2.numberOfLines = 0;
        [headerView addSubview:baclbl2];
    
        UILabel*  baclbalance = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.16,screenRect.size.width*0.39,screenRect.size.height*0.04)];
        baclbalance.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        baclbalance.textAlignment = NSTextAlignmentLeft;
        baclbalance.text =[NSString stringWithFormat:@"Mobile2"];
        baclbalance.backgroundColor = [UIColor clearColor];
        baclbalance.textColor=[UIColor blackColor];
        baclbalance.lineBreakMode = NSLineBreakByWordWrapping;
        baclbalance.numberOfLines = 0;
        [headerView addSubview:baclbalance];

        UILabel*  baclbalance2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.20,screenRect.size.width*0.39,screenRect.size.height*0.035)];
        baclbalance2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        baclbalance2.textAlignment = NSTextAlignmentLeft;
        NSString * str1=[dict objectForKey:@"mobile2"];
        if ([[dict objectForKey:@"mobile2"] length] > 4)
        {
            str1 = [str1 substringToIndex:[str1 length] - 4];
            str1 = [str1 stringByAppendingString:@"XXXX"];
        }
        baclbalance2.text =str1;
        baclbalance2.backgroundColor = [UIColor clearColor];
        baclbalance2.textColor=[UIColor blackColor];
        baclbalance2.lineBreakMode = NSLineBreakByWordWrapping;
        baclbalance2.numberOfLines = 0;
        [headerView addSubview:baclbalance2];

        UILabel*  custlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.24,screenRect.size.width*0.80,screenRect.size.height*0.07)];
        custlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        custlbl.textAlignment = NSTextAlignmentLeft;
        custlbl.text =[NSString stringWithFormat:@"Address:-%@",[dict objectForKey:@"peradd"]];
        custlbl.backgroundColor = [UIColor clearColor];
        custlbl.textColor=[UIColor blackColor];
        custlbl.lineBreakMode = NSLineBreakByWordWrapping;
        custlbl.numberOfLines = 0;
        [headerView addSubview:custlbl];

        UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.325,screenRect.size.width*0.90,screenRect.size.height*0.003)];
        linelbl.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:linelbl];
    
    UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    
    UIButton *changestatus=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.0,screenRect.size.height*0.33,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [changestatus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changestatus.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    changestatus.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [ changestatus setTitle:@"\uE14F" forState:UIControlStateNormal];
    [headerView addSubview:changestatus];
    
    UIButton *changestatus2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.08,screenRect.size.height*0.33,screenRect.size.width*0.24,screenRect.size.height*.05)];
    [changestatus2 setBackgroundColor:[UIColor clearColor]];
    [changestatus2 addTarget:self action:@selector(changestatus:) forControlEvents:UIControlEventTouchUpInside];
    changestatus2.tag=indexPath.row;
    [changestatus2 setTitle:@"Change status" forState:UIControlStateNormal];
    [changestatus2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changestatus2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    changestatus2.titleLabel.font=font;
    [headerView addSubview:changestatus2];
    
    UIButton *callbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.32,screenRect.size.height*0.33,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [callbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    callbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [callbtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:callbtn];
    callbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];

    UIButton *call2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.40,screenRect.size.height*0.33,screenRect.size.width*0.12,screenRect.size.height*.05)];
    [call2 setBackgroundColor:[UIColor clearColor]];
    [call2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    call2.tag=indexPath.row;
    [call2 setTitle:@"Call-1" forState:UIControlStateNormal];
    [call2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    call2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    call2.titleLabel.font=font;
    [headerView addSubview:call2];

    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.52,screenRect.size.height*0.33,screenRect.size.width*0.08,screenRect.size.height*.05)];
        [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        savebtn.layer.masksToBounds=YES;
        //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
        [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
        [headerView addSubview:savebtn];

        UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.60,screenRect.size.height*0.33,screenRect.size.width*0.12,screenRect.size.height*.05)];
        [phonebtn2 setBackgroundColor:[UIColor clearColor]];
        [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
        phonebtn2.tag=indexPath.row;
        [phonebtn2 setTitle:@"Call-2" forState:UIControlStateNormal];
        [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        phonebtn2.titleLabel.font=font;
        [headerView addSubview:phonebtn2];

        UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.70,screenRect.size.height*0.33,screenRect.size.width*0.08,screenRect.size.height*.05)];
        [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        editbtn.layer.masksToBounds=YES;
        //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
        [editbtn setTitle:@"\uE90E" forState:UIControlStateNormal];
        [headerView addSubview:editbtn];

        UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.78,screenRect.size.height*0.33,screenRect.size.width*0.20,screenRect.size.height*.05)];
        [editbtn2 setBackgroundColor:[UIColor clearColor]];
        [editbtn2 addTarget:self action:@selector(remark:) forControlEvents:UIControlEventTouchUpInside];
        editbtn2.tag=indexPath.row;
        [editbtn2 setTitle:@"Remark" forState:UIControlStateNormal];
        [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        editbtn2.titleLabel.font=font;
        [headerView addSubview:editbtn2];
    
        [cell.contentView addSubview:headerView];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)changestatus:(UIButton*)btn
{
    NSMutableDictionary *dict=[bookingarr objectAtIndex:btn.tag];
    NSMutableDictionary *mutableDict = [dict mutableCopy];
    for (NSString *key in [dict allKeys]) {
        if ([dict[key] isEqual:[NSNull null]]) {
            mutableDict[key] = @"";
        }
    }
    dict = [mutableDict copy];
    
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-150, 300,250)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];

    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
    [topButton setTitle:@"Change Status" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
  //  _statustxt = [[UITextField alloc] initWithFrame:CGRectMake(10,50,280,40)];
    _statustxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 50, 280, 40)];
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
    _statustxt.placeholder=@"ROX Status";
    _statustxt.text=[dict objectForKey:@"rox_status"];
    [demoView addSubview:_statustxt];
    NSMutableArray* bandArray = [[NSMutableArray alloc] initWithObjects:@"Not responding",@" Call letter",@"will download app",@"App Downloaded",@"Leads enter",@"Customer meeting done", nil];
    _downPicker = [[DownPicker alloc] initWithTextField:_statustxt withData:bandArray];
    [_downPicker setPlaceholderWhileSelecting:@"Country"];
    [_downPicker addTarget:self action:@selector(dp_Selected:)
         forControlEvents:UIControlEventValueChanged];
    _downPicker.placeholder=@"ROX Status";
    [_downPicker showArrowImage:YES];
    [_downPicker setPlaceholder:@"ROX Status"];

    // [self.downPicker setData:array]
    _followupdattxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 100, 280, 40)];
    _followupdattxt.textAlignment=NSTextAlignmentLeft;
    _followupdattxt.delegate = self;
    _followupdattxt.textColor=[UIColor blackColor];
    [_followupdattxt setBackgroundColor:[UIColor clearColor]];
    _followupdattxt.leftViewMode = UITextFieldViewModeAlways;
    [_followupdattxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _followupdattxt.returnKeyType=UIReturnKeyDone;
    _followupdattxt.selectedLineColor = [UIColor redColor];
    _followupdattxt.selectedPlaceHolderColor = [UIColor redColor];
    _followupdattxt.placeHolderColor = [UIColor grayColor];
    _followupdattxt.font = [UIFont systemFontOfSize:14];
    _followupdattxt.placeholder=@"Followup Date";
    _followupdattxt.text=[dict objectForKey:@"followup_date"];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                               style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];

    [numberToolbarzip sizeToFit];
    _followupdattxt.inputView =datePicker;
    _followupdattxt.inputAccessoryView = numberToolbarzip;
    [demoView addSubview:_followupdattxt];
    
    _countxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,150, 280, 40)];
    _countxt.textAlignment=NSTextAlignmentLeft;
    _countxt.delegate = self;
    _countxt.textColor=[UIColor blackColor];
    [_countxt setBackgroundColor:[UIColor clearColor]];
    _countxt.leftViewMode = UITextFieldViewModeAlways;
    [_countxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _countxt.returnKeyType=UIReturnKeyDone;
    _countxt.selectedLineColor = [UIColor redColor];
    _countxt.selectedPlaceHolderColor = [UIColor redColor];
    _countxt.placeHolderColor = [UIColor grayColor];
    _countxt.font = [UIFont systemFontOfSize:14];
    _countxt.placeholder=@"Count";
    _countxt.text=[dict objectForKey:@"count"];
    if ([_countxt.text isEqualToString:@""])
        _countxt.hidden=YES;
    
    [demoView addSubview:_countxt];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    _countxt.inputAccessoryView = numberToolbarzip;
    _countxt.leftViewMode = UITextFieldViewModeAlways;
    _countxt.keyboardType = UIKeyboardTypeDecimalPad;
    //_countxt.hidden=YES;
    
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
    [savebtn setTitle:@"Change status" forState:UIControlStateNormal];
    savebtn.tag=btn.tag;
    [savebtn addTarget:self action:@selector(savestatus:)
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
-(void)savestatus:(UIButton*)btn
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
    //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
    acttyindicator.color=[UIColor blackColor];
    [self.view addSubview:acttyindicator];
    [acttyindicator bringSubviewToFront:demoView];
    
    
    
    NSMutableDictionary * dict=[bookingarr objectAtIndex:btn.tag];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Saveroxdata"  forKey:@"requestType"];
    [params setObject:[dict objectForKey:@"empname"]  forKey:@"sr_empname"];
    [params setObject:[dict objectForKey:@"bknum"] forKey:@"bknum"];
    [params setObject:[dict objectForKey:@"project_id"]  forKey:@"proj_id"];
    [params setObject:@""  forKey:@"proj_name"];
    [params setObject:[dict objectForKey:@"building"] forKey:@"building"];
    [params setObject:[dict objectForKey:@"unit_no"]  forKey:@"unit_no"];
    [params setObject:[dict objectForKey:@"cust_number"]  forKey:@"kunnr"];
    [params setObject:[dict objectForKey:@"name"]  forKey:@"name1"];
    [params setObject:_statustxt.text  forKey:@"rox_status"];
    [params setObject:_followupdattxt.text  forKey:@"followup_date"];
    [params setObject:_countxt.text  forKey:@"count"];
    [params setObject: datestr forKey:@"zdate"];

    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@saveroxstatus.php?",[prefs objectForKey:@"Link"]];
    [acttyindicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        CATransition *transition1 = [CATransition animation];
        transition1.duration = 0.5;
        transition1.type = kCATransitionPush;
        transition1.subtype = kCATransitionFromLeft;
        [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [demoView.layer addAnimation:transition1 forKey:nil];
        demoView.hidden=YES;
        [bgview removeFromSuperview];
        
        [acttyindicator stopAnimating];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [acttyindicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.followupdattxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    _followupdattxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    [_followupdattxt resignFirstResponder];
}
-(void)dp_Selected:(DownPicker*)dp {
    NSString* selectedValue = [dp text];
    if ([selectedValue isEqualToString:@"Leads enter"]) {
        _countxt.hidden=NO;
    }
    else
    {
        _countxt.hidden=YES;
    _countxt.text=@"";
    }
    // do what you want
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    LeadViewController *mainvc=[[LeadViewController alloc] initWithNibName:@"LeadViewController" bundle:nil];
    //    [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.39;
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
-(void)closeAlert:(id)sender{
    [TakePhotoView close];
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    demoView.hidden=YES;
    [bgview removeFromSuperview];
}
//-(void)back
//{
//    bookingarr=[[NSMutableArray alloc]init];
//    [searchview removeFromSuperview];
//    [bookingarr addObjectsFromArray:totalarr];
//    [tableViewHome reloadData];
//}

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
    NSString* positionstr2= ([dict objectForKey:@"REMARK1"]==nil)? @"":[dict objectForKey:@"REMARK1"];
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
    NSString*  positionstr4 = ([dict objectForKey:@"REMARK2"]==nil) ? @"" : [dict objectForKey:@"REMARK2"];
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
    NSString* positionstr6=([dict objectForKey:@"REMARK3"]==nil) ? @"" : [dict objectForKey:@"REMARK3"];
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
    NSString* positionstr8=([dict objectForKey:@"REMARK4"]==nil) ? @"" : [dict objectForKey:@"REMARK4"];
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
    NSString* positionstr10=([dict objectForKey:@"REMARK5"]==nil) ? @"" : [dict objectForKey:@"REMARK5"];
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
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@updaterox.php?",[prefs objectForKey:@"Link"]];
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
        [self getrox];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [actvityindicatior stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    bookingarr=[[NSMutableArray alloc]init];
    [searchview removeFromSuperview];
    [bookingarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
}
-(void)openurl:(UIButton*)btn
{
    NSMutableDictionary * dict=[bookingarr objectAtIndex:btn.tag];
    NSString * str;
    if ([btn.titleLabel.text isEqualToString:@"Call-1"]) {
        str=[dict objectForKey:@"mobile"];
    }
    else
        str=[dict objectForKey:@"mobile2"];
    
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
    [params setObject:@"ROX" forKey:@"module"];
    [params setObject:mobile forKey:@"mobile"];
    [params setObject:[dict objectForKey:@"name"] forKey:@"name"];
    [params setObject:[dict objectForKey:@"project_id"] forKey:@"projectname"];
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
    [_followupdattxt resignFirstResponder];
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
}
-(void)doneWithNumberPad{
    [_countxt resignFirstResponder];
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
