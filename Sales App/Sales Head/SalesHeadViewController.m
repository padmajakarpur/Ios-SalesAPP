//
//  SalesHeadViewController.m
//  Sales App
//
//  Created by Infinitum on 19/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "SalesHeadViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "DiscApprovalViewController.h"
#import "PerformanceViewController.h"
#import "BACViewController.h"
#import "MyBookingViewController.h"
#import "Front_OfficeViewController.h"
#import "VisitScheduleViewController.h"
#import "SalesHeadHandOverViewController.h"
#import "TodaysViewController.h"
#import "TodaysVistViewController.h"
#import <AFNetworking.h>
#import "InventoryDetailsVC.h"
@interface SalesHeadViewController ()
@end

@implementation SalesHeadViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
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
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Xrbia";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10, screenRect.size.width,screenRect.size.height*0.90)];
    dashbgimageview.image=[UIImage imageNamed:@"Vangani Ele.png"];
    dashbgimageview.clipsToBounds=YES;
    dashbgimageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:dashbgimageview];
    
    UIImageView *partiallimageview=[[UIImageView alloc]initWithFrame:dashbgimageview.frame];
    //  partiallimageview.backgroundColor=[UIColor colorWithHexString:@"#FFA500"];
    partiallimageview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:partiallimageview];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Executives"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Admin"]) {
        UIButton *prospectbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.20,screenRect.size.width*0.30,screenRect.size.width*0.30)];
        prospectbtn.layer.cornerRadius = screenRect.size.width*0.15;
        [prospectbtn setClipsToBounds:YES];
        prospectbtn.tag=11;
        [prospectbtn setTitle:@"Customer\nSearch" forState:UIControlStateNormal];
        prospectbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [prospectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [prospectbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [prospectbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:prospectbtn];
        [prospectbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [prospectbtn setBackgroundColor:[UIColor whiteColor]] ;
        [prospectbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIButton *Bacbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.45,screenRect.size.width*0.30,screenRect.size.width*0.30)];
        Bacbtn.layer.cornerRadius = screenRect.size.width*0.15;
        [Bacbtn setTitle:@"Visit\nSchedule" forState:UIControlStateNormal];
        Bacbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [Bacbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Bacbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [Bacbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Bacbtn];
        Bacbtn.tag=12;
        [Bacbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [Bacbtn setBackgroundColor:[UIColor whiteColor]] ;
        [Bacbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIButton *todaysbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.70,screenRect.size.width*0.30,screenRect.size.width*0.30)];
        todaysbtn.layer.cornerRadius = screenRect.size.width*0.15;
        [todaysbtn setTitle:@"Todays\nVisit" forState:UIControlStateNormal];
        todaysbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [todaysbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [todaysbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [todaysbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:todaysbtn];
        todaysbtn.tag=13;
        [todaysbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [todaysbtn setBackgroundColor:[UIColor whiteColor]] ;
        [todaysbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        
        _todayslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.59,screenRect.size.height*0.70,screenRect.size.width*0.08,screenRect.size.width*0.08)];
        _todayslbl.layer.cornerRadius =screenRect.size.width*0.04;
        _todayslbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        _todayslbl.backgroundColor=[UIColor redColor];
        [_todayslbl setTextColor:[UIColor whiteColor]];
        _todayslbl.textAlignment = NSTextAlignmentCenter;
        _todayslbl.clipsToBounds = YES;
        [self.view addSubview:_todayslbl];
        _todayslbl.hidden=YES;
        
    }
    else
    {
        UIButton *prospectbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.15,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        prospectbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [prospectbtn setClipsToBounds:YES];
        prospectbtn.tag=1;
        [prospectbtn setTitle:@"Discount\nApproval" forState:UIControlStateNormal];
        prospectbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [prospectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [prospectbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [prospectbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:prospectbtn];
        [prospectbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [prospectbtn setBackgroundColor:[UIColor whiteColor]] ;
        [prospectbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

        UIButton *followupbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.15,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        followupbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [followupbtn setClipsToBounds:YES];
        followupbtn.tag=2;
        [followupbtn setTitle:@"Transfer\nApproval" forState:UIControlStateNormal];
        followupbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [followupbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [followupbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [followupbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:followupbtn];
        [followupbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [followupbtn setBackgroundColor:[UIColor whiteColor]] ;
        [followupbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

        UIButton *Bacbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.35,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        Bacbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [Bacbtn setClipsToBounds:YES];
        [Bacbtn setTitle:@"Cancel\nApproval" forState:UIControlStateNormal];
        Bacbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [Bacbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Bacbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [Bacbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Bacbtn];
        Bacbtn.tag=3;
        [Bacbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [Bacbtn setBackgroundColor:[UIColor whiteColor]] ;
        [Bacbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

        UIButton *OCRbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.35,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        OCRbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [OCRbtn setClipsToBounds:YES];
        [OCRbtn setTitle:@"MPS" forState:UIControlStateNormal];
        [OCRbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [OCRbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [OCRbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:OCRbtn];
        OCRbtn.tag=4;
        [OCRbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [OCRbtn setBackgroundColor:[UIColor whiteColor]] ;
        [OCRbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

        UIButton *ROXbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.55,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        ROXbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [ROXbtn setClipsToBounds:YES];
        [ROXbtn setTitle:@"ESC" forState:UIControlStateNormal];
        [ROXbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ROXbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [ROXbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ROXbtn];
        ROXbtn.tag=5;
        [ROXbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [ROXbtn setBackgroundColor:[UIColor whiteColor]] ;
        [ROXbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

        UIButton *sdbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.55,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        sdbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [sdbtn setClipsToBounds:YES];
        [sdbtn setTitle:@"Inventory\nDetails" forState:UIControlStateNormal];
         sdbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [sdbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sdbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [sdbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sdbtn];
        sdbtn.tag=6;
        [sdbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [sdbtn setBackgroundColor:[UIColor whiteColor]] ;
        [sdbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIButton *todaysbooking=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.75,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        todaysbooking.layer.cornerRadius = screenRect.size.width*0.14;
        [todaysbooking setClipsToBounds:YES];
        [todaysbooking setTitle:@"Todays\nVisit" forState:UIControlStateNormal];
        [todaysbooking setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [todaysbooking setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [todaysbooking addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:todaysbooking];
        todaysbooking.tag=7;
        todaysbooking.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [todaysbooking.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [todaysbooking setBackgroundColor:[UIColor whiteColor]] ;
        [todaysbooking.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        
        UIButton *todaysbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.75,screenRect.size.width*0.28,screenRect.size.width*0.28)];
        todaysbtn.layer.cornerRadius = screenRect.size.width*0.14;
        [todaysbtn setClipsToBounds:YES];
        [todaysbtn setTitle:@"Todays\nBooking" forState:UIControlStateNormal];
        [todaysbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [todaysbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        [todaysbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:todaysbtn];
        todaysbtn.tag=8;
        todaysbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [todaysbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
        [todaysbtn setBackgroundColor:[UIColor whiteColor]] ;
        [todaysbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
//    UIButton *inventarybtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.72,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//    inventarybtn.layer.cornerRadius = screenRect.size.width*0.14;
//    [inventarybtn setClipsToBounds:YES];
//    [inventarybtn setTitle:@"Inventory" forState:UIControlStateNormal];
//    [inventarybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [inventarybtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    [inventarybtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:inventarybtn];
//    inventarybtn.tag=7;
//    [inventarybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//    [inventarybtn setBackgroundColor:[UIColor whiteColor]] ;
//
//    UIButton *marketingbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.72,screenRect.size.width*0.28,screenRect.size.width*0.28)];
//    marketingbtn.layer.cornerRadius = screenRect.size.width*0.14;
//    [marketingbtn setClipsToBounds:YES];
//    marketingbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [marketingbtn setTitle:@"Marketing\nMaterial" forState:UIControlStateNormal];
//    [marketingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [marketingbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    [marketingbtn.titleLabel setTextAlignment: NSTextAlignmentCenter];
//    [marketingbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:marketingbtn];
//    marketingbtn.tag=8;
//    [marketingbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//    [marketingbtn setBackgroundColor:[UIColor whiteColor]] ;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Executives"]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
        [params setObject:@"getfrontcountsuser"  forKey:@"requestType"];
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getfrontdetcnt.php?",[prefs objectForKey:@"Link"]];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary *mutableDict = [userDict mutableCopy];
            for (NSString *key in [userDict allKeys]) {
                if ([userDict[key] isEqual:[NSNull null]]) {
                    mutableDict[key] = @"0";
                }
            }
            userDict = [mutableDict copy];
            if (![[userDict objectForKey:@"Todays_frontdetuser_cnt"]isEqualToString:@"0"]) {
                _todayslbl.text=[userDict objectForKey:@"bookings"];
                _todayslbl.hidden=NO;
                if (abs([[userDict objectForKey:@"Todays_frontdetuser_cnt"] intValue])> 99) {

                    CGSize stringsize = [[userDict objectForKey:@"Todays_frontdetuser_cnt"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];

                    _todayslbl.frame =CGRectMake(screenRect.size.width*0.54,screenRect.size.height*0.70,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
                }
            }
        }
            failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prospect:(UIButton *)btn
{
    if (btn.tag==1||btn.tag==2|btn.tag==3) {
        DiscApprovalViewController *mainvc=[[DiscApprovalViewController alloc] initWithNibName:@"DiscApprovalViewController" bundle:nil];
        mainvc.str=[NSString stringWithFormat:@"%ld",(long)btn.tag];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==4) {
        PerformanceViewController *mainvc=[[PerformanceViewController alloc] initWithNibName:@"PerformanceViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==5) {
        BACViewController *mainvc=[[BACViewController alloc] initWithNibName:@"BACViewController" bundle:nil];
        mainvc.comestr=@"saleshead";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==6) {
        //*****COMMENT*******
//         SalesHeadHandOverViewController*mainvc=[[SalesHeadHandOverViewController alloc] initWithNibName:@"SalesHeadHandOverViewController" bundle:nil];
//        [self.navigationController pushViewController:mainvc animated:YES];
        InventoryDetailsVC *mainvc=[[InventoryDetailsVC alloc] initWithNibName:@"InventoryDetailsVC" bundle:nil];
               [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==7) {
        TodaysViewController*mainvc=[[TodaysViewController alloc] initWithNibName:@"TodaysViewController" bundle:nil];
        mainvc.typestr=@"Todays Visit";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==8) {
        TodaysViewController*mainvc=[[TodaysViewController alloc] initWithNibName:@"TodaysViewController" bundle:nil];
        mainvc.typestr=@"Todays Bookings";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==11) {
        Front_OfficeViewController *mainvc=[[Front_OfficeViewController alloc] initWithNibName:@"Front_OfficeViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==12) {
        VisitScheduleViewController *mainvc=[[VisitScheduleViewController alloc] initWithNibName:@"VisitScheduleViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==13) {
        TodaysVistViewController *mainvc=[[TodaysVistViewController alloc] initWithNibName:@"TodaysVistViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
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
