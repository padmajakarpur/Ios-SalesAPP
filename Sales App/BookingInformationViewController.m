//
//  BookingInformationViewController.m
//  Sales App
//
//  Created by Infinitum on 12/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BookingInformationViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface BookingInformationViewController ()
@property (nonatomic, strong) UIView * navigationView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BookingInformationViewController

@synthesize scrollView,tableViewHome,bottomview,mxpager,indicator,bookdict,sapbookingdict,paymentdetailsdict,outstadingpaydict,paymentscheduledict,paymentduesdict,interestdetailsdict,phonelbl,emaillbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
//    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.0,screenRect.size.width,screenRect.size.height)];
//    [self.view addSubview:scrollView];
    
    _navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.0,screenRect.size.width,screenRect.size.height*0.35)];
    [self.view addSubview:_navigationView];
    _navigationView.backgroundColor = [UIColor colorWithHexString:@"#ED2026"];
    
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.22,screenRect.size.height*.03,screenRect.size.width*.64,screenRect.size.height*.07)];
    titlelable.textAlignment = NSTextAlignmentLeft;
    titlelable.text=@"Booking Information";
    titlelable.textColor=[UIColor whiteColor];
    [titlelable setBackgroundColor:[UIColor clearColor]];
    titlelable.font=[UIFont fontWithName:@"Open Sans" size:22];
    [_navigationView addSubview:titlelable];
    
    UIButton*  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    //  [backBtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow_back_white.png"] forState:UIControlStateNormal];
    [_navigationView addSubview:backBtn];
    
    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.height*0.07,screenRect.size.height*0.07)];
    dashbgimageview.image=[UIImage imageNamed:@"account_circle.png"];
    dashbgimageview.contentMode = UIViewContentModeScaleAspectFit;
    dashbgimageview.backgroundColor=[UIColor lightGrayColor];
    dashbgimageview.layer.cornerRadius=screenRect.size.height*0.035;
    dashbgimageview.clipsToBounds=YES;
    [dashbgimageview.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [dashbgimageview.layer setBorderWidth: 2.0];
    [_navigationView addSubview:dashbgimageview];
    
    UILabel *namelbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.08,screenRect.size.height*.11,screenRect.size.width*.64,screenRect.size.height*.07)];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text=[bookdict objectForKey:@"cutomer_name"];
    namelbl.textColor=[UIColor whiteColor];
    [namelbl setBackgroundColor:[UIColor clearColor]];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    [_navigationView addSubview:namelbl];
    
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.19,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [savebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    savebtn.layer.masksToBounds=YES;
 //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [_navigationView addSubview:savebtn];
    
   phonelbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.08,screenRect.size.height*.19,screenRect.size.width*.64,screenRect.size.height*.05)];
    phonelbl.textAlignment = NSTextAlignmentLeft;
    phonelbl.text=@"Mobile";
    phonelbl.textColor=[UIColor whiteColor];
    [phonelbl setBackgroundColor:[UIColor clearColor]];
    phonelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    [_navigationView addSubview:phonelbl];
    
    UIButton *emailbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.24,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [emailbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    emailbtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    emailbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [emailbtn setTitle:@"\uE0BE" forState:UIControlStateNormal];
    [_navigationView addSubview:emailbtn];
    
    emaillbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.05+screenRect.size.height*0.08,screenRect.size.height*0.24,screenRect.size.width*.64,screenRect.size.height*.05)];
    emaillbl.textAlignment = NSTextAlignmentLeft;
    emaillbl.text=@"Email";
    emaillbl.textColor=[UIColor whiteColor];
    [emaillbl setBackgroundColor:[UIColor clearColor]];
    emaillbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    [_navigationView addSubview:emaillbl];
    
    tittlearr=[NSMutableArray arrayWithObjects:@"General Info",@"Outstanding Payments",@"Payment Details",@"Payment Schedule",@"Payment Dues",@"Interest Details", nil];
    
    headerarr=[NSMutableArray arrayWithObjects:@"Booking NO",@"Booking Date",@"Project ID",@"Project Name",@"Building",@"Unit Number",@"Flat No",@"Flat Type",@"Custumer Number",@"Custumer Name",@"Scheme",@"Flat Category",@"Carpet Area in Sqft",@"Saleable Area in Sqft",@"Floor",@"Agreement value",@"Net cost",@"Total cost",@"Sales Group",@"Login User",@"Sales group",@"Book By",@"Back office owner",@"Back Office Owner ID",@"Bankloan owner ID",@"Bankloan owner",@"Stampduty owner  ID",@"Stamduty owner",@"ATS owner ID",@"ATS owner name",@"Rera carpet area",@"Rera balcony area",@"Rera terrace",@"Rera enclosed",@"Rera total",nil];
    
    mxpager=[[MXSegmentedPager alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.30,screenRect.size.width,screenRect.size.height*0.70)];
   
    mxpager.backgroundColor=[UIColor whiteColor];
    mxpager.segmentedControlPosition=MXSegmentedControlPositionTop;
    mxpager.contentMode=UIViewContentModeTop;
    mxpager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
   mxpager.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    mxpager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    mxpager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    mxpager.segmentedControl.titleTextAttributes=@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor whiteColor]};
    mxpager.segmentedControl.backgroundColor=[UIColor colorWithHexString:@"#ED2026"];
    [mxpager.pager registerClass:[UITextView class] forPageReuseIdentifier:@"TextPage"];
    mxpager.delegate=self;
    mxpager.dataSource=self;
    [self.view addSubview:mxpager];

