//
//  FollowUpViewController.m
//  Sales App
//
//  Created by Infinitum on 09/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "FollowUpViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "FollowUpEditViewController.h"
#import "SWRevealViewController.h"
#import "FollowupDesignVC.h"
@interface FollowUpViewController ()

@end

@implementation FollowUpViewController
@synthesize tableViewHome,indicator,bgview,demoView,Fromdatetxt,todatetxt,projectstxt,prostatustxt,projectarr,projectstr,projectoolbar,projectpicker,statusarr,statusstr,statuwpicker,statustoolbar,followuparr,comestr,searchview,totalarr;
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
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [filtbtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [filtbtn setTitle:@"\uE8B6" forState:UIControlStateNormal];
    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filtbtn.titleLabel setFont:customFontdregs];
    [filtbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:filtbtn];
    
    
    if ([comestr isEqualToString:@"followup"]) {
        horizontallbl.text=@"Follow Up";
//
//        UIButton *filterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.03,screenRect.size.width*0.15,screenRect.size.height*0.07)];
//        filterbtn.layer.cornerRadius = 4.0f;
//        [filterbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [filterbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        filterbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [filterbtn addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
//        [filterbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
//        [filterbtn setTitle:@"Filter" forState:UIControlStateNormal];
//        [self.view addSubview:filterbtn];
    }
    else
    {
        horizontallbl.text=@"Block units";
    }
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
//    UIButton *pendingbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12,screenRect.size.width*0.23,screenRect.size.height*0.05)];
//    pendingbtn.layer.cornerRadius = 4.0f;
//    [pendingbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [pendingbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    pendingbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [pendingbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
//    [pendingbtn setTitle:@"Pending 10" forState:UIControlStateNormal];
//    [pendingbtn setBackgroundColor:[UIColor colorWithHexString:@"#E00000"]] ;
//    [self.view addSubview:pendingbtn];
//
//    UIButton *inprobtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30,screenRect.size.height*0.12,screenRect.size.width*0.23,screenRect.size.height*0.05)];
//    inprobtn.layer.cornerRadius = 4.0f;
//    [inprobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [inprobtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    inprobtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [inprobtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
//    [inprobtn setTitle:@"In Process 20" forState:UIControlStateNormal];
//    [inprobtn setBackgroundColor:[UIColor colorWithHexString:@"#FF9300"]] ;
//    [self.view addSubview:inprobtn];
//
//    UIButton *completbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.12,screenRect.size.width*0.23,screenRect.size.height*0.05)];
//    completbtn.layer.cornerRadius = 4.0f;
//    [completbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [completbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    completbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [completbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
//    [completbtn setTitle:@"Complete 50" forState:UIControlStateNormal];
//    [completbtn setBackgroundColor:[UIColor colorWithHexString:@"#00A428"]] ;
//    [self.view addSubview:completbtn];
   
   
    
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([comestr isEqualToString:@"followup"]) {
   // NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getsyncfollowup.php",[prefs objectForKey:@"Link"]];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@%@",[prefs objectForKey:@"Link"],self.followupType];

    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"assigned_user_id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        followuparr=[[NSMutableArray alloc]init];
                        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                        followuparr=[dic objectForKey:@"sales_person"];
                        [tableViewHome reloadData];
                        [indicator stopAnimating];
        totalarr=[followuparr mutableCopy];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
    else if([comestr isEqualToString:@"block"])
    {
        [self getblocklist];
    }
}
-(void)getblocklist
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getBlockedUnits" forKey:@"requestType"];
    [params setObject:[prefs objectForKey:@"role_name"]forKey:@"userRole"];
    [params setObject:[prefs objectForKey:@"user_name"]forKey:@"userName"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        followuparr=[[NSMutableArray alloc]init];
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        followuparr=[dic objectForKey:@"blocked_units"];
        [tableViewHome reloadData];
        [indicator stopAnimating];
        totalarr=[followuparr mutableCopy];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)unblock:(UIButton*)btn
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic=[followuparr objectAtIndex:btn.tag];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"unblockUnit" forKey:@"requestType"];
    [params setObject:[dic objectForKey:@"id"] forKey:@"inventoryID"];
    [params setObject:[prefs objectForKey:@"user_name"]forKey:@"blockedBy"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
       
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[[userDict objectForKey:@"Android"] objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        if ([[[userDict objectForKey:@"Android"] objectForKey:@"message"] isEqualToString:@"Unblocked"]) {
            [self getblocklist];
        }
        [indicator stopAnimating];
    }
        failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
-(void)back
{
    [searchview removeFromSuperview];
    followuparr=[[NSMutableArray alloc]init];
    [followuparr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_searchtext) {
        followuparr= [[NSMutableArray alloc]init];
        NSString*  textstr=textField.text;
        if ([string isEqualToString:@""]) {
            textstr= [textstr substringToIndex:[textstr length]-1];
        }
        else
        {
            textstr=[NSString stringWithFormat:@"%@%@",textField.text,string];
        }
            if ([comestr isEqualToString:@"followup"]) {
        for (int i=0; i<totalarr.count; i++) {
            NSDictionary *tempdict=[totalarr objectAtIndex:i];
            NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_name"]]
            ;
            if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"name"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"customer_mobile_c"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"fu_date_c"] uppercaseString] containsString:[textstr uppercaseString]]) {
                [followuparr addObject:[totalarr objectAtIndex:i]];
            }
        }
        }
        if([comestr isEqualToString:@"block"])
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
                NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_name"]]
                ;
                if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"unit_number"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"blocked_user_name"] uppercaseString] containsString:[textstr uppercaseString]]) {
                    [followuparr addObject:[totalarr objectAtIndex:i]];
                }
            }
        }
        if (textstr.length<1) {
            [followuparr addObjectsFromArray:totalarr];
        }
         [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return followuparr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSMutableDictionary *dict=[followuparr objectAtIndex:indexPath.row];
    
    NSMutableDictionary *mutableDict = [dict mutableCopy];
    for (NSString *key in [dict allKeys]) {
        if ([dict[key] isEqual:[NSNull null]]) {
            mutableDict[key] = @"";
        }
    }
    dict = [mutableDict copy];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    if ([comestr isEqualToString: @"followup"]) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.23)];
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
    NSArray *myArray = [[dict objectForKey:@"name"] componentsSeparatedByString:@"-"];
    Srnolbl.text =[NSString stringWithFormat:@"Name:%@",[myArray objectAtIndex:0]];
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
  
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.70,screenRect.size.height*0.035)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =[NSString stringWithFormat:@"Project Name:%@",[dict objectForKey:@"project_name"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.085,screenRect.size.width*0.70,screenRect.size.height*0.035)];
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    idlbl.textAlignment = NSTextAlignmentLeft;
    idlbl.text =[NSString stringWithFormat:@"Followup Date:%@",[dict objectForKey:@"fu_date_c"]];
    idlbl.backgroundColor = [UIColor clearColor];
    idlbl.textColor=[UIColor blackColor];
    idlbl.lineBreakMode = NSLineBreakByWordWrapping;
    idlbl.numberOfLines = 0;
    [headerView addSubview:idlbl];
    
    UILabel*  moblbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12,screenRect.size.width*0.60,screenRect.size.height*0.035)];
    moblbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    moblbl.textAlignment = NSTextAlignmentLeft;
    NSString * str=[dict objectForKey:@"customer_mobile_c"];
    if ([[dict objectForKey:@"customer_mobile_c"] length] > 4)
    {
        str = [str substringToIndex:[str length] - 4];
        str = [str stringByAppendingString:@"XXXX"];
    }
    moblbl.text =[NSString stringWithFormat:@"Mobile No.:%@",str];
    moblbl.backgroundColor = [UIColor clearColor];
    moblbl.textColor=[UIColor blackColor];
    moblbl.lineBreakMode = NSLineBreakByWordWrapping;
    moblbl.numberOfLines = 0;
    [headerView addSubview:moblbl];
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.67,screenRect.size.height*0.12,screenRect.size.width*0.23,screenRect.size.height*0.03)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn setClipsToBounds:YES];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  //  [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [headerView addSubview:Createvoucherbtn];
    
    [Createvoucherbtn setTitle:[dict objectForKey:@"prospect_stage_c"]forState:UIControlStateNormal];
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#6762C3"]] ;
    
    UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.16,screenRect.size.width*0.90,screenRect.size.height*0.003)];
    linelbl.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:linelbl];
    
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.40,screenRect.size.height*0.17,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:savebtn];
    
    UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.48,screenRect.size.height*0.17,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [phonebtn2 setBackgroundColor:[UIColor clearColor]];
    [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn2.tag=indexPath.row;
    [phonebtn2 setTitle:@"Call" forState:UIControlStateNormal];
    [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    phonebtn2.titleLabel.font=font;
    [headerView addSubview:phonebtn2];
    
    UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.58,screenRect.size.height*0.17,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [editbtn setTitle:@"\uE14F" forState:UIControlStateNormal];
    [headerView addSubview:editbtn];
    
    UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.66,screenRect.size.height*0.17,screenRect.size.width*0.30,screenRect.size.height*.05)];
    [editbtn2 setBackgroundColor:[UIColor clearColor]];
      [editbtn2 addTarget:self action:@selector(openview:) forControlEvents:UIControlEventTouchUpInside];
    editbtn2.tag=indexPath.row;
    [editbtn2 setTitle:@"Change status" forState:UIControlStateNormal];
    [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    editbtn2.titleLabel.font=font;
    [headerView addSubview:editbtn2];
    [cell.contentView addSubview:headerView];
    }
    if ([comestr isEqualToString:@"block"])
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.12)];
        headerView.backgroundColor=[UIColor whiteColor];
        headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
        headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
        headerView.layer.shadowOpacity = 1.0f;
        headerView.layer.shadowRadius = 0.0f;
        headerView.layer.masksToBounds = NO;
        headerView.backgroundColor=[UIColor whiteColor];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,screenRect.size.width*0.70,screenRect.size.height*0.04)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"project_name"]];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.04,screenRect.size.width*0.70,screenRect.size.height*0.035)];
        namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        namelbl.textAlignment = NSTextAlignmentLeft;
        namelbl.text =[NSString stringWithFormat:@"Unit No:%@",[dict objectForKey:@"unit_number"]];
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        
        [headerView addSubview:namelbl];
        
        UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.075,screenRect.size.width*0.70,screenRect.size.height*0.035)];
        idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        idlbl.textAlignment = NSTextAlignmentLeft;
        idlbl.text =[NSString stringWithFormat:@"Block Username:%@",[dict objectForKey:@"blocked_user_name"]];
        idlbl.backgroundColor = [UIColor clearColor];
        idlbl.textColor=[UIColor blackColor];
        idlbl.lineBreakMode = NSLineBreakByWordWrapping;
        idlbl.numberOfLines = 0;
        [headerView addSubview:idlbl];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        if ([[[prefs objectForKey:@"user_name"] uppercaseString]isEqualToString:[[dict objectForKey:@"blocked_user_name"] uppercaseString]]) {
            UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.67,screenRect.size.height*0.075,screenRect.size.width*0.23,screenRect.size.height*0.03)];
            Createvoucherbtn.layer.cornerRadius = 4.0f;
            [Createvoucherbtn setClipsToBounds:YES];
            [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
            Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [Createvoucherbtn addTarget:self action:@selector(unblock:) forControlEvents:UIControlEventTouchUpInside];
            Createvoucherbtn.tag=indexPath.row;
            [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
            [headerView addSubview:Createvoucherbtn];
            [Createvoucherbtn setTitle:@"Unblock"forState:UIControlStateNormal];
            [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#6762C3"]] ;
        }
       

        [cell.contentView addSubview:headerView];
        
        

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
    if ([comestr isEqualToString:@"block"])
    {
        return screenRect.size.height*0.135;
    }
    return screenRect.size.height*0.25;
}
-(void)openview:(UIButton *)btn
{
    FollowUpEditViewController *mainvc=[[FollowUpEditViewController alloc] initWithNibName:@"FollowUpEditViewController" bundle:nil];
    mainvc.dict=[followuparr objectAtIndex:btn.tag];
    mainvc.comestr=@"followup";
    [self.navigationController pushViewController:mainvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)add
{
   
}

//-(void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)openurl:(UIButton*)btn
{
        NSMutableDictionary *dict=[followuparr objectAtIndex:btn.tag];
        //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dict objectForKey:@"phone_mobile"]]]];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"xrbia"  forKey:@"userName"];
        [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
        [params setObject:[dict objectForKey:@"customer_mobile_c"] forKey:@"custNumber"];
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
                FollowUpEditViewController *mainvc=[[FollowUpEditViewController alloc] initWithNibName:@"FollowUpEditViewController" bundle:nil];
                mainvc.dict=[followuparr objectAtIndex:btn.tag];
                mainvc.comestr=@"followup";
                [self.navigationController pushViewController:mainvc animated:YES];
            }
            else
            {
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

-(void)savedata:(NSMutableDictionary*)dict :(NSString*)message
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
    [params setObject:@"Followup" forKey:@"module"];
    [params setObject:[dict objectForKey:@"customer_mobile_c"] forKey:@"mobile"];
    [params setObject:[dict objectForKey:@"name"] forKey:@"name"];
    [params setObject:[dict objectForKey:@"project_name"] forKey:@"projectname"];
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
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-150, 300,240)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
        UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 280, 30)];
        [topButton setTitle:@"Filter By Date" forState:UIControlStateNormal];
        [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [demoView addSubview:topButton];
    
    Fromdatetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,40,140,40)];
    Fromdatetxt.textAlignment=NSTextAlignmentLeft;
    Fromdatetxt.delegate = self;
    Fromdatetxt.textColor=[UIColor blackColor];
    [Fromdatetxt setBackgroundColor:[UIColor clearColor]];
    Fromdatetxt.leftViewMode = UITextFieldViewModeAlways;
    [Fromdatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    Fromdatetxt.returnKeyType=UIReturnKeyDone;
    Fromdatetxt.selectedLineColor = [UIColor redColor];
    Fromdatetxt.selectedPlaceHolderColor = [UIColor redColor];
    Fromdatetxt.placeHolderColor = [UIColor grayColor];
    Fromdatetxt.placeholder=@"From Date";
    Fromdatetxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:Fromdatetxt];
    
    todatetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(160,40,130,40)];
    todatetxt.textAlignment=NSTextAlignmentLeft;
    todatetxt.delegate = self;
    todatetxt.textColor=[UIColor blackColor];
    [todatetxt setBackgroundColor:[UIColor clearColor]];
    todatetxt.leftViewMode = UITextFieldViewModeAlways;
    [todatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    todatetxt.returnKeyType=UIReturnKeyDone;
    todatetxt.selectedLineColor = [UIColor redColor];
    todatetxt.selectedPlaceHolderColor = [UIColor redColor];
    todatetxt.placeHolderColor = [UIColor grayColor];
    todatetxt.placeholder=@"To Date";
    todatetxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:todatetxt];
    
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
    
    
    prostatustxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,140,280,40)];
    prostatustxt.textAlignment=NSTextAlignmentLeft;
    prostatustxt.delegate = self;
    prostatustxt.textColor=[UIColor blackColor];
    [prostatustxt setBackgroundColor:[UIColor clearColor]];
    prostatustxt.leftViewMode = UITextFieldViewModeAlways;
    [prostatustxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prostatustxt.returnKeyType=UIReturnKeyDone;
    prostatustxt.selectedLineColor = [UIColor redColor];
    prostatustxt.selectedPlaceHolderColor = [UIColor redColor];
    prostatustxt.placeHolderColor = [UIColor grayColor];
    prostatustxt.placeholder=@"Status";
    prostatustxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:prostatustxt];
   
  UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,190,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,190,125,40)];
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
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
   
    if (pickerView == statuwpicker)
    {
        rowItem = [statusarr objectAtIndex: row];
    }
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
   
    if (pickerView ==statuwpicker)
    {
        statusstr=[[NSString alloc]init];
        statusstr=[NSString stringWithFormat:@"%@",[statusarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==projectpicker)
    {
        projectstr=[[NSString alloc]init];
        projectstr=[NSString stringWithFormat:@"%@",[projectarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == statuwpicker)
    {
        return [statusarr objectAtIndex:row];
    }
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
    
    statuwpicker.hidden=YES;
    statustoolbar.hidden=YES;
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
  
    if (textField ==prostatustxt) {
        statusarr=[[NSMutableArray alloc]initWithObjects:@"Follow Up",@"Call later",@"Ringing",@"not Reachable",@"Switch Off", nil];
        
        statuwpicker = [[UIPickerView alloc] init];
        [statuwpicker setDataSource: self];
        [statuwpicker setDelegate: self];
        statuwpicker.backgroundColor = [UIColor whiteColor];
        [statuwpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        statuwpicker.showsSelectionIndicator = YES;
        [statuwpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: statuwpicker];
        statuwpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [statustoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed3)];
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
        
        statustoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:statustoolbar];
        
        statustoolbar.hidden=NO;
        [prostatustxt resignFirstResponder];
        return NO;
    }
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
    
    if ([pickerView isEqual: statuwpicker]) {
        return [statusarr count];
    }
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
-(IBAction)doneBtnPressed3{
    statustoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    
    if ([statusstr isEqualToString:@""] || statusstr==nil) {
        if (statusarr.count>0) {
            prostatustxt.text=[statusarr objectAtIndex:0];
        }
    }
    else{
        prostatustxt.text=statusstr;
    }
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
    
    statuwpicker.hidden=YES;
    statustoolbar.hidden=YES;
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
