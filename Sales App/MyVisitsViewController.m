//
//  MyVisitsViewController.m
//  Sales App
//
//  Created by Infinitum on 01/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MyVisitsViewController.h"
#import "UIColor+Expanded.h"
#import "HomeViewController.h"
#import <AFNetworking.h>
#import "AddVisitViewController.h"
#import "EditVisitViewController.h"
#import "AddbookingViewController.h"
#import "SWRevealViewController.h"
#import "FollowUpEditViewController.h"
@interface MyVisitsViewController ()

@end

@implementation MyVisitsViewController
@synthesize tableViewHome,indicator,searchview,visitarr,totalarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
  //  appDelegate=[[UIApplication sharedApplication] delegate];

    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    //  [self generatenavigation];
    
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
    [self.view addSubview:navigationbtn];

    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [filtbtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [filtbtn setTitle:@"\uE8B6" forState:UIControlStateNormal];
    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filtbtn.titleLabel setFont:customFontdregs];
    [filtbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:filtbtn];
    
//    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.90,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
//    [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
//    [addbtn setTitle:@"\uE145" forState:UIControlStateNormal];
//    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [addbtn.titleLabel setFont:customFontdregs];
//    [addbtn setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:addbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Visits";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
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
    visitarr= [[NSMutableArray alloc]init];
    [visitarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];

}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getsyncsalesperson.php",[prefs objectForKey:@"Link"]];

