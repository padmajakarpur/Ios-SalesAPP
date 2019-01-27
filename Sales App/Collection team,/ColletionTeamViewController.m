//
//  ColletionTeamViewController.m
//  Sales App
//
//  Created by Infinitum on 25/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "ColletionTeamViewController.h"
#import "SWRevealViewController.h"
#import "UIColor+Expanded.h"
#import "NewCasesvViewController.h"
#import <AFNetworking.h>
@interface ColletionTeamViewController ()

@end

@implementation ColletionTeamViewController
@synthesize  scrollview,dataarr,filteredarr,indicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    SWRevealViewController *revealController = [self revealViewController];
     //   [revealController panGestureRecognizer];
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
    horizontallbl.text=@"Home";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];

    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;

//    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.10, screenRect.size.width,screenRect.size.height*0.90)];
//    dashbgimageview.image=[UIImage imageNamed:@"Vangani Ele.png"];
//    dashbgimageview.clipsToBounds=YES;
//    dashbgimageview.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:dashbgimageview];
//
//    UIImageView *partiallimageview=[[UIImageView alloc]initWithFrame:dashbgimageview.frame];
//    //  partiallimageview.backgroundColor=[UIColor colorWithHexString:@"#FFA500"];
//    partiallimageview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
//    [self.view addSubview:partiallimageview];
//
//    UIButton *prospectbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.20,screenRect.size.width*0.30,screenRect.size.width*0.30)];
//    prospectbtn.layer.cornerRadius = screenRect.size.width*0.15;
//    [prospectbtn setClipsToBounds:YES];
//    prospectbtn.tag=11;
//    [prospectbtn setTitle:@"Customer\nList" forState:UIControlStateNormal];
//    prospectbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [prospectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [prospectbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    [prospectbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:prospectbtn];
//    [prospectbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//    [prospectbtn setBackgroundColor:[UIColor whiteColor]] ;
//    [prospectbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//
//    UIButton *Bacbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.45,screenRect.size.width*0.30,screenRect.size.width*0.30)];
//    Bacbtn.layer.cornerRadius = screenRect.size.width*0.15;
//    [Bacbtn setTitle:@"Todays\nFollowup" forState:UIControlStateNormal];
//    Bacbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [Bacbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [Bacbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    [Bacbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:Bacbtn];
//    Bacbtn.tag=12;
//    [Bacbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//    [Bacbtn setBackgroundColor:[UIColor whiteColor]] ;
//    [Bacbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//
//    UIButton *todaysbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.70,screenRect.size.width*0.30,screenRect.size.width*0.30)];
//    todaysbtn.layer.cornerRadius = screenRect.size.width*0.15;
//    [todaysbtn setTitle:@"Missed\nFollowup" forState:UIControlStateNormal];
//    todaysbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [todaysbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [todaysbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    [todaysbtn addTarget:self action:@selector(prospect:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:todaysbtn];
//    todaysbtn.tag=13;
//    [todaysbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
//    [todaysbtn setBackgroundColor:[UIColor whiteColor]] ;
//    [todaysbtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

}
-(void)viewWillAppear:(BOOL)animated
{
    [indicator startAnimating];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_name"] forKey:@"username"];
    [params setObject:@"getBookings"  forKey:@"requestType"];
    // NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getcustomerlist.php?";
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getcollection1.php?",[prefs objectForKey:@"Link"]];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dataarr=[[NSMutableArray alloc]init];
   NSMutableDictionary*     userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        dataarr=[[userDict objectForKey:@"Android"]objectForKey:@"bookings"];
        filteredarr=[[NSMutableArray alloc]init];
        NSMutableArray *copy=[dataarr mutableCopy];
        for (int i=dataarr.count-1; i>=0;i--) {
            if ([[[dataarr objectAtIndex:i]objectForKey:@"group_name"]isEqualToString:[[dataarr objectAtIndex:i]objectForKey:@"status1"]]) {
                [filteredarr addObject:[dataarr objectAtIndex:i]];
                [copy removeObjectAtIndex:i];
            }
        }
        [filteredarr addObjectsFromArray:copy];
        [indicator stopAnimating];
        
        [self createview];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [indicator stopAnimating];

    }];
}
-(void)createview
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [scrollview removeFromSuperview];
    scrollview = [[UIScrollView alloc] init];
    [scrollview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10, screenRect.size.width,screenRect.size.height*0.9)];
    scrollview.backgroundColor=[UIColor colorWithHexString:@""];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    int hig=screenRect.size.height*0.0;
    UIFont *text2Font2 = [UIFont systemFontOfSize:10];
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,hig,screenRect.size.width*1.0,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
        Srnolbl.font=text2Font2;
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text = @"Type of case";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:.50f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        namelbl.font=text2Font2;
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = @"Total\ncases";
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [[namelbl layer] setBorderWidth:.50f];
        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.48,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        datelbl.font=text2Font2;
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = @"less than\n30 days";
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[datelbl layer] setBorderWidth:.50f];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.61,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        cashlbl.font=text2Font2;
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text = @"30-60\n days";
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl layer] setBorderWidth:.50f];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  cashlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.74,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        cashlbl2.font=text2Font2;
        cashlbl2.textAlignment = NSTextAlignmentCenter;
        cashlbl2.text = @"60-90\n days";
        cashlbl2.backgroundColor = [UIColor clearColor];
        cashlbl2.textColor=[UIColor blackColor];
        cashlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl2 layer] setBorderWidth:.50f];
        cashlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl2.numberOfLines = 0;
        [headerView addSubview:cashlbl2];
        
        UILabel*  cashlbl3 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.87,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        cashlbl3.font=text2Font2;
        cashlbl3.textAlignment = NSTextAlignmentCenter;
        cashlbl3.text = @"more than\n90 days";
        cashlbl3.backgroundColor = [UIColor clearColor];
        cashlbl3.textColor=[UIColor blackColor];
        cashlbl3.lineBreakMode = NSLineBreakByWordWrapping;
        [[cashlbl3 layer] setBorderWidth:.50f];
        cashlbl3.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl3.numberOfLines = 0;
        [headerView addSubview:cashlbl3];
        [scrollview addSubview:headerView];
    }
    text2Font2 = [UIFont systemFontOfSize:10];
    hig=hig+screenRect.size.height*0.07;
    for (int i=0; i<dataarr.count; i++) {
        NSDictionary* dict=[dataarr objectAtIndex:i];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,hig,screenRect.size.width*1.0,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerView addSubview:lineView];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
        Srnolbl.font=text2Font2;
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text =[dict objectForKey:@"status1"];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [[Srnolbl layer] setBorderWidth:.50f];
        [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:Srnolbl];
        
        int j=100*i+100;
        UIButton*  namelbl = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        [namelbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        namelbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [namelbl addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        namelbl.tag=j+1;
        [namelbl.titleLabel setFont:text2Font2];
        [[namelbl layer] setBorderWidth:.50f];
        [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:namelbl];

        UIButton*  datelbl = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.48,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        [datelbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        datelbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [datelbl addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [datelbl.titleLabel setFont:text2Font2];
        datelbl.tag=j+2;
        [[datelbl layer] setBorderWidth:.50f];
        [[datelbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:datelbl];
        
        UIButton*  cashlbl = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.61,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        [cashlbl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cashlbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [cashlbl addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [cashlbl.titleLabel setFont:text2Font2];
        [[cashlbl layer] setBorderWidth:.50f];
        cashlbl.tag=j+3;
        [[cashlbl layer] setBorderColor:[UIColor grayColor].CGColor];
        [[cashlbl layer] setBorderWidth:.50f];
        [headerView addSubview:cashlbl];
        
        UIButton*  cashlbl2 = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.74,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        [cashlbl2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cashlbl2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [cashlbl2 addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [cashlbl2.titleLabel setFont:text2Font2];
        [[cashlbl2 layer] setBorderWidth:.50f];
        cashlbl2.tag=j+4;
        [[cashlbl2 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:cashlbl2];
        
        UIButton*  cashlbl3 = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.87,0,screenRect.size.width*0.13,screenRect.size.height*0.07)];
        [cashlbl3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cashlbl3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [cashlbl3 addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [cashlbl3.titleLabel setFont:text2Font2];
        [[cashlbl3 layer] setBorderWidth:.50f];
        cashlbl3.tag=j+5;
        [[cashlbl3 layer] setBorderColor:[UIColor grayColor].CGColor];
        [headerView addSubview:cashlbl3];
        [scrollview addSubview:headerView];
        
        if ([[dict objectForKey:@"group_name"]isEqualToString:[dict objectForKey:@"status1"]])
        {   Srnolbl.font=[UIFont boldSystemFontOfSize:10];
            
            [namelbl.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [datelbl.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [cashlbl.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [cashlbl2.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [cashlbl3.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
        
        }
        [namelbl setTitle:[dict objectForKey:@"total_cases"] forState:UIControlStateNormal];
        [datelbl setTitle:[dict objectForKey:@"lt30"] forState:UIControlStateNormal];
        [cashlbl setTitle:[dict objectForKey:@"b3060"] forState:UIControlStateNormal];
        [cashlbl2 setTitle:[dict objectForKey:@"b6090"] forState:UIControlStateNormal];
        [cashlbl3 setTitle:[dict objectForKey:@"gt90"] forState:UIControlStateNormal];
        hig=hig+screenRect.size.height*0.07;
    }
    
    hig=hig+screenRect.size.height*0.10;
    scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
}

-(void)upload:(UIButton*)btn
{
    int row=btn.tag/100-1;
    NSLog(@"row= %ld",(long)btn.tag/100);
    NSLog(@"column= %ld",(long)btn.tag%100);
    NewCasesvViewController *mainvc=[[NewCasesvViewController alloc] initWithNibName:@"NewCasesvViewController" bundle:nil];
    mainvc.str=@"Customer List";
    mainvc.groupstr=[[dataarr objectAtIndex:row]objectForKey:@"group_name"];
    mainvc.statusstr=[[dataarr objectAtIndex:row]objectForKey:@"status1"];
    mainvc.groupstr=[[dataarr objectAtIndex:row]objectForKey:@"group_name"];
    mainvc.rowstr=btn.titleLabel.text;
    mainvc.columnstr=[NSString stringWithFormat:@"%ld",btn.tag%100]
    ;
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)prospect:(UIButton *)btn
{
        NewCasesvViewController *mainvc=[[NewCasesvViewController alloc] initWithNibName:@"NewCasesvViewController" bundle:nil];
        mainvc.str=btn.titleLabel.text;
        [self.navigationController pushViewController:mainvc animated:YES];
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
