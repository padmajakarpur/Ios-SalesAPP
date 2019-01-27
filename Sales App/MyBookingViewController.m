//
//  MyBookingViewController.m
//  Sales App
//
//  Created by Infinitum on 07/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MyBookingViewController.h"
#import "UIColor+Expanded.h"
#import "MYOwnViewController.h"
#import "RegularSchemeViewController.h"
#import "BookingInformationViewController.h"
#import "AddbookingViewController.h"
#import "HomeViewController.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"
#import "BookingShiftingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DiscountApprovalViewController.h"


@interface MyBookingViewController ()
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation MyBookingViewController
@synthesize tableViewHome,indicator,bookingarr,comestr,searchview,totalarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // appDelegate=[[UIApplication sharedApplication] delegate];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

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
    
    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.90,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setTitle:@"\uE145" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn.titleLabel setFont:customFontdregs];
    [addbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:addbtn];
    
    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [filtbtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [filtbtn setTitle:@"\uE8B6" forState:UIControlStateNormal];
    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filtbtn.titleLabel setFont:customFontdregs];
    [filtbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:filtbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
 //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.05];
    horizontallbl.text=@"MY BOOKINGS";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    if ([comestr isEqualToString:@"saleshead"]) {
        horizontallbl.text=@"HANDOVER";
        [addbtn removeFromSuperview];
    }
    if ([comestr isEqualToString:@"handover"]) {
        horizontallbl.text=@"HANDOVER";
        [addbtn removeFromSuperview];
    }
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
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.85,screenRect.size.width*0.17,screenRect.size.width*0.17)];
    Createvoucherbtn.layer.cornerRadius = screenRect.size.width*0.085;
    [Createvoucherbtn setTitle:@"D" forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [Createvoucherbtn addTarget:self action:@selector(discountapproval) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.065]];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]] ;
    [self.view addSubview:Createvoucherbtn];
    
   Createvoucherbtn.layer.masksToBounds = YES;
    Createvoucherbtn.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    Createvoucherbtn.layer.shadowOffset = CGSizeMake(0, 2.0f);
    Createvoucherbtn.layer.shadowOpacity = 2.0f;
    Createvoucherbtn.layer.shadowRadius = 2.0f;
    Createvoucherbtn.layer.masksToBounds = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getbookingdata];
}
-(void)getbookingdata
{
    if (!(bookingarr.count>0)) {
        bookingarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
        [params setObject:@"getBookings"  forKey:@"requestType"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbookingdata.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            bookingarr=[[NSMutableArray alloc]init];
            NSLog(@"JSON: %@", userDict);

            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                bookingarr=[dic objectForKey:@"bookings"];
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
        for (int i=0; i<totalarr.count; i++) {
            NSDictionary *tempdict=[totalarr objectAtIndex:i];
            NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_name"]];
            if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"cutomer_name"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"booking_date"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"flat_no"] uppercaseString] containsString:[textstr uppercaseString]]) {
                [bookingarr addObject:[totalarr objectAtIndex:i]];
            }
        }
        if (textstr.length<1) {
            [bookingarr addObjectsFromArray:totalarr];
        }
        [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
}


