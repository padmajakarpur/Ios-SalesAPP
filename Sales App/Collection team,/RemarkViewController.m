//
//  RemarkViewController.m
//  Sales App
//
//  Created by Infinitum on 03/07/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "RemarkViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface RemarkViewController ()

@end

@implementation RemarkViewController
@synthesize tableViewHome,scrollview,TakePhotoView,remarktxt,comestr,remarklbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#ED2026"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];

    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Remarks";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
   
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
   /// backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e9e9e9"];
    // [self.view addSubview:backgroundview];
 
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.05];
    [self.view addSubview:navigationbtn];

    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.03,screenRect.size.width*.25,screenRect.size.height*.07)];
    [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setTitle:@"Add remark" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:addbtn];
    addbtn.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];

    scrollview = [[UIScrollView alloc] init];
    [scrollview setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10, screenRect.size.width,screenRect.size.height*0.9)];
    scrollview.backgroundColor=[UIColor colorWithHexString:@""];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];

    _remarkstr=[[NSMutableString alloc]init];
    for (int i=0; i<_teamarr.count; i++) {
        _remarkstr=[_remarkstr stringByAppendingString:[NSString stringWithFormat:@"\n%@",[[[_teamarr objectAtIndex:i]objectForKey:@"TDLINE"] stringByReplacingOccurrencesOfString:@"*" withString:@""]]];
    }
    remarklbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,screenRect.size.height*0.01,screenRect.size.width*.90,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    remarklbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    if (_remarkstr.length>=2) {
        remarklbl.text=[_remarkstr substringWithRange:NSMakeRange(2, [_remarkstr length]-2)];
    }
    
    [remarklbl setTextColor:[UIColor blackColor]];
    remarklbl.textAlignment = NSTextAlignmentLeft;
    remarklbl.lineBreakMode = NSLineBreakByWordWrapping;
    remarklbl.numberOfLines = 0;
    [scrollview addSubview:remarklbl];
    [remarklbl sizeToFit];
    NSLog(@"%@",_remarkstr);
    scrollview.contentSize=CGSizeMake(screenRect.size.width,remarklbl.frame.size.height+10);
}

-(void)add
{
    TakePhotoView = [[CustomIOS7AlertView alloc] init];
    [TakePhotoView setContainerView:[self signImageSetAlert]];
    [TakePhotoView setDelegate:self];
    [TakePhotoView setUseMotionEffects:true];
    [TakePhotoView show];
}
-(UIView *)signImageSetAlert{
    int heig=0;
    UIView *demoView;
    heig=150;
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,160)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    [topButton setTitle:@"Add remark" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topButton setBackgroundColor:[UIColor colorWithHexString:@"#E8E8E8"]];
    [demoView addSubview:topButton];
    
    remarktxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 50, 280, 50)];
    remarktxt.textAlignment=NSTextAlignmentLeft;
    remarktxt.delegate = self;
    remarktxt.textColor=[UIColor blackColor];
    [remarktxt setBackgroundColor:[UIColor clearColor]];
    remarktxt.leftViewMode = UITextFieldViewModeAlways;
    [remarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
    remarktxt.returnKeyType=UIReturnKeyDone;
    remarktxt.placeholder=@"Remark";
    [demoView addSubview:remarktxt];
  
    // [self.downPicker setData:array]
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(10,110,135,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:cancelBtn];
    
    UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(155,110,135,40)];
    [okbtn setTitle:@"Submit" forState:UIControlStateNormal];
    [okbtn addTarget:self action:@selector(saveremark) forControlEvents:UIControlEventTouchUpInside];
    [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    okbtn.tag=1;
    [okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:okbtn];
    return demoView;
}
-(void)saveremark
{
    if (![remarktxt.text isEqualToString:@""]) {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
    //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
    acttyindicator.color=[UIColor blackColor];
    [TakePhotoView addSubview:acttyindicator];
    [acttyindicator bringSubviewToFront:TakePhotoView];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:comestr  forKey:@"reqid"];
    [params setObject: [prefs objectForKey:@"user_name"] forKey:@"username"];
    [params setObject:remarktxt.text  forKey:@"remarks"];

       //  NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getdetails.php?";
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@addremarks.php?",[prefs objectForKey:@"Link"]];
    [acttyindicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSMutableDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", dict);
        [TakePhotoView close];
        [self getdata];
        [acttyindicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [acttyindicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Please enter remarks."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)getdata
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _teamarr=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:comestr  forKey:@"reqid"];
    
    //  NSString* urlString =@"http://49.248.43.178/xrbia/mobilecrm/getdetails.php?";
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getdetails.php?",[prefs objectForKey:@"Link"]];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSMutableDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", dict);
        if (dict.count>0) {
            _teamarr=[[dict objectForKey:@"ProjectDetails"]objectForKey:@"OT_LINE"];
            _remarkstr=[[NSMutableString alloc]init];
            for (int i=0; i<_teamarr.count; i++) {
                _remarkstr=[_remarkstr stringByAppendingString:[NSString stringWithFormat:@"\n%@",[[[_teamarr objectAtIndex:i]objectForKey:@"TDLINE"] stringByReplacingOccurrencesOfString:@"*" withString:@""]]];
            }
   remarklbl.text=[_remarkstr substringWithRange:NSMakeRange(2, [_remarkstr length]-2)];
            [remarklbl sizeToFit];
scrollview.contentSize=CGSizeMake(screenRect.size.width,remarklbl.frame.size.height+10);
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)closeAlert:(id)sender{
    [TakePhotoView close];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
