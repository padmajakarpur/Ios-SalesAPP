//
//  HomeViewController.m
//  Sales App
//
//  Created by Infinitum on 06/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+Expanded.h"
#import "MyDashboardViewController.h"
#import "MyRefrencesViewController.h"
#import "MyBookingViewController.h"
#import "SWRevealViewController.h"
#import "ProspectViewController.h"
#import <AFNetworking.h>
#import "FollowUpViewController.h"
#import "BACViewController.h"
#import "OCRViewController.h"
#import "ROXViewController.h"
#import "inventaryViewController.h"
#import "MarketingMaterialViewController.h"
#import "MyVisitsViewController.h"
#import "MyLeadsViewController.h"
#import "Retention-ESCViewController.h"
#import "EditVisitViewController.h"
#import "EscelatedESC-RETViewController.h"
#import "EventsViewController.h"
#import "BackOfficeViewController.h"
#import "TodaysVistViewController.h"
#import "BookingFormIncompleteVC.h"
#import "FollowupDesignVC.h"
@interface HomeViewController ()

@end
@implementation HomeViewController
@synthesize appDelegate,indicator,bookingcountlbl,visitscountlbl,roxcountlbl,followupslbl,baccountlbl,ESCcountlbl,backoffcountlbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    appDelegate=[[UIApplication sharedApplication] delegate];
    [self getcount];
    
    
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
    horizontallbl.text=@"Sales App";
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
    UIButton *commonbtn=[[UIButton alloc]init];
    int hig;
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Team"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"RetentionTeam"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
    }
    else
    {
        hig=screenRect.size.height*0.21;
    }
    hig=screenRect.size.height*0.15;

    hight=hig;
    UIButton *prospectbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    prospectbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [prospectbtn setClipsToBounds:YES];
    prospectbtn.tag=1;
    [prospectbtn setTitle:@"Booking" forState:UIControlStateNormal];
    [prospectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [prospectbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [prospectbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prospectbtn];
    [prospectbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [prospectbtn setBackgroundColor:[UIColor whiteColor]] ;
    
  bookingcountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.54,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    bookingcountlbl.layer.cornerRadius =screenRect.size.width*0.04;
    bookingcountlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    bookingcountlbl.backgroundColor=[UIColor redColor];
    [bookingcountlbl setTextColor:[UIColor whiteColor]];
    bookingcountlbl.textAlignment = NSTextAlignmentCenter;
    bookingcountlbl.clipsToBounds = YES;
    [self.view addSubview:bookingcountlbl];
    bookingcountlbl.hidden=YES;

    UIButton *followupbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.69,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    followupbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [followupbtn setClipsToBounds:YES];
    followupbtn.tag=2;
    [followupbtn setTitle:@"Follow Up" forState:UIControlStateNormal];
    [followupbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [followupbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [followupbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:followupbtn];
    [followupbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [followupbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    followupslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.87,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    followupslbl.layer.cornerRadius =screenRect.size.width*0.04;
    followupslbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    followupslbl.backgroundColor=[UIColor redColor];
    [followupslbl setTextColor:[UIColor whiteColor]];
    followupslbl.textAlignment = NSTextAlignmentCenter;
    followupslbl.clipsToBounds = YES;
    [self.view addSubview:followupslbl];
followupslbl.hidden=YES;
    
    UIButton *Bacbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    Bacbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [Bacbtn setClipsToBounds:YES];
    [Bacbtn setTitle:@"Visit" forState:UIControlStateNormal];
    [Bacbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Bacbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [Bacbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Bacbtn];
    Bacbtn.tag=3;
    [Bacbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [Bacbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    
    visitscountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.24,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    visitscountlbl.layer.cornerRadius =screenRect.size.width*0.04;
    visitscountlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    visitscountlbl.backgroundColor=[UIColor redColor];
    [visitscountlbl setTextColor:[UIColor whiteColor]];
    visitscountlbl.textAlignment = NSTextAlignmentCenter;
    visitscountlbl.clipsToBounds = YES;
    [self.view addSubview:visitscountlbl];
    visitscountlbl.hidden=YES;
    
    hig=hig+screenRect.size.height*0.17;

    
    UIButton *ROXbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    ROXbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [ROXbtn setClipsToBounds:YES];
    [ROXbtn setTitle:@"ROX" forState:UIControlStateNormal];
    [ROXbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ROXbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [ROXbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ROXbtn];
    ROXbtn.tag=5;
    [ROXbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [ROXbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    
    roxcountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    roxcountlbl.layer.cornerRadius =screenRect.size.width*0.04;
    roxcountlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    roxcountlbl.backgroundColor=[UIColor redColor];
    [roxcountlbl setTextColor:[UIColor whiteColor]];
    roxcountlbl.textAlignment = NSTextAlignmentCenter;
    roxcountlbl.clipsToBounds = YES;
    [self.view addSubview:roxcountlbl];
    roxcountlbl.hidden=YES;
    
    UIButton *sdbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    sdbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [sdbtn setClipsToBounds:YES];
    [sdbtn setTitle:@"Collection" forState:UIControlStateNormal];
    [sdbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sdbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [sdbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sdbtn];
    sdbtn.tag=6;
    [sdbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [sdbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    
    baccountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.24,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    baccountlbl.layer.cornerRadius =screenRect.size.width*0.04;
    baccountlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    baccountlbl.backgroundColor=[UIColor redColor];
    [baccountlbl setTextColor:[UIColor whiteColor]];
    baccountlbl.textAlignment = NSTextAlignmentCenter;
    baccountlbl.clipsToBounds = YES;
    [self.view addSubview:baccountlbl];
    baccountlbl.hidden=YES;
    
    UIButton *inventarybtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.69,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    inventarybtn.layer.cornerRadius = screenRect.size.width*0.12;
    [inventarybtn setClipsToBounds:YES];
    [inventarybtn setTitle:@"Inventory" forState:UIControlStateNormal];
    [inventarybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [inventarybtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [inventarybtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inventarybtn];
    inventarybtn.tag=7;
    [inventarybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [inventarybtn setBackgroundColor:[UIColor whiteColor]] ;
    
    hig=hig+screenRect.size.height*0.17;

    
    UIButton *OCRbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    OCRbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [OCRbtn setClipsToBounds:YES];
    [OCRbtn setTitle:@"Prospect" forState:UIControlStateNormal];
    [OCRbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [OCRbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [OCRbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OCRbtn];
    OCRbtn.tag=4;
    [OCRbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [OCRbtn setBackgroundColor:[UIColor whiteColor]] ;
    
    UIButton *marketingbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    marketingbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [marketingbtn setClipsToBounds:YES];
    marketingbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [marketingbtn setTitle:@"Marketing\nMaterial" forState:UIControlStateNormal];
    [marketingbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [marketingbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [marketingbtn.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [marketingbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:marketingbtn];
    marketingbtn.tag=8;
    [marketingbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [marketingbtn setBackgroundColor:[UIColor whiteColor]] ;
    [marketingbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

    //*** my comment ***
    UIButton *escbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.69,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    escbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [escbtn setClipsToBounds:YES];
    escbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [escbtn setTitle:@"Today's\nFollowup" forState:UIControlStateNormal];
    [escbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [escbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [escbtn.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [escbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:escbtn];
    escbtn.tag=9;
    [escbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [escbtn setBackgroundColor:[UIColor whiteColor]] ;

    ESCcountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.87,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    ESCcountlbl.layer.cornerRadius =screenRect.size.width*0.04;
    ESCcountlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    ESCcountlbl.backgroundColor=[UIColor redColor];
    [ESCcountlbl setTextColor:[UIColor whiteColor]];
    ESCcountlbl.textAlignment = NSTextAlignmentCenter;
    ESCcountlbl.clipsToBounds = YES;
    [self.view addSubview:ESCcountlbl];
        ESCcountlbl.hidden=YES;

    hig=hig+screenRect.size.height*0.17;

    
    UIButton *handovrbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    handovrbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [handovrbtn setClipsToBounds:YES];
    handovrbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [handovrbtn setTitle:@"Hand\nover" forState:UIControlStateNormal];
    [handovrbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [handovrbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [handovrbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:handovrbtn];
    handovrbtn.tag=10;
    [handovrbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [handovrbtn setBackgroundColor:[UIColor whiteColor]] ;
    [handovrbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *performancebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    performancebtn.layer.cornerRadius = screenRect.size.width*0.12;
    [performancebtn setClipsToBounds:YES];
    performancebtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [performancebtn setTitle:@"Perfor-\nmance" forState:UIControlStateNormal];
    [performancebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [performancebtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [performancebtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:performancebtn];
    performancebtn.tag=11;
    [performancebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [performancebtn setBackgroundColor:[UIColor whiteColor]] ;
    [performancebtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *block=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.69,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    block.layer.cornerRadius = screenRect.size.width*0.12;
    [block setClipsToBounds:YES];
    block.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [block setTitle:@"Block\nunits" forState:UIControlStateNormal];
    [block setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [block setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [block.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [block addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:block];
    block.tag=12;
    [block.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [block setBackgroundColor:[UIColor whiteColor]] ;
    [block.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    hig=hig+screenRect.size.height*0.17;
    
    UIButton *eventsbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    eventsbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [eventsbtn setClipsToBounds:YES];
    eventsbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [eventsbtn setTitle:@"Events" forState:UIControlStateNormal];
    [eventsbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eventsbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [eventsbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventsbtn];
    eventsbtn.tag=15;
    [eventsbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [eventsbtn setBackgroundColor:[UIColor whiteColor]] ;
    [eventsbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    commonbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    commonbtn.layer.cornerRadius = screenRect.size.width*0.12;
    [commonbtn setClipsToBounds:YES];
    commonbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [commonbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commonbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [commonbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commonbtn];
    commonbtn.tag=13;
    [commonbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [commonbtn setBackgroundColor:[UIColor whiteColor]] ;
    [commonbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    commonbtn.hidden=YES;
    
    //set booking form incomplete button
    UIButton *eventsbtn1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    eventsbtn1.layer.cornerRadius = screenRect.size.width*0.12;
    [eventsbtn1 setClipsToBounds:YES];
    eventsbtn1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [eventsbtn1 setTitle:@"Booking\nform\nincomplete " forState:UIControlStateNormal];
    [eventsbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eventsbtn1 setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [eventsbtn1 addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventsbtn1];
    eventsbtn1.tag=17;
    [eventsbtn1.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [eventsbtn1 setBackgroundColor:[UIColor whiteColor]] ;
    [eventsbtn1.titleLabel setTextAlignment:NSTextAlignmentCenter];

    UIButton* Backofficebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.69,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
    Backofficebtn.layer.cornerRadius = screenRect.size.width*0.12;
    [Backofficebtn setClipsToBounds:YES];
    Backofficebtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [Backofficebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Backofficebtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [Backofficebtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Backofficebtn];
    Backofficebtn.tag=16;
    [Backofficebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
    [Backofficebtn setBackgroundColor:[UIColor whiteColor]] ;
    [Backofficebtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
                [Backofficebtn setTitle:@"Back Office ESC" forState:UIControlStateNormal];
    
    backoffcountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.87,hig,screenRect.size.width*0.08,screenRect.size.width*0.08)];
    backoffcountlbl.layer.cornerRadius =screenRect.size.width*0.04;
    backoffcountlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    backoffcountlbl.backgroundColor=[UIColor redColor];
    [backoffcountlbl setTextColor:[UIColor whiteColor]];
    backoffcountlbl.textAlignment = NSTextAlignmentCenter;
    backoffcountlbl.clipsToBounds = YES;
    backoffcountlbl.hidden=YES;
    [self.view addSubview:backoffcountlbl];
    

    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Team"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]) {
             [commonbtn setTitle:@"ESC\ncollection" forState:UIControlStateNormal];
         commonbtn.hidden=NO;
     }
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"RetentionTeam"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
        [commonbtn setTitle:@"Retention" forState:UIControlStateNormal];
        commonbtn.hidden=NO;
    }
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"]||[[prefs objectForKey:@"role_name"] isEqualToString:@"Retention_Manager"]) {
        
    
//      UIButton* Escletedbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.69,hig,screenRect.size.width*0.24,screenRect.size.width*0.24)];
//        Escletedbtn.layer.cornerRadius = screenRect.size.width*0.12;
//        [Escletedbtn setClipsToBounds:YES];
//        Escletedbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [Escletedbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [Escletedbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//        [Escletedbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:Escletedbtn];
//        Escletedbtn.tag=14;
//        [Escletedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.040]];
//        [Escletedbtn setBackgroundColor:[UIColor whiteColor]] ;
//        [Escletedbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Escalation_Manager"])
//            [Escletedbtn setTitle:@"ESC\nEscalated" forState:UIControlStateNormal];
//
//        else
//            [Escletedbtn setTitle:@"Retention\nEscalated" forState:UIControlStateNormal];
    }
//    UIButton *fbbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.06,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//    fbbtn.layer.cornerRadius = screenRect.size.width*0.06;
//    //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:fbbtn];
//    fbbtn.backgroundColor=[UIColor whiteColor];
//    [[fbbtn imageView] setContentMode: UIViewContentModeCenter];
//    [fbbtn setImage:[UIImage imageNamed:@"facebook-app-symbol.png"] forState:UIControlStateNormal];
//
//    UIButton *twitterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//    twitterbtn.layer.cornerRadius = screenRect.size.width*0.06;
//    //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:twitterbtn];
//    twitterbtn.backgroundColor=[UIColor whiteColor];
//    [[twitterbtn imageView] setContentMode: UIViewContentModeCenter];
//    [twitterbtn setImage:[UIImage imageNamed:@"twitter-logo-silhouette.png"] forState:UIControlStateNormal];
//
//    UIButton *googlebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.44,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//    googlebtn.layer.cornerRadius = screenRect.size.width*0.06;
//    //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:googlebtn];
//    googlebtn.backgroundColor=[UIColor whiteColor];
//    [[googlebtn imageView] setContentMode: UIViewContentModeCenter];
//    [googlebtn setImage:[UIImage imageNamed:@"google-plus-logo.png"] forState:UIControlStateNormal];
//
//    UIButton *youtubebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.63,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//    youtubebtn.layer.cornerRadius = screenRect.size.width*0.06;
//    //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:youtubebtn];
//    youtubebtn.backgroundColor=[UIColor whiteColor];
//    [[youtubebtn imageView] setContentMode: UIViewContentModeCenter];
//    [youtubebtn setImage:[UIImage imageNamed:@"youtube.png"] forState:UIControlStateNormal];
//
//    UIButton *linlin=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.82   ,screenRect.size.height*0.92,screenRect.size.width*0.12,screenRect.size.width*0.12)];
//    linlin.layer.cornerRadius = screenRect.size.width*0.06;
//    //  [OCRbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:linlin];
//    linlin.backgroundColor=[UIColor whiteColor];
//    [[linlin imageView] setContentMode: UIViewContentModeCenter];
//    [linlin setImage:[UIImage imageNamed:@"linkedin-logo.png"] forState:UIControlStateNormal];
    
//
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
      prospectbtn.frame=CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.15,screenRect.size.width*0.20,screenRect.size.width*0.20);
        prospectbtn.layer.cornerRadius = screenRect.size.width*0.10;
      
       followupbtn.frame=CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.15,screenRect.size.width*0.20,screenRect.size.width*0.20);
        followupbtn.layer.cornerRadius = screenRect.size.width*0.10;
      
        Bacbtn.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.15,screenRect.size.width*0.20,screenRect.size.width*0.20);
        Bacbtn.layer.cornerRadius = screenRect.size.width*0.10;
      
        
      ROXbtn.frame=CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.35,screenRect.size.width*0.20,screenRect.size.width*0.20);
        ROXbtn.layer.cornerRadius = screenRect.size.width*0.10;
     
       sdbtn.frame= CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.35,screenRect.size.width*0.20,screenRect.size.width*0.20);
        sdbtn.layer.cornerRadius = screenRect.size.width*0.10;
      
       inventarybtn.frame=CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.35,screenRect.size.width*0.20,screenRect.size.width*0.20);
        inventarybtn.layer.cornerRadius = screenRect.size.width*0.10;
        
       OCRbtn.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.55,screenRect.size.width*0.20,screenRect.size.width*0.20);
        OCRbtn.layer.cornerRadius = screenRect.size.width*0.10;
    marketingbtn.frame=CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.55,screenRect.size.width*0.20,screenRect.size.width*0.20);
        marketingbtn.layer.cornerRadius = screenRect.size.width*0.10;
        //*** my comment ***//
//       escbtn.frame=CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.55,screenRect.size.width*0.20,screenRect.size.width*0.20);
//        escbtn.layer.cornerRadius = screenRect.size.width*0.10;
       handovrbtn.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.75,screenRect.size.width*0.20,screenRect.size.width*0.20);
        handovrbtn.layer.cornerRadius = screenRect.size.width*0.10;
        performancebtn.frame=CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.75,screenRect.size.width*0.20,screenRect.size.width*0.20);
        performancebtn.layer.cornerRadius = screenRect.size.width*0.10;
        block.frame=CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.75,screenRect.size.width*0.20,screenRect.size.width*0.20);
        block.layer.cornerRadius = screenRect.size.width*0.10;
        

        
//    fbbtn.frame=CGRectMake(screenRect.size.width*0.12,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//        fbbtn.layer.cornerRadius = screenRect.size.width*0.045;
//        twitterbtn.frame=CGRectMake(screenRect.size.width*0.29,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//        twitterbtn.layer.cornerRadius = screenRect.size.width*0.045;
//        googlebtn.frame=CGRectMake(screenRect.size.width*0.46,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//        googlebtn.layer.cornerRadius = screenRect.size.width*0.045;
//        youtubebtn.frame=CGRectMake(screenRect.size.width*0.63,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//        youtubebtn.layer.cornerRadius = screenRect.size.width*0.045;
//        linlin.frame=CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.92,screenRect.size.width*0.09,screenRect.size.width*0.09);
//        linlin.layer.cornerRadius = screenRect.size.width*0.045;
//
//
//        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
//        indicator.color=[UIColor whiteColor];
//        indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
//        [self.view addSubview:indicator];
//        [indicator bringSubviewToFront:self.view];
//        indicator.layer.cornerRadius=15.0f;
    }
}
-(void)getcount
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"userid"];
    
    [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getCounts.php?",[prefs objectForKey:@"Link"]];
    
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"counts"];
        NSMutableDictionary *mutableDict = [dic mutableCopy];
        for (NSString *key in [dic allKeys]) {
            if ([dic[key] isEqual:[NSNull null]]) {
                mutableDict[key] = @"0";
            }
        }
        
        dic = [mutableDict copy];
        if (![[dic objectForKey:@"bookings"]isEqualToString:@"0"] &&[dic objectForKey:@"bookings"]!=nil) {
            bookingcountlbl.text=[dic objectForKey:@"bookings"];
            bookingcountlbl.hidden=NO;
            if (abs([[dic objectForKey:@"bookings"] intValue])> 99) {

               CGSize stringsize = [[dic objectForKey:@"bookings"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            
            bookingcountlbl.frame =CGRectMake(screenRect.size.width*0.54,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
            }
        }
        
        if (![[dic objectForKey:@"visits"]isEqualToString:@"0"] &&[dic objectForKey:@"visits"]!=nil) {
            visitscountlbl.text=[dic objectForKey:@"visits"];
            visitscountlbl.hidden=NO;
              if (abs([[dic objectForKey:@"visits"] intValue])> 99) {
            
            CGSize stringsize = [[dic objectForKey:@"visits"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            
            visitscountlbl.frame =CGRectMake(screenRect.size.width*0.24,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
              }
        }
        
        if (![[dic objectForKey:@"followups"]isEqualToString:@"0"] &&[dic objectForKey:@"followups"]!=nil) {
            followupslbl.text=[dic objectForKey:@"followups"];
            followupslbl.hidden=NO;
            
             if (abs([[dic objectForKey:@"followups"] intValue])> 99) {
            CGSize stringsize = [[dic objectForKey:@"followups"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            
            followupslbl.frame =CGRectMake(screenRect.size.width*0.87,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
             }

        }
        hight=hight+screenRect.size.height*0.17;
        
        if (![[dic objectForKey:@"bac"]isEqualToString:@"0"] &&[dic objectForKey:@"bac"]!=nil) {
            baccountlbl.text=[dic objectForKey:@"bac"];
            baccountlbl.hidden=NO;
             if (abs([[dic objectForKey:@"bac"] intValue])> 99) {
            CGSize stringsize = [[dic objectForKey:@"bac"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            
            baccountlbl.frame =CGRectMake(screenRect.size.width*0.24,hight,screenRect.size.width*0.08,screenRect.size.width*0.08);
             }
        }
        
        if (![[dic objectForKey:@"rox"]isEqualToString:@"0"] &&[dic objectForKey:@"rox"]!=nil) {
            roxcountlbl.text=[dic objectForKey:@"rox"];
            roxcountlbl.hidden=NO;
              if (abs([[dic objectForKey:@"rox"] intValue])> 99) {
            CGSize stringsize = [[dic objectForKey:@"rox"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            
            roxcountlbl.frame=CGRectMake(screenRect.size.width*0.55,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
              }
        }
        hight=hight+screenRect.size.height*0.17;

        //*** Temp this code is hide ****
        
//        if (![[dic objectForKey:@"escalations"]isEqualToString:@"0"] &&[dic objectForKey:@"escalations"]!=nil) {
//            ESCcountlbl.text=[dic objectForKey:@"escalations"];
//            ESCcountlbl.hidden=NO;
//   if (abs([[dic objectForKey:@"escalations"] intValue])> 99) {
//            CGSize stringsize = [[dic objectForKey:@"escalations"] sizeWithFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
//            ESCcountlbl.frame = CGRectMake(screenRect.size.width*0.87,hight,stringsize.width+ screenRect.size.width*0.03,screenRect.size.width*0.08);
//   }
        //}
           } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (void)performFlip {
    [UIView transitionWithView: self.view
                      duration: 1.3
                       options: UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        // My flip specific code
                    }
                    completion:^(BOOL finished) {
                    }
     ];
}
-(void) viewDidAppear:(BOOL)animated
{
    [self checkuservalidaty];
    [self getuserinfo];
    [self getproject];
    if (appDelegate.calltime==1) {
        [self performSelector:@selector(performFlip) withObject:nil afterDelay: 0.0];
        appDelegate.calltime++;
    }
}
-(void)checkuservalidaty
{
    if (![appDelegate.isvalid isEqual:@"yes"]) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"username"]  forKey:@"assigned_user_name"];
        [params setObject:@"00BE80E788BF829D883605AF19085EBC"  forKey:@"license_key"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"assigned_user_id"];
        [params setObject:@"validate_user"  forKey:@"task"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@checkuservalidity.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            if ([[dic objectForKey:@"user_validity"]isEqualToString:@"yes"]) {
                appDelegate.isvalid=[dic objectForKey:@"user_validity"];
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)getproject
{
    if (!(appDelegate.projectarr.count>0)) {
        appDelegate.projectarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getsyncproject.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
          //  NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            {
                appDelegate.projectarr=[dic objectForKey:@"projects"];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)getuserinfo
{
    if (!(appDelegate.userinfoarr.count>0)) {
        appDelegate.userinfoarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        // [params setObject:@"http://49.248.43.178/xrbia/" forKey:@"url"];
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getusersinfo.php?",[prefs objectForKey:@"Link"]];
        [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [indicator startAnimating];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            //  NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            {
                appDelegate.userinfoarr=[dic objectForKey:@"users"];
                NSMutableArray* userinfoarr=[dic objectForKey:@"users"];
                for (int i=0; i<userinfoarr.count; i++) {
                    NSDictionary * dict=[userinfoarr objectAtIndex:i];
                    if ([[dict objectForKey:@"id"] isEqualToString:[prefs objectForKey:@"user_id"]]) {
                        appDelegate.userinfodict=[dict mutableCopy];
                    }
                }
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)getleads
{
    if(!(appDelegate.leadsarr.count>0))
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [indicator startAnimating];
        NSURL *url;
        NSMutableString *httpBodyString;
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"date_modified_sugar_format_sync= &assigned_user_id=%@&role_name=%@&role_id=%@&doneInitialSync=no",[prefs objectForKey:@"user_id"],[prefs objectForKey:@"role_name"],[prefs objectForKey:@"role_id"]]];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getsynclead.php",[prefs objectForKey:@"Link"]];
        
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error)
            {
                NSLog(@"Failed to submit request");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [indicator stopAnimating];
            }
            else
            {
                NSMutableString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                                     length:[data length] encoding: NSUTF8StringEncoding];
                NSLog(@"content %@",content);
                NSError *error;
                if ([content isEqualToString:@""]) {
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [indicator stopAnimating];
                    
                }else {
                    appDelegate.leadsarr=[[NSMutableArray alloc]init];
                    //   NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSDictionary* userDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                    appDelegate.leadsarr=[dic objectForKey:@"leads"];
                    [indicator stopAnimating];
                }
            }
        }];
    }
}
-(void)prospect:(UIButton *)btn
{
    if (btn.tag==1) {
        MyBookingViewController *mainvc=[[MyBookingViewController alloc] initWithNibName:@"MyBookingViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
//    if (btn.tag==2) {
//        FollowUpViewController *mainvc=[[FollowUpViewController alloc] initWithNibName:@"FollowUpViewController" bundle:nil];
//        mainvc.comestr=@"followup";
//        [self.navigationController pushViewController:mainvc animated:YES];
//    }
   // FollowupDesignVC.h
        if (btn.tag==2) {
            FollowupDesignVC *mainvc=[[FollowupDesignVC alloc] initWithNibName:@"FollowupDesignVC" bundle:nil];
           // mainvc.comestr=@"followup";
            [self.navigationController pushViewController:mainvc animated:YES];
        }

    if (btn.tag==3) {
         MyVisitsViewController*mainvc=[[MyVisitsViewController alloc] initWithNibName:@"MyVisitsViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==4) {
        MyLeadsViewController*mainvc=[[MyLeadsViewController alloc] initWithNibName:@"MyLeadsViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==6) {
//        OCRViewController *mainvc=[[OCRViewController alloc] initWithNibName:@"OCRViewController" bundle:nil];
//        mainvc.tag=btn.tag;
//        [self.navigationController pushViewController:mainvc animated:YES];
        BACViewController *mainvc=[[BACViewController alloc] initWithNibName:@"BACViewController" bundle:nil];
        mainvc.comestr=@"bac";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==5) {
        ROXViewController *mainvc=[[ROXViewController alloc] initWithNibName:@"ROXViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==7) {
        inventaryViewController *mainvc=[[inventaryViewController alloc] initWithNibName:@"inventaryViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==8) {
        MarketingMaterialViewController *mainvc=[[MarketingMaterialViewController alloc] initWithNibName:@"MarketingMaterialViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==9) {
//        OCRViewController *mainvc=[[OCRViewController alloc] initWithNibName:@"OCRViewController" bundle:nil];
//        mainvc.comestr=@"ESC";
// [self.navigationController pushViewController:mainvc animated:YES];
        
// *******This code is for today's followup********
        
        EscelatedESC_RETViewController *mainvc=[[EscelatedESC_RETViewController alloc] initWithNibName:@"EscelatedESC-RETViewController" bundle:nil];
        mainvc.comestr=btn.titleLabel.text;
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==10) {
        OCRViewController *mainvc=[[OCRViewController alloc] initWithNibName:@"OCRViewController" bundle:nil];
        mainvc.comestr=@"handover";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==11) {
        OCRViewController *mainvc=[[OCRViewController alloc] initWithNibName:@"OCRViewController" bundle:nil];
        mainvc.comestr=@"performance";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==12) {
        FollowUpViewController *mainvc=[[FollowUpViewController alloc] initWithNibName:@"FollowUpViewController" bundle:nil];
        mainvc.comestr=@"block";
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==13) {
        Retention_ESCViewController *mainvc=[[Retention_ESCViewController alloc] initWithNibName:@"Retention-ESCViewController" bundle:nil];
        mainvc.comestr=btn.titleLabel.text;
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==14) {
        //This is not in use
//        EscelatedESC_RETViewController *mainvc=[[EscelatedESC_RETViewController alloc] initWithNibName:@"EscelatedESC-RETViewController" bundle:nil];
//        mainvc.comestr=btn.titleLabel.text;
//        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==15) {
        EventsViewController *mainvc=[[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    if (btn.tag==16) {
        BackOfficeViewController *mainvc=[[BackOfficeViewController alloc] initWithNibName:@"BackOfficeViewController" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
   // BookingFormIncompleteVC.h
    if (btn.tag==17) {
        BookingFormIncompleteVC *mainvc=[[BookingFormIncompleteVC alloc] initWithNibName:@"BookingFormIncompleteVC" bundle:nil];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
}
-(void)gotodashboard
{
    MyDashboardViewController *mainvc=[[MyDashboardViewController alloc] initWithNibName:@"MyDashboardViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)myrefrences
{
    MyRefrencesViewController *mainvc=[[MyRefrencesViewController alloc] initWithNibName:@"MyRefrencesViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)home
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
