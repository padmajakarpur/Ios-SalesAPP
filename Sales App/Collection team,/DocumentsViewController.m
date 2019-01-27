//
//  DocumentsViewController.m
//  Sales App
//
//  Created by Infinitum on 25/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "DocumentsViewController.h"
#import "DocumentsViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "RemarkViewController.h"
@interface DocumentsViewController ()

@end
@implementation DocumentsViewController
@synthesize teamtableview,loginnumbertxt,bankloantxt,executivedraftxt,remark1txt,remark2txt,statustxt,dashbgimageview,fudatetxt,sactiondatetxt,sactionamtxt,expiraydatext,loanamttxt,historytextvie,teamarr,indicator,comstr,downPicker,datePicker,numberToolbarzip,sanctiondatestr,expdatestr,fudatestr,groupstr,statusarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _userinfodict=[[NSMutableDictionary alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    statusarr=[[NSMutableArray alloc]init];
    fudatestr=@"";
    sanctiondatestr=@"";
    expdatestr=@"";
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#ED2026"];

    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Collection Team";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
   // [self.view addSubview:backgroundview];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];

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
    
    if (_userinfodict.count<1) {
        teamarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:comstr  forKey:@"reqid"];
        
      //  NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getdetails.php?";
           NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getdetails.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", dict);
            if (dict.count>0) {
                _userinfodict=[[[dict objectForKey:@"ProjectDetails"]objectForKey:@"OT_BL"]objectAtIndex:0];
                if ([[_userinfodict objectForKey:@"ID"] isEqual:[NSNull null]]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Somthing went wrong at server side."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else
                {
                [self createview:_userinfodict];
                teamarr=[[dict objectForKey:@"ProjectDetails"]objectForKey:@"OT_LINE"];
                [self getstatus:[_userinfodict objectForKey:@"GROUP_NAME"]];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    }

-(void)getstatus:(NSString *)str
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:str forKey:@"group_name"];
    [params setObject:@"getBookings"  forKey:@"requestType"];

    //  NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getdetails.php?";
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getstatusdrop.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSMutableDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", dict);
        NSMutableArray *dataarr=[[dict objectForKey:@"Android"]objectForKey:@"bookings"];
        
        if (dataarr.count>0) {
            for (int i=0; i<dataarr.count; i++) {
                [statusarr addObject:[[dataarr objectAtIndex:i]objectForKey:@"status"]];
            }
        }
        else
        {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
            [self.downPicker setData:statusarr];
        }
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)createview:(NSMutableDictionary*)dict
{
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:20];
    UIFont *opensans = [UIFont fontWithName:@"OpenSans-Light" size:10];
    UIFont *text2Font2 = [UIFont systemFontOfSize:10];
    
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        teamtableview = [[UIScrollView alloc] init];
        [teamtableview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10, screenRect.size.width,screenRect.size.height*0.90)];
        teamtableview.bounces = NO;
        teamtableview.backgroundColor=[UIColor clearColor];
        teamtableview.delegate = self;
        [self.view addSubview:teamtableview];
        int hig=screenRect.size.height*0.02;
        
        //first view
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,hig,screenRect.size.width*0.96,screenRect.size.height*0.24)];
            headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
            [teamtableview addSubview:headerView];
            headerView.layer.borderWidth = 0.5f;
            headerView.layer.borderColor = [UIColor grayColor].CGColor;
            headerView.layer.cornerRadius=5.0f;
            
            UILabel* requesidlbl = [[UILabel alloc] init];
            [requesidlbl setFrame:CGRectMake(screenRect.size.width*.04,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
            requesidlbl.textAlignment = NSTextAlignmentLeft;
            requesidlbl.backgroundColor=[UIColor clearColor];
            [requesidlbl setTextColor: [UIColor blackColor]];
            [teamtableview addSubview:requesidlbl];
            NSString* positionstr5=@"Req.ID: ";
            NSString* positionstr6=[dict objectForKey:@"ID"];
            NSMutableAttributedString *attributedString5 =
            [[NSMutableAttributedString alloc] initWithString:positionstr5 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
            NSMutableAttributedString *attributedString6 =
            [[NSMutableAttributedString alloc] initWithString:positionstr6 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
            [attributedString5 appendAttributedString:attributedString6];
            requesidlbl.attributedText = attributedString5;
            
            UILabel* agrlbl = [[UILabel alloc] init];
            [agrlbl setFrame:CGRectMake(screenRect.size.width*.52,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
            agrlbl.textAlignment = NSTextAlignmentLeft;
            agrlbl.backgroundColor=[UIColor clearColor];
            [agrlbl setTextColor: [UIColor blackColor]];
            [teamtableview addSubview:agrlbl];
            NSString* positionstr3=@"Avg value: ";
            NSString* positionstr4=[dict objectForKey:@"AGVALUE"];
            NSMutableAttributedString *attributedString3 =
            [[NSMutableAttributedString alloc] initWithString:positionstr3 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
            NSMutableAttributedString *attributedString4=
            [[NSMutableAttributedString alloc] initWithString:positionstr4 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
            [attributedString3 appendAttributedString:attributedString4];
            agrlbl.attributedText = attributedString3;
            
            hig=hig+ screenRect.size.height*0.04;
            {
                UILabel* assignlbl = [[UILabel alloc] init];
                [assignlbl setFrame:CGRectMake(screenRect.size.width*.04,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                assignlbl.textAlignment = NSTextAlignmentLeft;
                assignlbl.backgroundColor=[UIColor clearColor];
                [assignlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:assignlbl];
                NSString* positionstr1=@"Asg date: ";
                NSString* positionstr2=[self formatdate:[dict objectForKey:@"ASSIGNED_DATE"]];
                NSMutableAttributedString *attributedString1 =
                [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString2 =
                [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString1 appendAttributedString:attributedString2];
                assignlbl.attributedText = attributedString1;
                
                UILabel* taaxlbl = [[UILabel alloc] init];
                [taaxlbl setFrame:CGRectMake(screenRect.size.width*.52,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                taaxlbl.textAlignment = NSTextAlignmentLeft;
                taaxlbl.backgroundColor=[UIColor clearColor];
                [taaxlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:taaxlbl];
                NSString* positionstr7=@"Tax: ";
                NSString* positionstr8=[dict objectForKey:@"TAXES"];
                NSMutableAttributedString *attributedString7 =
                [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString8=
                [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString7 appendAttributedString:attributedString8];
                taaxlbl.attributedText = attributedString7;
            }
            
            hig=hig+ screenRect.size.height*0.04;
            {
                UILabel* assignlbl = [[UILabel alloc] init];
                [assignlbl setFrame:CGRectMake(screenRect.size.width*.04,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                assignlbl.textAlignment = NSTextAlignmentLeft;
                assignlbl.backgroundColor=[UIColor clearColor];
                [assignlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:assignlbl];
                NSString* positionstr1=@"Book no:";
                NSString* positionstr2=[dict objectForKey:@"BKNUM"];
                NSMutableAttributedString *attributedString1 =
                [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString2 =
                [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString1 appendAttributedString:attributedString2];
                assignlbl.attributedText = attributedString1;
                
                UILabel* taaxlbl = [[UILabel alloc] init];
                [taaxlbl setFrame:CGRectMake(screenRect.size.width*.52,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                taaxlbl.textAlignment = NSTextAlignmentLeft;
                taaxlbl.backgroundColor=[UIColor clearColor];
                [taaxlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:taaxlbl];
                NSString* positionstr7=@"SD and reg cost: ";
                NSString* positionstr8=[dict objectForKey:@"SDR"];
                NSMutableAttributedString *attributedString7 =
                [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString8=
                [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString7 appendAttributedString:attributedString8];
                taaxlbl.attributedText = attributedString7;
            }
            
            hig=hig+ screenRect.size.height*0.04;
            {
                UILabel* assignlbl = [[UILabel alloc] init];
                [assignlbl setFrame:CGRectMake(screenRect.size.width*.04,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                assignlbl.textAlignment = NSTextAlignmentLeft;
                assignlbl.backgroundColor=[UIColor clearColor];
                [assignlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:assignlbl];
                NSString* positionstr1=@"Proj name:";
                NSString* positionstr2=[dict objectForKey:@"PROJ_NAME"];
                NSMutableAttributedString *attributedString1 =
                [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString2 =
                [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString1 appendAttributedString:attributedString2];
                assignlbl.attributedText = attributedString1;
                
                UILabel* taaxlbl = [[UILabel alloc] init];
                [taaxlbl setFrame:CGRectMake(screenRect.size.width*.52,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                taaxlbl.textAlignment = NSTextAlignmentLeft;
                taaxlbl.backgroundColor=[UIColor clearColor];
                [taaxlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:taaxlbl];
                NSString* positionstr7=@"Toatal cost: ";
                NSString* positionstr8=[dict objectForKey:@"TCOST"];
                NSMutableAttributedString *attributedString7 =
                [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString8=
                [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString7 appendAttributedString:attributedString8];
                taaxlbl.attributedText = attributedString7;
            }
            hig=hig+ screenRect.size.height*0.04;
            {
                UILabel* assignlbl = [[UILabel alloc] init];
                [assignlbl setFrame:CGRectMake(screenRect.size.width*.04,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                assignlbl.textAlignment = NSTextAlignmentLeft;
                assignlbl.backgroundColor=[UIColor clearColor];
                [assignlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:assignlbl];
                NSString* positionstr1=@"Unit no:";
                NSString* positionstr2=[dict objectForKey:@"UNIT_NO"];
                NSMutableAttributedString *attributedString1 =
                [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString2 =
                [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString1 appendAttributedString:attributedString2];
                assignlbl.attributedText = attributedString1;
                
                UILabel* taaxlbl = [[UILabel alloc] init];
                [taaxlbl setFrame:CGRectMake(screenRect.size.width*.52,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                taaxlbl.textAlignment = NSTextAlignmentLeft;
                taaxlbl.backgroundColor=[UIColor clearColor];
                [taaxlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:taaxlbl];
                NSString* positionstr7=@"Cleard amt: ";
                NSString* positionstr8=[dict objectForKey:@"CLR_ALL"];
                NSMutableAttributedString *attributedString7 =
                [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString8=
                [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString7 appendAttributedString:attributedString8];
                taaxlbl.attributedText = attributedString7;
            }
            hig=hig+ screenRect.size.height*0.04;
            {
                UILabel* assignlbl = [[UILabel alloc] init];
                [assignlbl setFrame:CGRectMake(screenRect.size.width*.04,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                assignlbl.textAlignment = NSTextAlignmentLeft;
                assignlbl.backgroundColor=[UIColor clearColor];
                [assignlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:assignlbl];
                NSString* positionstr1=@"Scheme:";
                NSString* positionstr2=[dict objectForKey:@"SCHEME"];
                NSMutableAttributedString *attributedString1 =
                [[NSMutableAttributedString alloc] initWithString:positionstr1 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString2 =
                [[NSMutableAttributedString alloc] initWithString:positionstr2 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString1 appendAttributedString:attributedString2];
                assignlbl.attributedText = attributedString1;
                
                UILabel* taaxlbl = [[UILabel alloc] init];
                [taaxlbl setFrame:CGRectMake(screenRect.size.width*.52,hig, screenRect.size.width*0.45,screenRect.size.height*0.04)];
                taaxlbl.textAlignment = NSTextAlignmentLeft;
                taaxlbl.backgroundColor=[UIColor clearColor];
                [taaxlbl setTextColor: [UIColor blackColor]];
                [teamtableview addSubview:taaxlbl];
                NSString* positionstr7=@"Req. loan amt: ";
                NSString* positionstr8=[dict objectForKey:@"LOAN_REQUIRED"];
                NSMutableAttributedString *attributedString7 =
                [[NSMutableAttributedString alloc] initWithString:positionstr7 attributes:@{NSFontAttributeName : text2Font2,NSForegroundColorAttributeName:[UIColor blackColor]}];
                NSMutableAttributedString *attributedString8=
                [[NSMutableAttributedString alloc] initWithString:positionstr8 attributes:@{NSFontAttributeName :opensans ,NSForegroundColorAttributeName:[UIColor blackColor]}];
                [attributedString7 appendAttributedString:attributedString8];
                taaxlbl.attributedText = attributedString7;
                
            }
         
        }
        hig=hig+screenRect.size.height*0.08;
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
            Srnolbl.text = @"List of Documents";
            Srnolbl.backgroundColor = [UIColor clearColor];
            Srnolbl.textColor=[UIColor blackColor];
            Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
            Srnolbl.numberOfLines = 0;
            [[Srnolbl layer] setBorderWidth:.50f];
            [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
            [headerView addSubview:Srnolbl];
            
            UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.21,screenRect.size.height*0.07)];
            namelbl.font=text2Font2;
            namelbl.textAlignment = NSTextAlignmentCenter;
            namelbl.text = @"Applicant";
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor=[UIColor blackColor];
            namelbl.lineBreakMode = NSLineBreakByWordWrapping;
            namelbl.numberOfLines = 0;
            [[namelbl layer] setBorderWidth:.50f];
            [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
            [headerView addSubview:namelbl];
            
            UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.56,0,screenRect.size.width*0.21,screenRect.size.height*0.07)];
            datelbl.font=text2Font2;
            datelbl.textAlignment = NSTextAlignmentCenter;
            datelbl.text = @"Co-applicatant1";
            datelbl.backgroundColor = [UIColor clearColor];
            datelbl.textColor=[UIColor blackColor];
            datelbl.lineBreakMode = NSLineBreakByWordWrapping;
            [[datelbl layer] setBorderWidth:.50f];
            datelbl.lineBreakMode = NSLineBreakByWordWrapping;
            datelbl.numberOfLines = 0;
            [headerView addSubview:datelbl];
            
            UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.77,0,screenRect.size.width*0.23,screenRect.size.height*0.07)];
            cashlbl.font=text2Font2;
            cashlbl.textAlignment = NSTextAlignmentCenter;
            cashlbl.text = @"Co-applicatant2";
            cashlbl.backgroundColor = [UIColor clearColor];
            cashlbl.textColor=[UIColor blackColor];
            cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
            [[cashlbl layer] setBorderWidth:.50f];
            cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
            cashlbl.numberOfLines = 0;
            [headerView addSubview:cashlbl];
            [teamtableview addSubview:headerView];
        }
        hig=hig+screenRect.size.height*0.07;
        for (int i=0; i<3; i++) {
            //   NSMutableDictionary *dict=[_teamarr objectAtIndex:i];

            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width*1,screenRect.size.height*0.07)];
            headerView.backgroundColor=[UIColor whiteColor];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, headerView.frame.size.width, 2.0f)];
            lineView.backgroundColor = [UIColor clearColor];
            [headerView addSubview:lineView];
            
            //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
            //    lineView2.backgroundColor = [UIColor grayColor];
            //    [headerView addSubview:lineView2];
            
            if (i<3) {
                UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
                Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                Srnolbl.textAlignment = NSTextAlignmentCenter;
             
                Srnolbl.backgroundColor = [UIColor clearColor];
                Srnolbl.textColor=[UIColor blackColor];
                Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
                Srnolbl.numberOfLines = 0;
                [[Srnolbl layer] setBorderWidth:.50f];
                [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
                [headerView addSubview:Srnolbl];
                
                UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,0,screenRect.size.width*0.21,screenRect.size.height*0.07)];
                namelbl.font=opensans;
                namelbl.textAlignment = NSTextAlignmentCenter;
              
                namelbl.backgroundColor = [UIColor clearColor];
                namelbl.textColor=[UIColor blackColor];
                namelbl.lineBreakMode = NSLineBreakByWordWrapping;
                namelbl.numberOfLines = 0;
                [[namelbl layer] setBorderWidth:.50f];
                [[namelbl layer] setBorderColor:[UIColor grayColor].CGColor];
                [headerView addSubview:namelbl];
                
                UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.56,0,screenRect.size.width*0.21,screenRect.size.height*0.07)];
                datelbl.font=opensans;
                datelbl.textAlignment = NSTextAlignmentCenter;
              
                datelbl.backgroundColor = [UIColor clearColor];
                datelbl.textColor=[UIColor blackColor];
                datelbl.lineBreakMode = NSLineBreakByWordWrapping;
                [[datelbl layer] setBorderWidth:.50f];
                datelbl.lineBreakMode = NSLineBreakByWordWrapping;
                datelbl.numberOfLines = 0;
                [headerView addSubview:datelbl];
                
                UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.77,0,screenRect.size.width*0.23,screenRect.size.height*0.07)];
                cashlbl.font=opensans;
                cashlbl.textAlignment = NSTextAlignmentCenter;
              
                cashlbl.backgroundColor = [UIColor clearColor];
                cashlbl.textColor=[UIColor blackColor];
                cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
                [[cashlbl layer] setBorderWidth:.50f];
                cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
                cashlbl.numberOfLines = 0;
                [headerView addSubview:cashlbl];
                
                if (i==0) {
                    Srnolbl.text = @"Name";
                    namelbl.text = [dict objectForKey:@"APP_NAME"];
                    datelbl.text = [dict objectForKey:@"COAPP1_NAME"];
                    cashlbl.text=[dict objectForKey:@"COAPP2_NAME"];
                }
                if (i==1) {
                    Srnolbl.text = @"Occupation";
                    namelbl.text = [dict objectForKey:@"APP_OCCUPATION"];
                    datelbl.text = [dict objectForKey:@"COAPP1_OCCUPATION"];
                    cashlbl.text=[dict objectForKey:@"COAPP2_OCCUPATION"];
                }
                if (i==2) {
                    Srnolbl.text = @"Customer Type";
                    namelbl.text = [dict objectForKey:@"APP_DOC_TYPE"];
                    datelbl.text = [dict objectForKey:@"COAPP1_DOC_TYPE"];
                    cashlbl.text=[dict objectForKey:@"COAPP2_DOC_TYPE"];
                }
            }
            else
            {
                
                //            int tag=100;
                //                UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.35,screenRect.size.height*0.07)];
                //                Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                //                Srnolbl.textAlignment = NSTextAlignmentCenter;
                //                Srnolbl.text = @"ADHAAR Card";
                //                Srnolbl.backgroundColor = [UIColor clearColor];
                //                Srnolbl.textColor=[UIColor blackColor];
                //                Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
                //                Srnolbl.numberOfLines = 0;
                //                [[Srnolbl layer] setBorderWidth:1.0f];
                //                [[Srnolbl layer] setBorderColor:[UIColor grayColor].CGColor];
                //                [headerView addSubview:Srnolbl];
                //
                //           UIButton* _checkboxbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.42,screenRect.size.height*0.01,screenRect.size.width*.21,screenRect.size.height*.05)];
                //            [_checkboxbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
                //            [_checkboxbtn setTitle:@"\uE835" forState:UIControlStateNormal];
                //            [_checkboxbtn setTitle:@"\uE834" forState:UIControlStateSelected];
                //            [_checkboxbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //            [_checkboxbtn.titleLabel setFont:customFontdregs];
                //            [headerView addSubview:_checkboxbtn];
                //            _checkboxbtn.tag=tag*i+1;
                //            NSLog(@"%ld",(long)_checkboxbtn.tag);
                //
                //            UIButton* _checkboxbtn1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.72,screenRect.size.height*0.01,screenRect.size.width*.15,screenRect.size.height*.05)];
                //            [_checkboxbtn1 addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
                //            [_checkboxbtn1 setTitle:@"\uE835" forState:UIControlStateNormal];
                //            [_checkboxbtn1 setTitle:@"\uE834" forState:UIControlStateSelected];
                //            [_checkboxbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //            [_checkboxbtn1.titleLabel setFont:customFontdregs];
                //            [headerView addSubview:_checkboxbtn1];
                //            _checkboxbtn1.tag=tag*i+2;
                //            NSLog(@"%ld",(long)_checkboxbtn1.tag);
                //
                //            UIButton* _checkboxbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*1.02,screenRect.size.height*0.01,screenRect.size.width*.15,screenRect.size.height*.05)];
                //            [_checkboxbtn2 addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
                //            [_checkboxbtn2 setTitle:@"\uE835" forState:UIControlStateNormal];
                //            [_checkboxbtn2 setTitle:@"\uE834" forState:UIControlStateSelected];
                //            [_checkboxbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //            [_checkboxbtn2.titleLabel setFont:customFontdregs];
                //            [headerView addSubview:_checkboxbtn2];
                //            _checkboxbtn2.tag=tag*i+3;
                //            NSLog(@"%ld",(long)_checkboxbtn2.tag);
            }
            [teamtableview addSubview:headerView];
            hig=hig+screenRect.size.height*0.07;
        }
        hig=hig+screenRect.size.height*0.04;
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,hig,screenRect.size.width*0.96,screenRect.size.height*0.43)];
            headerView.backgroundColor=[UIColor colorWithHexString:@"#E8E8E8"];
            [teamtableview addSubview:headerView];
            headerView.layer.borderWidth = 0.5f;
            headerView.layer.borderColor = [UIColor grayColor].CGColor;
            headerView.layer.cornerRadius=5.0f;
            
            UILabel *remarklbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,0,screenRect.size.width*.39,screenRect.size.height*0.04)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            remarklbl1.font=text2Font2;
            remarklbl1.text=@"Status";
            [remarklbl1 setTextColor:[UIColor blackColor]];
            remarklbl1.textAlignment = NSTextAlignmentLeft;
            remarklbl1.lineBreakMode = NSLineBreakByWordWrapping;
            remarklbl1.numberOfLines = 0;
            [headerView addSubview:remarklbl1];

            statustxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            statustxt.textAlignment=NSTextAlignmentLeft;
            statustxt.delegate = self;
            statustxt.textColor=[UIColor blackColor];
            [statustxt setBackgroundColor:[UIColor clearColor]];
            statustxt.leftViewMode = UITextFieldViewModeAlways;
            [statustxt setKeyboardType:UIKeyboardTypeEmailAddress];
            statustxt.returnKeyType=UIReturnKeyDone;
           
            downPicker = [[DownPicker alloc] initWithTextField:statustxt withData:statusarr];
            [downPicker setPlaceholderWhileSelecting:@"Status"];
            [downPicker showArrowImage:YES];
            [headerView addSubview:statustxt];
            CALayer *bottomBorders1 = [CALayer layer];
            bottomBorders1.frame = CGRectMake(0.0f, statustxt.frame.size.height - 5, statustxt.frame.size.width, 1.0f);
            bottomBorders1.backgroundColor = [UIColor blackColor].CGColor;
            [statustxt.layer addSublayer:bottomBorders1];
            statustxt.text=[dict objectForKey:@"STATUS1"];
            statustxt.font = [UIFont systemFontOfSize:12];
            
            UILabel *followlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.55,0,screenRect.size.width*.39,screenRect.size.height*0.04)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            followlbl.font=text2Font2;
            followlbl.text=@"Followup date";
            [followlbl setTextColor:[UIColor blackColor]];
            followlbl.textAlignment = NSTextAlignmentLeft;
            followlbl.lineBreakMode = NSLineBreakByWordWrapping;
            followlbl.numberOfLines = 0;
            [headerView addSubview:followlbl];

            fudatetxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.04,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            fudatetxt.textAlignment=NSTextAlignmentLeft;
            fudatetxt.delegate = self;
            fudatetxt.textColor=[UIColor blackColor];
            [fudatetxt setBackgroundColor:[UIColor clearColor]];
            fudatetxt.leftViewMode = UITextFieldViewModeAlways;
            [fudatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
            fudatetxt.returnKeyType=UIReturnKeyDone;
            fudatetxt.font = [UIFont systemFontOfSize:14];
            [headerView addSubview:fudatetxt];
            datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
            [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],  [[UIBarButtonItem alloc]initWithTitle:@"Done"
style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
            [numberToolbarzip sizeToFit];
            fudatetxt.inputView =datePicker;
  fudatetxt.inputAccessoryView = numberToolbarzip;
            CALayer *bottomBorders2 = [CALayer layer];
            bottomBorders2.frame = CGRectMake(0.0f, fudatetxt.frame.size.height - 5, fudatetxt.frame.size.width, 1.0f);
            bottomBorders2.backgroundColor = [UIColor blackColor].CGColor;
            [fudatetxt.layer addSublayer:bottomBorders2];
            
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
            if (![[dict objectForKey:@"FU_DATE"] isEqualToString:@"00000000"]) {
                [dateFormatter setDateFormat:@"yyyyMMdd"];
                NSDate *dateFromString = [dateFormatter dateFromString:[dict objectForKey:@"FU_DATE"]];
                [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
                fudatetxt.text=stringDate;
                fudatestr=[dict objectForKey:@"FU_DATE"];
            }
            UILabel *Sactionlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,screenRect.size.height*0.11,screenRect.size.width*.39,screenRect.size.height*0.04)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            Sactionlbl.font=text2Font2;
            Sactionlbl.text=@"Sanction amount";
            [Sactionlbl setTextColor:[UIColor blackColor]];
            Sactionlbl.textAlignment = NSTextAlignmentLeft;
            Sactionlbl.lineBreakMode = NSLineBreakByWordWrapping;
            Sactionlbl.numberOfLines = 0;
            [headerView addSubview:Sactionlbl];

        sactionamtxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.15,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            sactionamtxt.textAlignment=NSTextAlignmentRight;
            sactionamtxt.delegate = self;
            sactionamtxt.textColor=[UIColor blackColor];
            [sactionamtxt setKeyboardType:UIKeyboardTypeEmailAddress];
            sactionamtxt.returnKeyType=UIReturnKeyDone;
            sactionamtxt.font = [UIFont systemFontOfSize:14];
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
//            sactionamtxt.leftView = paddingView;
//            sactionamtxt.leftViewMode = UITextFieldViewModeAlways;
            sactionamtxt.rightView = paddingView;
            sactionamtxt.rightViewMode = UITextFieldViewModeAlways;
            CALayer *bottomBorders3 = [CALayer layer];
            bottomBorders3.frame = CGRectMake(0.0f, sactionamtxt.frame.size.height - 5, sactionamtxt.frame.size.width, 1.0f);
            bottomBorders3.backgroundColor = [UIColor blackColor].CGColor;
            [sactionamtxt.layer addSublayer:bottomBorders3];
            [headerView addSubview:sactionamtxt];
            sactionamtxt.text=[dict objectForKey:@"SANCTION_AMOUNT"];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                       [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbarzip sizeToFit];
            sactionamtxt.inputAccessoryView = numberToolbarzip;
            sactionamtxt.leftViewMode = UITextFieldViewModeAlways;
            sactionamtxt.keyboardType = UIKeyboardTypeDecimalPad;
          
            UILabel *danctiondatelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.55,screenRect.size.height*0.11,screenRect.size.width*.39,screenRect.size.height*0.04)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            danctiondatelbl.font=text2Font2;
            danctiondatelbl.text=@"Sanction date";
            [danctiondatelbl setTextColor:[UIColor blackColor]];
            danctiondatelbl.textAlignment = NSTextAlignmentLeft;
            danctiondatelbl.lineBreakMode = NSLineBreakByWordWrapping;
            danctiondatelbl.numberOfLines = 0;
            [headerView addSubview:danctiondatelbl];
            
            sactiondatetxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.15,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            sactiondatetxt.textAlignment=NSTextAlignmentLeft;
            sactiondatetxt.delegate = self;
            sactiondatetxt.textColor=[UIColor blackColor];
            [sactiondatetxt setBackgroundColor:[UIColor clearColor]];
            sactiondatetxt.leftViewMode = UITextFieldViewModeAlways;
            [sactiondatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
            sactiondatetxt.returnKeyType=UIReturnKeyDone;
            sactiondatetxt.font = [UIFont systemFontOfSize:14];
            [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],  [[UIBarButtonItem alloc]initWithTitle:@"Done"
style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad1:)]];
            [numberToolbarzip sizeToFit];
            sactiondatetxt.inputView =datePicker;
            sactiondatetxt.inputAccessoryView = numberToolbarzip;
            [headerView addSubview:sactiondatetxt];
            CALayer *bottomBorders4 = [CALayer layer];
            bottomBorders4.frame = CGRectMake(0.0f, sactiondatetxt.frame.size.height - 5, sactiondatetxt.frame.size.width, 1.0f);
            bottomBorders4.backgroundColor = [UIColor blackColor].CGColor;
            [sactiondatetxt.layer addSublayer:bottomBorders4];
            [headerView addSubview:sactiondatetxt];
            if (![[dict objectForKey:@"SANCTION_DATE"] isEqualToString:@"00000000"]) {
                [dateFormatter setDateFormat:@"yyyyMMdd"];
                NSDate *dateFromString = [dateFormatter dateFromString:[dict objectForKey:@"SANCTION_DATE"]];
                [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
                sactiondatetxt.text=stringDate;
                sanctiondatestr=[dict objectForKey:@"SANCTION_DATE"];
            }
            UILabel *expirydatlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,screenRect.size.height*0.22,screenRect.size.width*.39,screenRect.size.height*0.04)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            expirydatlbl.font=text2Font2;
            expirydatlbl.text=@"Expiry date";
            [expirydatlbl setTextColor:[UIColor blackColor]];
            expirydatlbl.textAlignment = NSTextAlignmentLeft;
            expirydatlbl.lineBreakMode = NSLineBreakByWordWrapping;
            expirydatlbl.numberOfLines = 0;
            [headerView addSubview:expirydatlbl];

            expiraydatext = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.26,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            expiraydatext.textAlignment=NSTextAlignmentLeft;
       //     expiraydatext.delegate = self;
            expiraydatext.textColor=[UIColor blackColor];
            [expiraydatext setBackgroundColor:[UIColor clearColor]];
            expiraydatext.leftViewMode = UITextFieldViewModeAlways;
            [expiraydatext setKeyboardType:UIKeyboardTypeEmailAddress];
            expiraydatext.returnKeyType=UIReturnKeyDone;
            expiraydatext.font = [UIFont systemFontOfSize:14];
            [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],  [[UIBarButtonItem alloc]initWithTitle:@"Done"
style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad2:)]];
            [numberToolbarzip sizeToFit];
            expiraydatext.inputView =datePicker;
            expiraydatext.inputAccessoryView = numberToolbarzip;
            [headerView addSubview:expiraydatext];
            CALayer *bottomBorders5 = [CALayer layer];
            bottomBorders5.frame = CGRectMake(0.0f, expiraydatext.frame.size.height - 5, expiraydatext.frame.size.width, 1.0f);
            bottomBorders5.backgroundColor = [UIColor blackColor].CGColor;
            [expiraydatext.layer addSublayer:bottomBorders5];
            [headerView addSubview:expiraydatext];
            if (![[dict objectForKey:@"EXPIRY_DATE"] isEqualToString:@"00000000"]) {
                [dateFormatter setDateFormat:@"yyyyMMdd"];
                NSDate *dateFromString = [dateFormatter dateFromString:[dict objectForKey:@"EXPIRY_DATE"]];
                [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
                expiraydatext.text=stringDate;
                expdatestr=[dict objectForKey:@"EXPIRY_DATE"];
            }
            UILabel *loanamountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.55,screenRect.size.height*0.22,screenRect.size.width*.39,screenRect.size.height*0.04)];
            //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
            loanamountlbl.font=text2Font2;
            loanamountlbl.text=@"Loan account ";
            [loanamountlbl setTextColor:[UIColor blackColor]];
            loanamountlbl.textAlignment = NSTextAlignmentLeft;
            loanamountlbl.lineBreakMode = NSLineBreakByWordWrapping;
            loanamountlbl.numberOfLines = 0;
            [headerView addSubview:loanamountlbl];
      
            loanamttxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.26,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            loanamttxt.textAlignment=NSTextAlignmentRight;
            loanamttxt.delegate = self;
            loanamttxt.textColor=[UIColor blackColor];
            [loanamttxt setBackgroundColor:[UIColor clearColor]];
            loanamttxt.leftViewMode = UITextFieldViewModeAlways;
            [loanamttxt setKeyboardType:UIKeyboardTypeEmailAddress];
            loanamttxt.returnKeyType=UIReturnKeyDone;
            loanamttxt.font = [UIFont systemFontOfSize:14];
            [headerView addSubview:loanamttxt];
            CALayer *bottomBorders6 = [CALayer layer];
            bottomBorders6.frame = CGRectMake(0.0f, loanamttxt.frame.size.height - 5, loanamttxt.frame.size.width, 1.0f);
            bottomBorders6.backgroundColor = [UIColor blackColor].CGColor;
            [loanamttxt.layer addSublayer:bottomBorders6];
            [headerView addSubview:loanamttxt];
            loanamttxt.text=[dict objectForKey:@"LOAN_ACCOUNT_NO"];
            numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                       [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
            [numberToolbarzip sizeToFit];
            loanamttxt.inputAccessoryView = numberToolbarzip;
            loanamttxt.leftViewMode = UITextFieldViewModeAlways;
            loanamttxt.keyboardType = UIKeyboardTypeDecimalPad;
            
            UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.35,screenRect.size.width*0.40,screenRect.size.height*0.05)];
            [Createvoucherbtn setClipsToBounds:YES];
            [Createvoucherbtn setTitle:@"Upload sanction letter" forState:UIControlStateNormal];
            [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
            Createvoucherbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [Createvoucherbtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
            [Createvoucherbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.035]];
            [Createvoucherbtn setBackgroundColor:[UIColor lightGrayColor]] ;
            [headerView addSubview:Createvoucherbtn];
            
            dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.62,screenRect.size.height*0.33, screenRect.size.width*0.28,screenRect.size.height*0.10)];
            dashbgimageview.clipsToBounds=YES;
            dashbgimageview.contentMode = UIViewContentModeScaleAspectFill;
            dashbgimageview.layer.borderWidth=0.05f;
            [headerView addSubview:dashbgimageview];
            [[dashbgimageview layer] setBorderColor:[UIColor grayColor].CGColor];
        }
        hig=hig+screenRect.size.height*0.46;
        {
            UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
            [Createvoucherbtn setClipsToBounds:YES];
            [Createvoucherbtn setTitle:@"View Remark" forState:UIControlStateNormal];
            [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
            Createvoucherbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [Createvoucherbtn addTarget:self action:@selector(viewremarks) forControlEvents:UIControlEventTouchUpInside];
            [Createvoucherbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
            [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#007E2F"]] ;
            [teamtableview addSubview:Createvoucherbtn];
        }
        UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,hig,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        Createvoucherbtn.layer.cornerRadius = 3.0f;
        [Createvoucherbtn setTitle:@"Submit" forState:UIControlStateNormal];
        [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [Createvoucherbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [Createvoucherbtn.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.05]];
        [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#4861AC"]] ;
        [teamtableview addSubview:Createvoucherbtn];
        
        hig=hig+screenRect.size.height*0.12;
        teamtableview.contentSize = CGSizeMake(screenRect.size.width, hig);
}
-(void)viewremarks
{
    RemarkViewController *mainvc=[[RemarkViewController alloc] initWithNibName:@"RemarkViewController" bundle:nil];
    mainvc.teamarr=teamarr;
    mainvc.comestr=comstr;
    [self.navigationController presentViewController:mainvc animated:YES completion:nil];
}
-(void)doneWithNumberPad
{
    [loanamttxt resignFirstResponder];
    [sactionamtxt resignFirstResponder];
}
-(void)submit
{
//    for (int i=0; i<24; i++) {
//        NSString *str=[[NSMutableString alloc]init];
//       int tag=100;
//        if (((UIButton*)[self.view viewWithTag:tag*i+1]).selected)
//            str=[str stringByAppendingString:@"1"];
//        else
//            str=[str stringByAppendingString:@"0"];
//
//
//        if (((UIButton*)[self.view viewWithTag:tag*i+2]).selected)
//            str=[str stringByAppendingString:@"1"];
//        else
//            str=[str stringByAppendingString:@"0"];
//
//
//        if (((UIButton*)[self.view viewWithTag:tag*i+3]).selected)
//            str=[str stringByAppendingString:@"1"];
//        else
//            str=[str stringByAppendingString:@"0"];
//
//        NSLog(@"%@",str);
//    }
   
    CGRect screenRect = [[UIScreen mainScreen] bounds];
 UIActivityIndicatorView*   indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
    
    NSString*  progfilebytestr;
    if (dashbgimageview.image!=nil) {
     NSData *   ImageDatas = UIImageJPEGRepresentation(dashbgimageview.image,0.0);
    progfilebytestr  = [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    else
        progfilebytestr=@"";
        
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:comstr  forKey:@"reqid"];
    [params setObject: [prefs objectForKey:@"user_name"] forKey:@"username"];
    [params setObject:sactionamtxt.text  forKey:@"amount"];
    [params setObject:sanctiondatestr  forKey:@"sdate"];
    [params setObject: loanamttxt.text forKey:@"loanacc"];
    [params setObject:statustxt.text  forKey:@"status"];
    [params setObject:fudatestr  forKey:@"fu_date"];
    [params setObject:expdatestr  forKey:@"edate"];
    [params setObject:progfilebytestr  forKey:@"sac_img"];
    [params setObject:@"png"  forKey:@"extname"];

    //  NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getdetails.php?";
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@addstatus.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSMutableDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", dict);
        if (dict.count>1) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Sucessfully Saved"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
//
}
-(NSString*)formatdate:(NSString *)str
{
    if (![str isEqualToString:@"00000000"]) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        NSDate *dateFromString = [dateFormatter dateFromString:str];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
        return stringDate;
    }
    else
    {
        return @"";
    }
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    UIDatePicker *  picker = (UIDatePicker*)fudatetxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    fudatetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    [fudatetxt resignFirstResponder];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    fudatestr  =[dateFormatter stringFromDate:[picker date]];
}
-(void)doneWithNumberPad1:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    UIDatePicker *  picker = (UIDatePicker*)sactiondatetxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    sactiondatetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    [sactiondatetxt resignFirstResponder];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
  sanctiondatestr  =[dateFormatter stringFromDate:[picker date]];
    NSLog(@"%@",sanctiondatestr);
}

-(void)doneWithNumberPad2:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    UIDatePicker *  picker = (UIDatePicker*)expiraydatext.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    expiraydatext.text=dateString;
    [numberToolbarzip resignFirstResponder];
    [expiraydatext resignFirstResponder];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    expdatestr  =[dateFormatter stringFromDate:[picker date]];
}
-(IBAction)cancelBtnpress{
//    fudatetxt.hidden=YES;
//    statustoolbar.hidden=YES;
    [fudatetxt resignFirstResponder];
    [expiraydatext resignFirstResponder];
    [sactiondatetxt resignFirstResponder];
}

-(void)select:(UIButton*)sender
{
    if (sender.selected) {
        sender.selected=NO;
    }
    else
        sender.selected=YES;
}
-(void)upload
{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Camera",
                            @"Gallery",
                            nil];
    popup.tag = 1;
    [popup showInView:self.view];    
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
     if (buttonIndex==1)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    dashbgimageview.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.view.frame.origin.x,self.view.frame.origin.y, kbSize.height+100, 0);
    teamtableview.contentInset = contentInsets;
    teamtableview.scrollIndicatorInsets = contentInsets;
}

-(void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    teamtableview.contentInset = contentInsets;
    teamtableview.scrollIndicatorInsets = contentInsets;
}
-(BOOL)textFieldShouldReturn:(ACFloatingTextField *)textField
{
    [textField resignFirstResponder];
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