//    mxpager.tintColor=[UIColor redColor];
//    mxpager.parallaxHeader.view = self.navigationView;
//    mxpager.parallaxHeader.height = screenRect.size.height*0.30;
//    mxpager.parallaxHeader.mode = MXParallaxHeaderModeFill;
//    mxpager.parallaxHeader.minimumHeight = screenRect.size.height*0.10;
    
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
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[bookdict objectForKey:@"display_booking_id"]  forKey:@"bookingId"];
        [params setObject:@"getBookingsDetails"  forKey:@"requestType"];
        [params setObject:[bookdict objectForKey:@"combo"] forKey:@"combo"];

        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getbookingdata.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];

        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
          
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            {
           sapbookingdict=[[dic objectForKey:@"bookingDetails"]objectForKey:@"SAPBookingDetails"] ;
                [indicator stopAnimating];
                
                NSDictionary *generalinfodict=[[sapbookingdict objectForKey:@"OT_BOOKING"] objectForKey:@"1"];

                textarr=[NSMutableArray arrayWithObjects:[generalinfodict objectForKey:@"BKNUM"],[bookdict objectForKey:@"booking_date"],[generalinfodict objectForKey:@"PROJ_ID"],[generalinfodict objectForKey:@"PROJ_NAME"],[generalinfodict objectForKey:@"BUILDING"],[generalinfodict objectForKey:@"UNIT_NO"],[generalinfodict objectForKey:@"FLAT_NO"],[generalinfodict objectForKey:@"BHK"],[generalinfodict objectForKey:@"KUNNR"],[generalinfodict objectForKey:@"NAME1"],[generalinfodict objectForKey:@"SCHEME"],[generalinfodict objectForKey:@"FLAT_CAT"],[generalinfodict objectForKey:@"CA_SQFT"],[generalinfodict objectForKey:@"SA_SQFT"],[generalinfodict objectForKey:@"FLOOR"],[generalinfodict objectForKey:@"AGVALUE"],[generalinfodict objectForKey:@"NET_COST"],[generalinfodict objectForKey:@"TOT_COST"],[generalinfodict objectForKey:@"SALESGRP"],[generalinfodict objectForKey:@"LUSER"],[generalinfodict objectForKey:@"SALES_GROUP_NAME"],[generalinfodict objectForKey:@"LOGIN_USER"],[generalinfodict objectForKey:@"BO_UNAME"],[generalinfodict objectForKey:@"BO_NAME"],[generalinfodict objectForKey:@"CC_UNAME"],[generalinfodict objectForKey:@"CC_NAME"],[generalinfodict objectForKey:@"SD_UNAME"],[generalinfodict objectForKey:@"SD_NAME"],[generalinfodict objectForKey:@"ATS_NAME"],[generalinfodict objectForKey:@"ATS_UNAME"],[generalinfodict objectForKey:@"RERA_CA"],[generalinfodict objectForKey:@"RERA_BALCONY"],[generalinfodict objectForKey:@"RERA_TERRACE"],[generalinfodict objectForKey:@"RERA_ENCLOSED"],[generalinfodict objectForKey:@"RERA_TOTAL"],nil];
                
              paymentdetailsdict=[sapbookingdict objectForKey:@"OT_10RM"] ;
                outstadingpaydict=[sapbookingdict objectForKey:@"ES_AGE"];
                paymentscheduledict=[sapbookingdict objectForKey:@"OT_SCHEDULE"];
               paymentduesdict =[sapbookingdict objectForKey:@"OT_DUE"];
                interestdetailsdict =[sapbookingdict objectForKey:@"OT_INTEREST"];
                
                NSString * str=[[sapbookingdict objectForKey:@"ES_AGE"] objectForKey:@"MOBILE"];
                if ([[[sapbookingdict objectForKey:@"ES_AGE"] objectForKey:@"MOBILE"] length] > 4)
                {
                    str = [str substringToIndex:[str length] - 4];
                    str = [str stringByAppendingString:@"XXXX"];
                }
                phonelbl.text=str;
                emaillbl.text=[[sapbookingdict objectForKey:@"ES_AGE"] objectForKey:@"EMAIL"];
                [mxpager reloadData];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    
    //        {
//            [indicator startAnimating];
//            NSURL * url;
//            NSMutableString *httpBodyString;
//            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"bookingId= %@&requestType=getBookingsDetails&combo=%@",[bookdict objectForKey:@"display_booking_id"],[bookdict objectForKey:@"combo"]]];
//            NSString*   urlstr = [[NSString alloc]initWithFormat:@"%@getbookingdata.php?",[prefs objectForKey:@"Link"]];
//
//            url=[[NSURL alloc] initWithString:urlstr];
//            NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
//
//            [urlRequest setHTTPMethod:@"POST"];
//            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
//
//            [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                if (error)
//                {
//                    NSLog(@"Failed to submit request");
//                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"My Tuition" message:@"Failed to submit request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                    [indicator stopAnimating];
//                }
//                else
//                {
//                    NSMutableString *content = [[NSString alloc]  initWithBytes:[data bytes]
//                                                                         length:[data length] encoding: NSUTF8StringEncoding];
//                    NSLog(@"content %@",content);
//                    NSError *error;
//                    if ([content isEqualToString:@""]) {
//
//                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"My Tuition" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                        [alert show];
//                        [indicator stopAnimating];
//
//                    }else {
//
//                        [tableViewHome reloadData];
//                        [indicator stopAnimating];
//                    }
//                }
//            }];
//        }

}