//    [indicator startAnimating];
//    NSURL * url;
//    NSMutableString *httpBodyString;
//    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"date_modified_sugar_format_sync= &assigned_user_id=%@&role_name=%@&role_id=%@&doneInitialSync=no",[prefs objectForKey:@"user_id"],[prefs objectForKey:@"role_name"],[prefs objectForKey:@"role_id"]]];
//
//    url=[[NSURL alloc] initWithString:urlString];
//    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
//
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
//
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        if (error)
//        {
//            NSLog(@"Failed to submit request");
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"My Tuition" message:@"Failed to submit request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            [indicator stopAnimating];
//        }
//        else
//        {
//            NSMutableString *content = [[NSString alloc]  initWithBytes:[data bytes]
//                                                                 length:[data length] encoding: NSUTF8StringEncoding];
//            NSLog(@"content %@",content);
//            NSError *error;
//            if ([content isEqualToString:@""]) {
//
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"My Tuition" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//                [indicator stopAnimating];
//
//            }else {
//                appDelegate.leadsarr=[[NSMutableArray alloc]init];
//                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0
//                                                                         error:nil];
//                NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//                appDelegate.visitsarr=[dic objectForKey:@"sales_person"];
//                [tableViewHome reloadData];
//                [indicator stopAnimating];
//            }
//        }
//    }];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
    [params setObject:@"" forKey:@"date_modified_sugar_format_sync"];
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"assigned_user_id"];
    [params setObject:[prefs objectForKey:@"role_name"]forKey:@"role_name"];
    [params setObject:[prefs objectForKey:@"role_id"] forKey:@"role_id"];
    [params setObject:@"no" forKey:@"doneInitialSync"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        visitarr=[[NSMutableArray alloc]init];
        totalarr=[[NSMutableArray alloc]init];

        NSLog(@"JSON: %@", userDict);
       visitarr =[[NSMutableArray alloc]init];
                        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                      visitarr=[dic objectForKey:@"sales_person"];
        totalarr=[visitarr mutableCopy];
        [tableViewHome reloadData];
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)add
{
    AddVisitViewController *mainvc=[[AddVisitViewController alloc] initWithNibName:@"AddVisitViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return visitarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict=[visitarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    //    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.02,screenRect.size.height*0.12)];
    //    leftview.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    //    leftview.layer.shadowOffset = CGSizeMake(0, 2.0f);
    //    leftview.layer.shadowOpacity = 1.0f;
    //    leftview.layer.shadowRadius = 0.0f;
    //    leftview.layer.masksToBounds = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.24)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.01,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    NSArray *myArray = [[dict objectForKey:@"name"] componentsSeparatedByString:@"-"];
    Srnolbl.text =[NSString stringWithFormat:@"Name:%@",[myArray objectAtIndex:0]];
    
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  mobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    mobilelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    mobilelbl.textAlignment = NSTextAlignmentLeft;
    NSString * str=[dict objectForKey:@"customer_mobile_c"];
    if ([[dict objectForKey:@"customer_mobile_c"] length] > 0)
    {
        str = [str substringToIndex:[str length] - 4];
        str = [str stringByAppendingString:@"XXXX"];
    }
    mobilelbl.text =[NSString stringWithFormat:@"Mobile No:%@",str];
    mobilelbl.backgroundColor = [UIColor clearColor];
    mobilelbl.textColor=[UIColor blackColor];
    mobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    mobilelbl.numberOfLines = 0;
    [headerView addSubview:mobilelbl];

    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.09,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    datelbl.textAlignment = NSTextAlignmentLeft;
    
    datelbl.text =[NSString stringWithFormat:@"Project: %@",[dict objectForKey:@"project_name"]];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.13,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    namelbl.textAlignment = NSTextAlignmentLeft;
    
    namelbl.text =[NSString stringWithFormat:@"Schedule Date: %@",[dict objectForKey:@"fu_date_c"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.17,screenRect.size.width*0.90,screenRect.size.height*0.003)];
    linelbl.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:linelbl];
    
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*0.175,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:savebtn];
    
    UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.10,screenRect.size.height*0.175,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [phonebtn2 setBackgroundColor:[UIColor clearColor]];
    [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn2.tag=indexPath.row;
    [phonebtn2 setTitle:@"Call" forState:UIControlStateNormal];
    [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    phonebtn2.titleLabel.font=font;
    [headerView addSubview:phonebtn2];
    
    UIButton *statusbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.20,screenRect.size.height*0.175,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [statusbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    statusbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    statusbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [statusbtn setTitle:@"\uE040" forState:UIControlStateNormal];
    [headerView addSubview:statusbtn];
    
    UIButton *statusbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.28,screenRect.size.height*0.175,screenRect.size.width*0.35,screenRect.size.height*.05)];
    [statusbtn2 setBackgroundColor:[UIColor clearColor]];
    [statusbtn2 addTarget:self action:@selector(gotobooking:) forControlEvents:UIControlEventTouchUpInside];
    statusbtn2.tag=indexPath.row;
    [statusbtn2 setTitle:@"Convert to booking" forState:UIControlStateNormal];
    [statusbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    statusbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    statusbtn2.titleLabel.font=font;
    [headerView addSubview:statusbtn2];
    
    UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.73,screenRect.size.height*0.175,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [editbtn setTitle:@"\uE254" forState:UIControlStateNormal];
    [headerView addSubview:editbtn];
    
    UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.81,screenRect.size.height*0.175,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [editbtn2 setBackgroundColor:[UIColor clearColor]];
  [editbtn2 addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    editbtn2.tag=indexPath.row;
    [editbtn2 setTitle:@"Edit" forState:UIControlStateNormal];
    [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    editbtn2.titleLabel.font=font;
    [headerView addSubview:editbtn2];
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
//    LeadViewController *mainvc=[[LeadViewController alloc] initWithNibName:@"LeadViewController" bundle:nil];
//    [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.25;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)back
//{
//    HomeViewController *mainvc=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//    [self.navigationController pushViewController:mainvc animated:YES];
//}

-(void)gotobooking:(UIButton*)btn
{
    AddbookingViewController *mainvc=[[AddbookingViewController alloc] initWithNibName:@"AddbookingViewController" bundle:nil];
    mainvc.comefromstr=@"Visit";
    mainvc.dict=[visitarr objectAtIndex:btn.tag];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)edit:(UIButton*)btn
{
//    EditVisitViewController *mainvc=[[EditVisitViewController alloc] initWithNibName:@"EditVisitViewController" bundle:nil];
//    mainvc.dict=[appDelegate.visitsarr objectAtIndex:btn.tag];
//    [self.navigationController pushViewController:mainvc animated:YES];
    
    FollowUpEditViewController *mainvc=[[FollowUpEditViewController alloc] initWithNibName:@"FollowUpEditViewController" bundle:nil];
    mainvc.dict=[visitarr objectAtIndex:btn.tag];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)openurl:(UIButton*)btn
{
    
    NSMutableDictionary *dict=[visitarr objectAtIndex:btn.tag];
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
            mainvc.dict=[visitarr objectAtIndex:btn.tag];
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
    [params setObject:@"Visit" forKey:@"module"];
    [params setObject:[dict objectForKey:@"customer_mobile_c"] forKey:@"mobile"];
    [params setObject:[dict objectForKey:@"customer_name_c"] forKey:@"name"];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_searchtext) {
        visitarr= [[NSMutableArray alloc]init];
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
            NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_name"]]
            ;
            if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"customer_name_c"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"customer_mobile_c"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"fu_date_c"] uppercaseString] containsString:[textstr uppercaseString]]) {
                [visitarr addObject:[totalarr objectAtIndex:i]];
            }
            
        }
        if (textstr.length<1) {
            [visitarr addObjectsFromArray:totalarr];
        }
        [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
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