-(void)back
{
    bookingarr= [[NSMutableArray alloc]init];
    [searchview removeFromSuperview];
    [bookingarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
}
-(void)discountapproval
{
    DiscountApprovalViewController *mainvc=[[DiscountApprovalViewController alloc] initWithNibName:@"DiscountApprovalViewController" bundle:nil];
    [self.navigationController presentViewController:mainvc animated:YES completion:nil];
}
-(void)add
{
    AddbookingViewController *mainvc=[[AddbookingViewController alloc] initWithNibName:@"AddbookingViewController" bundle:nil];
    mainvc.comefromstr=@"booking";
    [self.navigationController pushViewController:mainvc animated:YES];
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
    
//    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,0,screenRect.size.width*0.02,screenRect.size.height*0.18)];
//    leftview.backgroundColor=[UIColor whiteColor];
//    leftview.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
//    leftview.layer.shadowOffset = CGSizeMake(0, 2.0f);
//    leftview.layer.shadowOpacity = 1.0f;
//    leftview.layer.shadowRadius = 0.0f;
//    leftview.layer.masksToBounds = NO;
 //   leftview.layer.cornerRadius = 4.0f;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.25)];
    headerView.backgroundColor=[UIColor whiteColor];
   headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
   headerView.layer.shadowRadius = 0.0f;
   headerView.layer.masksToBounds = NO;
  //  headerView.layer.cornerRadius = 4.0f;
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.90,screenRect.size.height*0.06)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Customer Name :%@",[dict objectForKey:@"cutomer_name"]];
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.06,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    datelbl.textAlignment = NSTextAlignmentLeft;
    datelbl.text =[NSString stringWithFormat:@"Booking Date:%@",[dict objectForKey:@"booking_date"]];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.10,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =[NSString stringWithFormat:@"Project Name :%@",[dict objectForKey:@"project_name"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.14,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    idlbl.textAlignment = NSTextAlignmentLeft;
    idlbl.text =[NSString stringWithFormat:@"Flat No :%@",[dict objectForKey:@"flat_no"]];
    idlbl.backgroundColor = [UIColor clearColor];
    idlbl.textColor=[UIColor blackColor];
    idlbl.lineBreakMode = NSLineBreakByWordWrapping;
    idlbl.numberOfLines = 0;
    [headerView addSubview:idlbl];
    
    UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.19,screenRect.size.width*0.90,screenRect.size.height*0.003)];
    linelbl.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:linelbl];
   
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.20,screenRect.size.width*0.20,screenRect.size.height*0.04)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [Createvoucherbtn setTitle:@"Shift"forState:UIControlStateNormal];
    Createvoucherbtn.tag=indexPath.row;
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#4861AC"]] ;
    [headerView addSubview:Createvoucherbtn];
    
    UIButton *reject=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.73,screenRect.size.height*0.20,screenRect.size.width*0.20,screenRect.size.height*0.04)];
    reject.layer.cornerRadius = 4.0f;
    reject.tag=indexPath.row;
    [reject.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [reject setTitle:@"Cancel"forState:UIControlStateNormal];
    [reject setBackgroundColor:[UIColor colorWithHexString:@"#007E2F"]] ;
    [headerView addSubview:reject];
        [Createvoucherbtn addTarget:self action:@selector(shift:) forControlEvents:UIControlEventTouchUpInside];
        [reject addTarget:self action:@selector(shift:) forControlEvents:UIControlEventTouchUpInside];
    
 //   [cell.contentView addSubview:leftview];
    [cell.contentView addSubview:headerView];
    
    //   headerView.masksToBounds = NO;
    //   headerView.shadowOffset = CGSizeMake(-15, 20);
    //   headerView.shadowRadius = 5;
    //   headerView.shadowOpacity = 0.5;
    
 //   leftview.backgroundColor=[UIColor colorWithHexString:@"#00cc00"];
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.contentMode= UIViewContentModeLeft;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if ([comestr isEqualToString:@"saleshead"]||[comestr isEqualToString:@"handover"])
     {
         
     }
    else
    {
     BookingInformationViewController *mainvc=[[BookingInformationViewController alloc] initWithNibName:@"BookingInformationViewController" bundle:nil];
    mainvc.bookdict=[bookingarr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:mainvc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.26;
}


-(void)shift:(UIButton*)btn
{
    BookingShiftingViewController *mainvc=[[BookingShiftingViewController alloc] initWithNibName:@"BookingShiftingViewController" bundle:nil];

    if ([btn.titleLabel.text isEqualToString:@"Shift"]) {
        NSMutableDictionary * dict=[bookingarr objectAtIndex:btn.tag];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"getBookingOwnerFromSAP"  forKey:@"requestType"];
        [params setObject: [dict objectForKey:@"display_booking_id"] forKey:@"booking_number"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbookingdata.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary *mutableDict = [userDict mutableCopy];
            for (NSString *key in [userDict allKeys]) {
                if ([userDict[key] isEqual:[NSNull null]]) {
                    mutableDict[key] = @"";
                }
            }
            userDict = [mutableDict copy];
            if ([[userDict objectForKey:@"owner"] isEqualToString:@"BO"]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Unit is with back office shifting/cancellation not allowed"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                mainvc.dict=[bookingarr objectAtIndex:btn.tag];
                mainvc.comestr=btn.titleLabel.text;
                [self.navigationController presentViewController:mainvc animated:YES completion:nil];
            }
            [indicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    else
    {
        mainvc.dict=[bookingarr objectAtIndex:btn.tag];
        mainvc.comestr=btn.titleLabel.text;
        [self.navigationController presentViewController:mainvc animated:YES completion:nil];

    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)home
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