-(void)showbottomview:(NSString*)str
{
    [bottomview removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict;
    if ([str isEqualToString:@"Payment Details"])
       dict= [paymentdetailsdict objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)paymentdetailsdict.count]];
    
    if ([str isEqualToString:@"Interest Details"])
      dict= [interestdetailsdict objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)interestdetailsdict.count]];
    
    if ([str isEqualToString:@"Payment Dues"])
    {
        dict= [paymentduesdict objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)paymentduesdict.count]];
        bottomview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.94,screenRect.size.width,screenRect.size.height*0.06)];
        [self.view addSubview:bottomview];
        bottomview.backgroundColor=[UIColor colorWithHexString:@"#00cca3"];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.06)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.05];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text =@"Total";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor whiteColor];
        [bottomview addSubview:Srnolbl];
        
        UILabel*  tmslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.06)];
        tmslbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        tmslbl.textAlignment = NSTextAlignmentLeft;
        tmslbl.text =@"Due Amt.:";
        tmslbl.backgroundColor = [UIColor clearColor];
        tmslbl.textColor=[UIColor whiteColor];
        [bottomview addSubview:tmslbl];

        UILabel*  tmslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.0,screenRect.size.width*0.30,screenRect.size.height*0.06)];
        tmslbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        tmslbl2.textAlignment = NSTextAlignmentRight;
        tmslbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"DUE_AMT"]]];
        tmslbl2.backgroundColor = [UIColor clearColor];
        tmslbl2.textColor=[UIColor whiteColor];
        [bottomview addSubview:tmslbl2];
    }
    else
    {
    bottomview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.88,screenRect.size.width,screenRect.size.height*0.12)];
    [self.view addSubview:bottomview];
    bottomview.backgroundColor=[UIColor colorWithHexString:@"#00cca3"];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.12)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.05];
    Srnolbl.textAlignment = NSTextAlignmentCenter;
    Srnolbl.text =@"Total";
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor whiteColor];
    [bottomview addSubview:Srnolbl];
    
    UILabel*  linelble = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.03,screenRect.size.width*0.005,screenRect.size.height*0.06)];
    linelble.textAlignment = NSTextAlignmentCenter;
    linelble.backgroundColor = [UIColor whiteColor];
    [bottomview addSubview:linelble];
    
    UILabel*  tmslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.04)];
    tmslbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    tmslbl.textAlignment = NSTextAlignmentLeft;
    tmslbl.text =@"Amt. :";
    tmslbl.backgroundColor = [UIColor clearColor];
    tmslbl.textColor=[UIColor whiteColor];
    [bottomview addSubview:tmslbl];
    
  UILabel*  tmslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.0,screenRect.size.width*0.30,screenRect.size.height*0.04)];
    tmslbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    tmslbl2.textAlignment = NSTextAlignmentRight;
    tmslbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"WRBTR"]]];
    tmslbl2.backgroundColor = [UIColor clearColor];
    tmslbl2.textColor=[UIColor whiteColor];
    [bottomview addSubview:tmslbl2];
    
    UILabel*  taxlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.04,screenRect.size.width*0.20,screenRect.size.height*0.04)];
    taxlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    taxlbl.textAlignment = NSTextAlignmentLeft;
    taxlbl.text =@"Tax Amt. :";
    taxlbl.backgroundColor = [UIColor clearColor];
    taxlbl.textColor=[UIColor whiteColor];
    [bottomview addSubview:taxlbl];
    
   UILabel*    taxlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.04,screenRect.size.width*0.30,screenRect.size.height*0.04)];
    taxlbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    taxlbl2.textAlignment = NSTextAlignmentRight;
    taxlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"TAX"]]];
    taxlbl2.backgroundColor = [UIColor clearColor];
    taxlbl2.textColor=[UIColor whiteColor];
    [bottomview addSubview:taxlbl2];
    
    UILabel*  netlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.08,screenRect.size.width*0.20,screenRect.size.height*0.04)];
    netlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    netlbl.textAlignment = NSTextAlignmentLeft;
    netlbl.text =@"Net Amt.:";
    netlbl.backgroundColor = [UIColor clearColor];
    netlbl.textColor=[UIColor whiteColor];
    [bottomview addSubview:netlbl];
    
   UILabel*    netlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.08,screenRect.size.width*0.30,screenRect.size.height*0.04)];
    netlbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    netlbl2.textAlignment = NSTextAlignmentRight;
    netlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"NET"]]];
    netlbl2.backgroundColor = [UIColor clearColor];
    netlbl2.textColor=[UIColor whiteColor];
    [bottomview addSubview:netlbl2];
    }
}
- (UIView *)cover {
    if (!_navigationView) {
        // Set a cover on the top of the view
        _navigationView = [self.nibBundle loadNibNamed:@"Cover" owner:nil options:nil].firstObject;
    }
    return _navigationView;
}
-(NSString*)convertdate:(NSString*)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateFromString = [dateFormatter dateFromString:str];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:dateFromString];
    return stringDate;
}
-(NSString*)shownumber:(NSString*)str
{
     str= [NSString stringWithFormat:@"%0.02f",[str doubleValue]];
    float value=[str floatValue]+0.002;
NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setPositiveFormat:@"##,##,###"];
    formatter.maximumFractionDigits = 02;
    NSString*  defalutstr=[NSString stringWithFormat:@" ₹ %@",[formatter stringFromNumber:[NSNumber numberWithFloat:value]]];

    if ([defalutstr rangeOfString:@"."].location == NSNotFound) {
        defalutstr = [defalutstr stringByAppendingString:@".00"]; //str is now "hello world"
    } else {
        return defalutstr;
    }

    //
return defalutstr;
}
- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 40.f;
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
    
    if ([title isEqualToString:@"Payment Details"]||[title isEqualToString:@"Interest Details"]||[title isEqualToString:@"Payment Dues"])
    {
        [self showbottomview:title];
    }
    else
    {
        [bottomview removeFromSuperview];
    }

}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    NSLog(@"progress %f", parallaxHeader.progress);
}

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return tittlearr.count;
}

// Asks the data source for a title realted to a particular page of the segmented pager.
- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return [tittlearr objectAtIndex:index];
}

// Asks the data source for a view to insert in a particular page of the pager.
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {

    tableindex=index;
    
        //Add a table page
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tag=tableindex;

    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        return textarr.count;
    }
    if (tableView.tag==1) {
        return 1;
    }
    if (tableView.tag==2) {
        return paymentdetailsdict.count-1;
    }
    if (tableView.tag==3) {
        return paymentscheduledict.count;
    }
    if (tableView.tag==4) {
        return paymentduesdict.count-1;
    }
    if (tableView.tag==5) {
        return interestdetailsdict.count-1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];

    if (tableView.tag==0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.94,screenRect.size.height*0.12)];
        headerView.backgroundColor=[UIColor whiteColor];

        UIButton*  drawerbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.37,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*.05)];
        drawerbtn.font=[UIFont systemFontOfSize:screenRect.size.width*0.35];
        [drawerbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        drawerbtn.backgroundColor=[UIColor clearColor];
        [headerView addSubview:drawerbtn];

        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,headerView.frame.size.width*0.90,screenRect.size.height*0.04)];
        Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =[headerarr objectAtIndex:indexPath.row];
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor grayColor];
        [headerView addSubview:Srnolbl];

        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,headerView.frame.size.width*0.90,screenRect.size.height*0.05)];
        textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.05];
        textlbl.textAlignment = NSTextAlignmentLeft;
        textlbl.text =[textarr objectAtIndex:indexPath.row];
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor blackColor];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];

        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;

        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    if (tableView.tag==1) {
       
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.90,screenRect.size.height*0.45)];
        headerView.layer.cornerRadius=screenRect.size.width*0.04;
        headerView.backgroundColor=[UIColor colorWithHexString:@"#ED2026"];
        headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
        headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
        headerView.layer.shadowOpacity = 1.0f;
        headerView.layer.shadowRadius = 0.0f;
        headerView.layer.masksToBounds = NO;
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =@"Amount Due :";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.0,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        textlbl.textAlignment = NSTextAlignmentRight;
        textlbl.text =[self shownumber:[NSString stringWithFormat:@" %@",[outstadingpaydict objectForKey:@"AMTDUE"]]];
        
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor whiteColor];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];
        
        
        UILabel*  clearlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        clearlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        clearlbl.textAlignment = NSTextAlignmentLeft;
        clearlbl.text =@"Amount Cleared :";
        clearlbl.backgroundColor = [UIColor clearColor];
        clearlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:clearlbl];
        
        UILabel*  clearedlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.05,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        clearedlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        clearedlbl2.textAlignment = NSTextAlignmentRight;
        clearedlbl2.text =[self shownumber:[NSString stringWithFormat:@"%0.02f",[[outstadingpaydict objectForKey:@"TAX"] floatValue]+[[outstadingpaydict objectForKey:@"CLR_ACT"]floatValue] ]];
                clearedlbl2.backgroundColor = [UIColor clearColor];
        clearedlbl2.textColor=[UIColor whiteColor];
        clearedlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:clearedlbl2];
        
        UILabel*  Taxpaylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        Taxpaylbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Taxpaylbl.textAlignment = NSTextAlignmentLeft;
        Taxpaylbl.text =@"Tax Payable :";
        Taxpaylbl.backgroundColor = [UIColor clearColor];
        Taxpaylbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Taxpaylbl];
        
        UILabel*  netcleared = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.10,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        netcleared.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        netcleared.textAlignment = NSTextAlignmentRight;
        netcleared.text =[self shownumber:[NSString stringWithFormat:@"%@",[outstadingpaydict objectForKey:@"TAX"]]];
                netcleared.backgroundColor = [UIColor clearColor];
        netcleared.textColor=[UIColor whiteColor];
        netcleared.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:netcleared];
        
        UILabel*  netcleared2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        netcleared2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        netcleared2.textAlignment = NSTextAlignmentLeft;
        netcleared2.text =@"Net Cleared :";
        netcleared2.backgroundColor = [UIColor clearColor];
        netcleared2.textColor=[UIColor whiteColor];
        [headerView addSubview:netcleared2];
        
        UILabel*  Taxpaylbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.15,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Taxpaylbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        Taxpaylbl2.textAlignment = NSTextAlignmentRight;
        Taxpaylbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[outstadingpaydict objectForKey:@"CLR_ACT"]]]];
        ;
        Taxpaylbl2.backgroundColor = [UIColor clearColor];
        Taxpaylbl2.textColor=[UIColor whiteColor];
        Taxpaylbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:Taxpaylbl2];
        
        UILabel*  balancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        balancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        balancelbl.textAlignment = NSTextAlignmentLeft;
        balancelbl.text =@"Balance :";
        balancelbl.backgroundColor = [UIColor clearColor];
        balancelbl.textColor=[UIColor whiteColor];
        [headerView addSubview:balancelbl];
        
        UILabel*  balancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.20,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        balancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        balancelbl2.textAlignment = NSTextAlignmentRight;
        balancelbl2.text =[self shownumber:[NSString stringWithFormat:@" %@",[outstadingpaydict objectForKey:@"NETDUE1"]]];
        
        balancelbl2.backgroundColor = [UIColor clearColor];
        balancelbl2.textColor=[UIColor whiteColor];
        balancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:balancelbl2];
        
        UILabel*  gstlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.25,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        gstlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        gstlbl.textAlignment = NSTextAlignmentLeft;
        gstlbl.text =@"GST :";
        gstlbl.backgroundColor = [UIColor clearColor];
        gstlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:gstlbl];
        
        UILabel*  gstlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.25,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        gstlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        gstlbl2.textAlignment = NSTextAlignmentRight;
        gstlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[outstadingpaydict objectForKey:@"GST"]]]
        ;
        gstlbl2.backgroundColor = [UIColor clearColor];
        gstlbl2.textColor=[UIColor whiteColor];
        gstlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:gstlbl2];
        
        UILabel*  totalduelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        totalduelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        totalduelbl.textAlignment = NSTextAlignmentLeft;
        totalduelbl.text =@"Total Due :";
        totalduelbl.backgroundColor = [UIColor clearColor];
        totalduelbl.textColor=[UIColor whiteColor];
        [headerView addSubview:totalduelbl];
        
        UILabel*  totalduelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.30,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        totalduelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        totalduelbl2.textAlignment = NSTextAlignmentRight;
        totalduelbl2.text =[self shownumber:[NSString stringWithFormat:@"%0.02f",[[outstadingpaydict objectForKey:@"NETDUE1"] floatValue]+[[outstadingpaydict objectForKey:@"GST"]floatValue] ]];
        
        totalduelbl2.backgroundColor = [UIColor clearColor];
        totalduelbl2.textColor=[UIColor whiteColor];
        totalduelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:totalduelbl2];
        
        UILabel*  interestlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.35,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        interestlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        interestlbl.textAlignment = NSTextAlignmentLeft;
        interestlbl.text =@"Interest Due :";
        interestlbl.backgroundColor = [UIColor clearColor];
        interestlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:interestlbl];
        
        UILabel*  interestlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.35,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        interestlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        interestlbl2.textAlignment = NSTextAlignmentRight;
        interestlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[outstadingpaydict objectForKey:@"INT_DEBIT"]]];
        ;
        interestlbl2.backgroundColor = [UIColor clearColor];
        interestlbl2.textColor=[UIColor whiteColor];
        interestlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:interestlbl2];
        
        UILabel*  Totalbalancelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        Totalbalancelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Totalbalancelbl.textAlignment = NSTextAlignmentLeft;
        Totalbalancelbl.text =@"Total Balance : ";
        Totalbalancelbl.backgroundColor = [UIColor clearColor];
        Totalbalancelbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Totalbalancelbl];
        
        UILabel*  Totalbalancelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.40,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Totalbalancelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        Totalbalancelbl2.textAlignment = NSTextAlignmentRight;
        Totalbalancelbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[outstadingpaydict objectForKey:@"NETDUE"]]];
        
        Totalbalancelbl2.backgroundColor = [UIColor clearColor];
        Totalbalancelbl2.textColor=[UIColor whiteColor];
        Totalbalancelbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:Totalbalancelbl2];
        
        [cell.contentView addSubview:headerView];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;
    }
    if (tableView.tag==2) {
        NSDictionary *dict=[paymentdetailsdict objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]];

            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.90,screenRect.size.height*0.30)];
            headerView.layer.cornerRadius=screenRect.size.width*0.04;
            headerView.backgroundColor=[UIColor colorWithHexString:@"#ED2026"];
            headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
            headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
            headerView.layer.shadowOpacity = 1.0f;
            headerView.layer.shadowRadius = 0.0f;
            headerView.layer.masksToBounds = NO;
            
            UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
            Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =@"Inst. No :";
            Srnolbl.backgroundColor = [UIColor clearColor];
            Srnolbl.textColor=[UIColor whiteColor];
            [headerView addSubview:Srnolbl];
            
            UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.0,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
            textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
            textlbl.textAlignment = NSTextAlignmentRight;
        textlbl.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"INSTNO"]];
        
            textlbl.backgroundColor = [UIColor clearColor];
            textlbl.textColor=[UIColor whiteColor];
            textlbl.lineBreakMode = NSLineBreakByWordWrapping;
            [headerView addSubview:textlbl];
            [cell.contentView addSubview:headerView];
            
            UILabel*  clearlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
            clearlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            clearlbl.textAlignment = NSTextAlignmentLeft;
        clearlbl.text =@"Inst Date :";
            clearlbl.backgroundColor = [UIColor clearColor];
            clearlbl.textColor=[UIColor whiteColor];
            [headerView addSubview:clearlbl];
            
            UILabel*  clearedlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.05,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
            clearedlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
            clearedlbl2.textAlignment = NSTextAlignmentRight;
            clearedlbl2.text =[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"INSTDT"]]];
            clearedlbl2.backgroundColor = [UIColor clearColor];
            clearedlbl2.textColor=[UIColor whiteColor];
            clearedlbl2.lineBreakMode = NSLineBreakByWordWrapping;
            [headerView addSubview:clearedlbl2];
            
            UILabel*  Taxpaylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
            Taxpaylbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            Taxpaylbl.textAlignment = NSTextAlignmentLeft;
        Taxpaylbl.text =@"Amount :";
            Taxpaylbl.backgroundColor = [UIColor clearColor];
            Taxpaylbl.textColor=[UIColor whiteColor];
            [headerView addSubview:Taxpaylbl];
            
            UILabel*  netcleared = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.10,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
            netcleared.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            netcleared.textAlignment = NSTextAlignmentRight;
                netcleared.text =[self shownumber:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[dict objectForKey:@"WRBTR"]]]];
        
                    netcleared.backgroundColor = [UIColor clearColor];
            netcleared.textColor=[UIColor whiteColor];
            netcleared.lineBreakMode = NSLineBreakByWordWrapping;
            [headerView addSubview:netcleared];
            
            UILabel*  netcleared2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
            netcleared2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            netcleared2.textAlignment = NSTextAlignmentLeft;
        netcleared2.text =@"Tax Amount :";
            netcleared2.backgroundColor = [UIColor clearColor];
            netcleared2.textColor=[UIColor whiteColor];
            [headerView addSubview:netcleared2];
            
            UILabel*  Taxpaylbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.15,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
            Taxpaylbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
            Taxpaylbl2.textAlignment = NSTextAlignmentRight;
            Taxpaylbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"TAX"]]];
            Taxpaylbl2.backgroundColor = [UIColor clearColor];
            Taxpaylbl2.textColor=[UIColor whiteColor];
            Taxpaylbl2.lineBreakMode = NSLineBreakByWordWrapping;
            [headerView addSubview:Taxpaylbl2];
            
            UILabel*  Amtlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
            Amtlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            Amtlbl.textAlignment = NSTextAlignmentLeft;
        Amtlbl.text =@"Net Amount :";
            Amtlbl.backgroundColor = [UIColor clearColor];
            Amtlbl.textColor=[UIColor whiteColor];
            [headerView addSubview:Amtlbl];
      
            UILabel*  Amtlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.20,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
            Amtlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
            Amtlbl2.textAlignment = NSTextAlignmentRight;
        Amtlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"NET"]]];
    
            Amtlbl2.backgroundColor = [UIColor clearColor];
            Amtlbl2.textColor=[UIColor whiteColor];
            Amtlbl2.lineBreakMode = NSLineBreakByWordWrapping;
            [headerView addSubview:Amtlbl2];
            
            UILabel*  pentalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.25,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
            pentalbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
            pentalbl.textAlignment = NSTextAlignmentLeft;
        pentalbl.text =@"Clearing Date :";
            pentalbl.backgroundColor = [UIColor clearColor];
            pentalbl.textColor=[UIColor whiteColor];
            [headerView addSubview:pentalbl];
            
            UILabel*  pentalbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.25,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
            pentalbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
            pentalbl2.textAlignment = NSTextAlignmentRight;
        pentalbl2.text =[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"CDATE"]]];
            pentalbl2.backgroundColor = [UIColor clearColor];
            pentalbl2.textColor=[UIColor whiteColor];
            pentalbl2.lineBreakMode = NSLineBreakByWordWrapping;
            [headerView addSubview:pentalbl2];
            
        [cell.contentView addSubview:headerView];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;
      
    }
    if (tableView.tag==3||tableView.tag==4) {
        NSDictionary *dict=[[NSDictionary alloc]init];
        if (tableView.tag==3)
        {
      dict=[paymentscheduledict objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        }
        if (tableView.tag==4)
        {
            dict=[paymentduesdict objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        }

        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.90,screenRect.size.height*0.25)];
        headerView.layer.cornerRadius=screenRect.size.width*0.04;
        headerView.backgroundColor=[UIColor colorWithHexString:@"#ED2026"];
        headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
        headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
        headerView.layer.shadowOpacity = 1.0f;
        headerView.layer.shadowRadius = 0.0f;
        headerView.layer.masksToBounds = NO;
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =@"Schedule No :";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.0,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        textlbl.textAlignment = NSTextAlignmentRight;
        textlbl.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"PITEM"]];
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor whiteColor];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];
        
        UILabel*  clearlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        clearlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        clearlbl.textAlignment = NSTextAlignmentLeft;
        clearlbl.text =@"Milestone :";
        clearlbl.backgroundColor = [UIColor clearColor];
        clearlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:clearlbl];
        
        UILabel*  clearedlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.05,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        clearedlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        clearedlbl2.textAlignment = NSTextAlignmentRight;
        clearedlbl2.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"MILESTONE"]];
        clearedlbl2.backgroundColor = [UIColor clearColor];
        clearedlbl2.textColor=[UIColor whiteColor];
        clearedlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:clearedlbl2];
        
        UILabel*  Taxpaylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        Taxpaylbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Taxpaylbl.textAlignment = NSTextAlignmentLeft;
        Taxpaylbl.text =@"Milestone % :";
        Taxpaylbl.backgroundColor = [UIColor clearColor];
        Taxpaylbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Taxpaylbl];
        
        UILabel*  netcleared = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.10,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        netcleared.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        netcleared.textAlignment = NSTextAlignmentRight;
        netcleared.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"PRCENTVL"]];
        netcleared.backgroundColor = [UIColor clearColor];
        netcleared.textColor=[UIColor whiteColor];
        netcleared.lineBreakMode = NSLineBreakByWordWrapping;
        netcleared.numberOfLines = 0;
        [headerView addSubview:netcleared];
        
        UILabel*  netcleared2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        netcleared2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        netcleared2.textAlignment = NSTextAlignmentLeft;
        netcleared2.text =@"Due Date :";
        netcleared2.backgroundColor = [UIColor clearColor];
        netcleared2.textColor=[UIColor whiteColor];
        [headerView addSubview:netcleared2];
        
        UILabel*  Taxpaylbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.15,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Taxpaylbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        Taxpaylbl2.textAlignment = NSTextAlignmentRight;
        Taxpaylbl2.text =[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"DUEDATE"]]];
        Taxpaylbl2.backgroundColor = [UIColor clearColor];
        Taxpaylbl2.textColor=[UIColor whiteColor];
        Taxpaylbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:Taxpaylbl2];
        
        UILabel*  Amtlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,headerView.frame.size.width*0.35,screenRect.size.height*0.05)];
        Amtlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Amtlbl.textAlignment = NSTextAlignmentLeft;
        Amtlbl.text =@"Due Amount :";
        Amtlbl.backgroundColor = [UIColor clearColor];
        Amtlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Amtlbl];
        
        UILabel*  Amtlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.height*0.20,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Amtlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        Amtlbl2.textAlignment = NSTextAlignmentRight;
        
        Amtlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"TOTAL"]]];
        Amtlbl2.backgroundColor = [UIColor clearColor];
        Amtlbl2.textColor=[UIColor whiteColor];
        Amtlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:Amtlbl2];
       
        [cell.contentView addSubview:headerView];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;
        
        if (tableView.tag==4) {
            textlbl.text =[NSString stringWithFormat:@" %@",[dict objectForKey:@"SR"]];
            Srnolbl.text =@"Sr :";
            Taxpaylbl2.text =[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"ACDATE"]]];
          //  [NSString stringWithFormat:@" %@",[dict objectForKey:@"ACDATE"]];

        }
    }
    if (tableView.tag==5) {
        
     NSDictionary*   dict=[interestdetailsdict objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.90,screenRect.size.height*0.30)];
        headerView.layer.cornerRadius=screenRect.size.width*0.04;
        headerView.backgroundColor=[UIColor colorWithHexString:@"#ED2026"];
        headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
        headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
        headerView.layer.shadowOpacity = 1.0f;
        headerView.layer.shadowRadius = 0.0f;
        headerView.layer.masksToBounds = NO;
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentLeft;
        Srnolbl.text =@"Sr. No :";
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Srnolbl];
        
        UILabel*  textlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.0,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        textlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        textlbl.textAlignment = NSTextAlignmentRight;
        textlbl.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"SR"]];
        textlbl.backgroundColor = [UIColor clearColor];
        textlbl.textColor=[UIColor whiteColor];
        textlbl.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:textlbl];
        [cell.contentView addSubview:headerView];
        
        UILabel*  clearlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        clearlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        clearlbl.textAlignment = NSTextAlignmentLeft;
        clearlbl.text =@"Inst No :";
        clearlbl.backgroundColor = [UIColor clearColor];
        clearlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:clearlbl];
        
        UILabel*  clearedlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.05,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        clearedlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        clearedlbl2.textAlignment = NSTextAlignmentRight;
        clearedlbl2.text =[NSString stringWithFormat:@"%@",[dict objectForKey:@"INSTNO"]];
        clearedlbl2.backgroundColor = [UIColor clearColor];
        clearedlbl2.textColor=[UIColor whiteColor];
        clearedlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:clearedlbl2];
        
        UILabel*  Taxpaylbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Taxpaylbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Taxpaylbl.textAlignment = NSTextAlignmentLeft;
        Taxpaylbl.text =@"Inst Date :";
        Taxpaylbl.backgroundColor = [UIColor clearColor];
        Taxpaylbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Taxpaylbl];
        
        UILabel*  netcleared = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.10,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        netcleared.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        netcleared.textAlignment = NSTextAlignmentRight;
        netcleared.text =[self convertdate:[NSString stringWithFormat:@"%@",[dict objectForKey:@"INSTDT"]]];
        netcleared.backgroundColor = [UIColor clearColor];
        netcleared.textColor=[UIColor whiteColor];
        netcleared.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:netcleared];
        
        UILabel*  netcleared2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.15,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        netcleared2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        netcleared2.textAlignment = NSTextAlignmentLeft;
        netcleared2.text =@"Transaction Amount :";
        netcleared2.backgroundColor = [UIColor clearColor];
        netcleared2.textColor=[UIColor whiteColor];
        [headerView addSubview:netcleared2];
        
        UILabel*  Taxpaylbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.15,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Taxpaylbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        Taxpaylbl2.textAlignment = NSTextAlignmentRight;
        Taxpaylbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"WRBTR"]]];
        Taxpaylbl2.backgroundColor = [UIColor clearColor];
        Taxpaylbl2.textColor=[UIColor whiteColor];
        Taxpaylbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:Taxpaylbl2];
        
        UILabel*  Amtlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Amtlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Amtlbl.textAlignment = NSTextAlignmentLeft;
        Amtlbl.text =@"Tax Amount :";
        Amtlbl.backgroundColor = [UIColor clearColor];
        Amtlbl.textColor=[UIColor whiteColor];
        [headerView addSubview:Amtlbl];
        
        UILabel*  Amtlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.20,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        Amtlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        Amtlbl2.textAlignment = NSTextAlignmentRight;
        Amtlbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"TAX"]]];
        Amtlbl2.backgroundColor = [UIColor clearColor];
        Amtlbl2.textColor=[UIColor whiteColor];
        Amtlbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:Amtlbl2];
        
        UILabel*  pentalbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.25,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        pentalbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        pentalbl.textAlignment = NSTextAlignmentLeft;
        pentalbl.text =@"Net Amount :";
        pentalbl.backgroundColor = [UIColor clearColor];
        pentalbl.textColor=[UIColor whiteColor];
        [headerView addSubview:pentalbl];
        
        UILabel*  pentalbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,screenRect.size.height*0.25,headerView.frame.size.width*0.40,screenRect.size.height*0.05)];
        pentalbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
        pentalbl2.textAlignment = NSTextAlignmentRight;
        pentalbl2.text =[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"NET"]]];
        pentalbl2.backgroundColor = [UIColor clearColor];
        pentalbl2.textColor=[UIColor whiteColor];
        pentalbl2.lineBreakMode = NSLineBreakByWordWrapping;
        [headerView addSubview:pentalbl2];
        
        [cell.contentView addSubview:headerView];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.contentMode= UIViewContentModeLeft;
    }
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
    if (tableView.tag==0) {
        return screenRect.size.height*0.12;
    }
    if (tableView.tag==1) {
        return screenRect.size.height*0.47;
    }
    if (tableView.tag==2||tableView.tag==5) {
        return screenRect.size.height*0.42;
    }
    if (tableView.tag==3||tableView.tag==4) {
        return screenRect.size.height*0.30;
    }
    return screenRect.size.height*0.12;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backbtn{
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
