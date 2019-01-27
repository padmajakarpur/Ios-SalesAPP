//
//  Front_OfficeViewController.m
//  Sales App
//
//  Created by Infinitum on 06/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "Front_OfficeViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "AddLeadViewController.h"
#import "SalesHeadViewController.h"
@interface Front_OfficeViewController ()

@end
@implementation Front_OfficeViewController
@synthesize scrollView,mobiletxt,projectstxt,numberToolbarzip,projectpicker,projectoolbar,projectstr,projectarr,indicator,headerView,demoView,bgview,Assigntxt,assignstr,assignpicker,assigntoolbar,assignsalesarr,appDelegate,prosjectidarr,projectidstr,tableViewHome,visitarr,leadarr,betwlbl,assignarr,assignidarr,assignbtn,TakePhotoView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    projectidstr=[[NSString alloc]init];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Search Prospect";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.82,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setTitle:@"\uE145" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn.titleLabel setFont:customFontdregs];
    [addbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:addbtn];
    
    CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10,screenRect.size.width,screenRect.size.height*0.90);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
    scrollView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    int hig=screenRect.size.height*0.02;
    mobiletxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    mobiletxt.textAlignment=NSTextAlignmentLeft;
    mobiletxt.delegate = self;
    mobiletxt.textColor=[UIColor blackColor];
    [mobiletxt setBackgroundColor:[UIColor clearColor]];
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    mobiletxt.returnKeyType=UIReturnKeyDone;
    mobiletxt.selectedLineColor = [UIColor redColor];
    mobiletxt.selectedPlaceHolderColor = [UIColor redColor];
    mobiletxt.placeHolderColor = [UIColor grayColor];
    mobiletxt.placeholder=@"Mobile number*";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    mobiletxt.inputAccessoryView = numberToolbarzip;
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    mobiletxt.keyboardType = UIKeyboardTypeNumberPad;
    mobiletxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:mobiletxt];
    
    hig=hig+ screenRect.size.height*0.10;
    projectstxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
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
    projectstxt.placeholder=@"Projects*";
    projectstxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:projectstxt];

    hig=hig+ screenRect.size.height*0.10;
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.40,screenRect.size.height*0.07)];
    [savebtn setTitle:@"Search" forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    [savebtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    savebtn.layer.borderColor = [UIColor grayColor].CGColor;
    savebtn.layer.borderWidth = 0.5;
    [scrollView addSubview:savebtn];

    betwlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.48,screenRect.size.width*0.70,screenRect.size.height*0.04)];
    betwlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.045];
    betwlbl.textAlignment = NSTextAlignmentLeft;
    betwlbl.text =@"Visiit already done";
    betwlbl.backgroundColor = [UIColor clearColor];
    betwlbl.textColor=[UIColor blackColor];
    betwlbl.lineBreakMode = NSLineBreakByWordWrapping;
    betwlbl.numberOfLines = 0;
    [scrollView addSubview:betwlbl];
    betwlbl.hidden=YES;

    hig=hig+ screenRect.size.height*0.10;
    
        tableViewHome = [[UITableView alloc] init];
        [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.53, screenRect.size.width,screenRect.size.height*.30)];
        tableViewHome.editing=NO;
        tableViewHome.backgroundColor=[UIColor clearColor];
        tableViewHome.delegate = self;
        tableViewHome.dataSource = self;
        tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
        [scrollView addSubview:tableViewHome];
    
    assignbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,screenRect.size.height*0.93,screenRect.size.width*0.40,screenRect.size.height*0.06)];
    [assignbtn setTitle:@"Assign To" forState:UIControlStateNormal];
    [assignbtn addTarget:self action:@selector(assign) forControlEvents:UIControlEventTouchUpInside];
    assignbtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    [assignbtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [assignbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [assignbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    assignbtn.layer.borderColor = [UIColor grayColor].CGColor;
    assignbtn.layer.borderWidth = 0.5;
    [self.view addSubview:assignbtn];
    assignbtn.hidden=YES;

    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}
-(void) viewWillAppear:(BOOL)animated
{
    [self getproject];
    [self getsalesperson];
    [self closeAlert:0];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return visitarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict=[visitarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];

    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.15)];
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
    Srnolbl.text =[dict objectForKey:@"assigned_user_name"];
        Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.04,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =[NSString stringWithFormat:@"Date:%@",[dict objectForKey:@"att_date_c"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.075,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    idlbl.textAlignment = NSTextAlignmentLeft;
    //    NSString * str=[dict objectForKey:@"phone_mobile"];
    //    if ([[dict objectForKey:@"phone_mobile"] length] > 0)
    //    {
    //        str = [str substringToIndex:[str length] - 4];
    //        str = [str stringByAppendingString:@"XXXX"];
    //    }
    //  idlbl.text =[NSString stringWithFormat:@"Mobile:%@",str];
    idlbl.text=[NSString stringWithFormat:@"Status:%@",[dict objectForKey:@"prospect_stage_c"]];
    
    [headerView addSubview:idlbl];

    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.62,screenRect.size.height*0.11,screenRect.size.width*0.30,screenRect.size.height*0.035)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [headerView addSubview:Createvoucherbtn];
    [Createvoucherbtn setTitle:@"Re-visit"forState:UIControlStateNormal];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#6762C3"]] ;
    [headerView addSubview:Createvoucherbtn];
    Createvoucherbtn.tag=indexPath.row;
    [Createvoucherbtn addTarget:self action:@selector(revisit:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Admin"]) {
        UIButton *changeuserrbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30,screenRect.size.height*0.11,screenRect.size.width*0.30,screenRect.size.height*0.035)];
        changeuserrbtn.layer.cornerRadius = 4.0f;
        [changeuserrbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
        [headerView addSubview:Createvoucherbtn];
        [changeuserrbtn setTitle:@"Change user"forState:UIControlStateNormal];
        [changeuserrbtn setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]] ;
        [headerView addSubview:changeuserrbtn];
        changeuserrbtn.tag=indexPath.row;
        [changeuserrbtn addTarget:self action:@selector(changeUser:) forControlEvents:UIControlEventTouchUpInside];
    }

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
    return screenRect.size.height*0.16;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView * deletealert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Are sure do you wan't to delete the record?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        deletealert.tag=indexPath.row;
        [deletealert show];
    }
    return UITableViewCellEditingStyleNone;

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([[prefs objectForKey:@"role_name"] isEqualToString:@"Front Office Admin"])
    return YES;
    
    else
        return NO;
}
-(void)changeUser:(UIButton*)sender
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    heig=150;
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-100, 300,150)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
    [topButton setTitle:@"Assign Sales Executive" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
   
    Assigntxt = [[UITextField alloc] initWithFrame:CGRectMake(10,50,280,40)];
    Assigntxt.textAlignment=NSTextAlignmentLeft;
    Assigntxt.delegate = self;
    Assigntxt.autoSuggestionDataSource = self;
    Assigntxt.showImmediately = true;
    [Assigntxt observeTextFieldChanges];
    Assigntxt.textColor=[UIColor blackColor];
    [Assigntxt setBackgroundColor:[UIColor clearColor]];
    Assigntxt.leftViewMode = UITextFieldViewModeAlways;
    [Assigntxt setKeyboardType:UIKeyboardTypeEmailAddress];
    Assigntxt.returnKeyType=UIReturnKeyDone;
    Assigntxt.fieldIdentifier=@"salesID";
    Assigntxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:Assigntxt];
    CALayer *bottomBorders3 = [CALayer layer];
    bottomBorders3.frame = CGRectMake(0.0f, Assigntxt.frame.size.height - 5, Assigntxt.frame.size.width, 1.0f);
    bottomBorders3.backgroundColor = [UIColor grayColor].CGColor;
    [Assigntxt.layer addSublayer:bottomBorders3];
    Assigntxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Assign To" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,100,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,100,125,40)];
    [savebtn setTitle:@"Change user" forState:UIControlStateNormal];
    savebtn.tag=sender.tag;
    [savebtn addTarget:self action:@selector(assignvisit:)
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
-(void)assignvisit:(UIButton*)btn
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSString * useridstr;
    for (int i=0; i<assignarr.count; i++) {
        if ([[assignarr objectAtIndex:i]isEqualToString:Assigntxt.text]) {
            useridstr=[assignidarr objectAtIndex:i];
        }
    }
    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
    //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
    acttyindicator.color=[UIColor blackColor];
    [self.view addSubview:acttyindicator];
    [acttyindicator bringSubviewToFront:demoView];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[visitarr objectAtIndex:btn.tag] objectForKey:@"id"] forKey:@"id"];
    [params setObject:useridstr forKey:@"user_id"];
    [params setObject:[[visitarr objectAtIndex:btn.tag] objectForKey:@"id"] forKey:@"id"];
    
    
    [acttyindicator startAnimating];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@change_visit.php?",[prefs objectForKey:@"Link"]];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
        CATransition *transition1 = [CATransition animation];
        transition1.duration = 0.5;
        transition1.type = kCATransitionPush;
        transition1.subtype = kCATransitionFromLeft;
        [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [demoView.layer addAnimation:transition1 forKey:nil];
        demoView.hidden=YES;
        [bgview removeFromSuperview];
        [self checkvisit];
        
        [acttyindicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [acttyindicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
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
            [indicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getproject];
        }];
    }
}
-(void)search
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (![mobiletxt.text isEqualToString:@""]) {
            if (![projectstxt.text isEqualToString:@""])
            {
                [indicator removeFromSuperview];
                indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
                indicator.color=[UIColor colorWithHexString:@"#004c00"];
                indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
                [self.view addSubview:indicator];
                [indicator bringSubviewToFront:self.view];
                
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:mobiletxt.text  forKey:@"phone"];
        [params setObject:projectidstr  forKey:@"pid"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getproject1.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];        
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            leadarr =[[NSMutableArray alloc]init];
            NSLog(@"JSON: %@", userDict);
            leadarr =[[userDict objectForKey:@"Android"] objectForKey:@"leads"];
            [indicator stopAnimating];
            [headerView removeFromSuperview];
            visitarr =[[NSMutableArray alloc]init];
            [tableViewHome reloadData];
            betwlbl.hidden=YES;
            if (leadarr.count>0) {
                assignbtn.hidden=NO;

                NSDictionary *dict=[leadarr objectAtIndex:0];
                if ([[dict objectForKey:@"Type"]isEqualToString:@"p"]) {
                    tableViewHome.frame= CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.52, screenRect.size.width,screenRect.size.height*.30);
                    [assignbtn setTitle:@"Assign To" forState:UIControlStateNormal];

                    headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.32,screenRect.size.width*0.94,screenRect.size.height*0.16)];
                    //   headerView.backgroundColor=[UIColor cyanColor];
                    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
                    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
                    headerView.layer.shadowOpacity = 1.0f;
                    headerView.layer.shadowRadius = 0.0f;
                    headerView.layer.masksToBounds = NO;
                    headerView.backgroundColor=[UIColor whiteColor];
                    
                    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.70,screenRect.size.height*0.04)];
                    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
                    Srnolbl.textAlignment = NSTextAlignmentLeft;
                    Srnolbl.text =[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]];
                    Srnolbl.backgroundColor = [UIColor clearColor];
                    Srnolbl.textColor=[UIColor blackColor];
                    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
                    Srnolbl.numberOfLines = 0;
                    [headerView addSubview:Srnolbl];
                    
                    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    namelbl.textAlignment = NSTextAlignmentLeft;
                    namelbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"project_name"]];
                    namelbl.backgroundColor = [UIColor clearColor];
                    namelbl.textColor=[UIColor blackColor];
                    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
                    namelbl.numberOfLines = 0;
                    
                    [headerView addSubview:namelbl];
                    
                    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.085,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    idlbl.textAlignment = NSTextAlignmentLeft;
                   
                    idlbl.text=[NSString stringWithFormat:@"Mobile:%@",[dict objectForKey:@"phone_mobile"]];
                    
                    UILabel*  assignlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    assignlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    assignlbl.textAlignment = NSTextAlignmentLeft;
                    assignlbl.text =[NSString stringWithFormat:@"Created by:%@",[dict objectForKey:@"assigned_user_name"]];
                    assignlbl.backgroundColor = [UIColor clearColor];
                    assignlbl.textColor=[UIColor blackColor];
                    assignlbl.lineBreakMode = NSLineBreakByWordWrapping;
                    assignlbl.numberOfLines = 0;
                    
                    [headerView addSubview:assignlbl];
                    [headerView addSubview:idlbl];
                    [scrollView addSubview:headerView];
                    [self checkvisit];
                }
                else
                {
                    if ([[[dict objectForKey:@"Type"]lowercaseString]isEqualToString:@"c"])
                    {
                    [assignbtn setTitle:@"Create new" forState:UIControlStateNormal];
                    }
                    tableViewHome.frame= CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.54, screenRect.size.width,screenRect.size.height*.28);

                    headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.30,screenRect.size.width*0.94,screenRect.size.height*0.24)];
                    //   headerView.backgroundColor=[UIColor cyanColor];
                    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
                    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
                    headerView.layer.shadowOpacity = 1.0f;
                    headerView.layer.shadowRadius = 0.0f;
                    headerView.layer.masksToBounds = NO;
                    headerView.backgroundColor=[UIColor whiteColor];
                    
                    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.005,screenRect.size.width*0.70,screenRect.size.height*0.035)];
                    Srnolbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    Srnolbl.textAlignment = NSTextAlignmentLeft;
                    Srnolbl.text =[NSString stringWithFormat:@"Name:%@",[dict objectForKey:@"fullname"]];
                    Srnolbl.backgroundColor = [UIColor clearColor];
                    Srnolbl.textColor=[UIColor blackColor];
                    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
                    Srnolbl.numberOfLines = 0;
                    [headerView addSubview:Srnolbl];

                    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.04,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    namelbl.textAlignment = NSTextAlignmentLeft;
                    namelbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"project_name"]];
                    namelbl.backgroundColor = [UIColor clearColor];
                    namelbl.textColor=[UIColor blackColor];
                    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
                    namelbl.numberOfLines = 0;
                    
                    [headerView addSubview:namelbl];
                    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.075,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    idlbl.textAlignment = NSTextAlignmentLeft;
                    
                    idlbl.text=[NSString stringWithFormat:@"Booking No:%@",[dict objectForKey:@"bknum"]];
                    
                    UILabel*  assignlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    assignlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    assignlbl.textAlignment = NSTextAlignmentLeft;
                    assignlbl.text =[NSString stringWithFormat:@"Unit No:%@",[dict objectForKey:@"unit_no"]];
                    assignlbl.backgroundColor = [UIColor clearColor];
                    assignlbl.textColor=[UIColor blackColor];
                    assignlbl.lineBreakMode = NSLineBreakByWordWrapping;
                    assignlbl.numberOfLines = 0;
                    [headerView addSubview:assignlbl];
                    
                    UILabel*  schemelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.145,screenRect.size.width*0.80,screenRect.size.height*0.035)];
                    schemelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
                    schemelbl.textAlignment = NSTextAlignmentLeft;
                    schemelbl.text =[NSString stringWithFormat:@"Scheme:%@",[dict objectForKey:@"scheme"]];
                    schemelbl.backgroundColor = [UIColor clearColor];
                    schemelbl.textColor=[UIColor blackColor];
                    schemelbl.lineBreakMode = NSLineBreakByWordWrapping;
                    schemelbl.numberOfLines = 0;

                    UILabel*  addresslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.18,screenRect.size.width*0.85,screenRect.size.height*0.05)];
                    addresslbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
                    addresslbl.textAlignment = NSTextAlignmentLeft;
                    addresslbl.text =[NSString stringWithFormat:@"Address:%@",[dict objectForKey:@"per_add"]];
                    addresslbl.backgroundColor = [UIColor clearColor];
                    addresslbl.textColor=[UIColor blackColor];
                    addresslbl.lineBreakMode = NSLineBreakByWordWrapping;
                    addresslbl.numberOfLines = 0;
                      if ([[dict objectForKey:@"Type"]isEqualToString:@"cp"])
                      {
                          [self checkvisit];
                          schemelbl.text =[NSString stringWithFormat:@"Lead id: %@",[dict objectForKey:@"lead_id"]];
                      }
                    [headerView addSubview:schemelbl];
                    [headerView addSubview:addresslbl];
                    [headerView addSubview:idlbl];
                    [scrollView addSubview:headerView];
                }
            }
            else
            {
                assignbtn.hidden=YES;
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No lead found" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create new", nil];
                alert.tag=100;
                alert.delegate=self;
                [alert show];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"please select project"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"please enter mobile no."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    if (alertView.tag==100) {
        if (buttonIndex ==1){
//            AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
//            mainvc.comefrom=@"frontoffice";
//            mainvc.projectstr=projectstxt.text;
//            mainvc.indstr=projectidstr;
//            mainvc.mobilestr=mobiletxt.text;
//            [self.navigationController pushViewController:mainvc animated:YES];
           
            TakePhotoView = [[CustomIOS7AlertView alloc] init];
            [TakePhotoView setContainerView:[self signImageSetAlert]];
            [TakePhotoView setDelegate:self];
            [TakePhotoView setUseMotionEffects:true];
            [TakePhotoView show];
        }
    }
    else
    {
         if (buttonIndex ==1){
             [self deleteVisit:alertView.tag];
         }
    }
}
-(UIView *)signImageSetAlert{
    int heig=0;
    UIView *demoView;
    heig=150;
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,260)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
   _custmortypetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10, 10, 280, 40)];
    _custmortypetxt.textAlignment=NSTextAlignmentLeft;
    _custmortypetxt.delegate = self;
    _custmortypetxt.textColor=[UIColor blackColor];
    [_custmortypetxt setBackgroundColor:[UIColor clearColor]];
    _custmortypetxt.leftViewMode = UITextFieldViewModeAlways;
    [_custmortypetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _custmortypetxt.returnKeyType=UIReturnKeyDone;
    _custmortypetxt.selectedLineColor = [UIColor redColor];
    _custmortypetxt.selectedPlaceHolderColor = [UIColor redColor];
    _custmortypetxt.placeHolderColor = [UIColor grayColor];
    _custmortypetxt.font = [UIFont systemFontOfSize:14];
    _custmortypetxt.placeholder=@"Customer Type";
    _custmortypetxt.text=@"New";
    [demoView addSubview:_custmortypetxt];

    if (leadarr.count>0) {
        
    if ([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"c"])
     {
         _custmortypetxt.text=@"Existing customer";
         _custmortypetxt.enabled=NO;
     }
    }
    NSMutableArray * custtypearr=[[NSMutableArray alloc]initWithObjects:@"New",@"Existing customer", nil];
    _Custypedropdown = [[DownPicker alloc] initWithTextField:_custmortypetxt withData:custtypearr];
    [_Custypedropdown setPlaceholderWhileSelecting:@"Customer Type"];
    [_Custypedropdown showArrowImage:YES];
    [_Custypedropdown addTarget:self action:@selector(dp_Selected:)
               forControlEvents:UIControlEventValueChanged];
    _Custypedropdown.placeholder=@"Customer Type";
    [demoView addSubview:_Custypedropdown];

    _purposetxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,60, 280,40)];
    _purposetxt.textAlignment=NSTextAlignmentLeft;
    _purposetxt.delegate = self;
    _purposetxt.textColor=[UIColor blackColor];
    [_purposetxt setBackgroundColor:[UIColor clearColor]];
    _purposetxt.leftViewMode = UITextFieldViewModeAlways;
    [_purposetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _purposetxt.returnKeyType=UIReturnKeyDone;
    _purposetxt.selectedLineColor = [UIColor redColor];
    _purposetxt.selectedPlaceHolderColor = [UIColor redColor];
    _purposetxt.placeHolderColor = [UIColor grayColor];
    _purposetxt.font = [UIFont systemFontOfSize:14];
    _purposetxt.placeholder=@"Purpose";
    [demoView addSubview:_purposetxt];
    NSMutableArray * purposearr=[[NSMutableArray alloc]initWithObjects:@"Existing Booking enquiry",@"new Booking enquiry", nil];
    _purposedropdown = [[DownPicker alloc] initWithTextField:_purposetxt withData:purposearr];
    [_purposedropdown setPlaceholderWhileSelecting:@"Purpose"];
    [_purposedropdown showArrowImage:YES];
    [_purposedropdown addTarget:self action:@selector(dp_Selected:)
               forControlEvents:UIControlEventValueChanged];
    _purposedropdown.placeholder=@"Purpose";
    [demoView addSubview:_purposedropdown];

    _custprojectxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,110, 280,40)];
    _custprojectxt.textAlignment=NSTextAlignmentLeft;
    _custprojectxt.delegate = self;
    _custprojectxt.textColor=[UIColor blackColor];
    [_custprojectxt setBackgroundColor:[UIColor clearColor]];
    _custprojectxt.leftViewMode = UITextFieldViewModeAlways;
    [_custprojectxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _custprojectxt.returnKeyType=UIReturnKeyDone;
    _custprojectxt.selectedLineColor = [UIColor redColor];
    _custprojectxt.selectedPlaceHolderColor = [UIColor redColor];
    _custprojectxt.placeHolderColor = [UIColor grayColor];
    _custprojectxt.font = [UIFont systemFontOfSize:14];
    _custprojectxt.placeholder=@"Project";
    NSMutableArray * projnamearr=[[NSMutableArray alloc]init];
    for (int i=0; i<appDelegate.projectarr.count; i++) {
        NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
        [projnamearr addObject:[dict objectForKey:@"name"]];
    }
    _projectdropdown = [[DownPicker alloc] initWithTextField:_custprojectxt withData:projnamearr];
    [_projectdropdown setPlaceholderWhileSelecting:@"Project"];
    [_projectdropdown showArrowImage:YES];
    [_projectdropdown addTarget:self action:@selector(dp_Selected:)
               forControlEvents:UIControlEventValueChanged];
    _projectdropdown.placeholder=@"Project";
    [demoView addSubview:_projectdropdown];
    [demoView addSubview:_custprojectxt];
    
    _unitnotxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,160, 280,40)];
    _unitnotxt.textAlignment=NSTextAlignmentLeft;
    _unitnotxt.delegate = self;
    _unitnotxt.textColor=[UIColor blackColor];
    [_unitnotxt setBackgroundColor:[UIColor clearColor]];
    _unitnotxt.leftViewMode = UITextFieldViewModeAlways;
    [_unitnotxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _unitnotxt.returnKeyType=UIReturnKeyDone;
    _unitnotxt.selectedLineColor = [UIColor redColor];
    _unitnotxt.selectedPlaceHolderColor = [UIColor redColor];
    _unitnotxt.placeHolderColor = [UIColor grayColor];
    _unitnotxt.font = [UIFont systemFontOfSize:14];
    _unitnotxt.placeholder=@"Unit No";
    [demoView addSubview:_unitnotxt];
    if ([_custmortypetxt.text isEqualToString:@"New"]) {
        _custprojectxt.text=@"";
        _unitnotxt.text=@"";
        _custprojectxt.hidden=YES;
        _unitnotxt.hidden=YES;
    }
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(10,210,135,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [demoView addSubview:cancelBtn];
    
    UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(155,210,135,40)];
    [okbtn setTitle:@"Submit" forState:UIControlStateNormal];
    [okbtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    okbtn.tag=1;
    [okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [demoView addSubview:okbtn];
    return demoView;
}
-(void)save
{
    [TakePhotoView close];
    AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
    mainvc.comefrom=@"frontoffice";
    mainvc.projectstr=projectstxt.text;
    mainvc.indstr=projectidstr;
    mainvc.mobilestr=mobiletxt.text;
    mainvc.custypoestr=_custmortypetxt.text;
    mainvc.custprojstr=_custprojectxt.text;
    mainvc.unitnostr=_unitnotxt.text;
    mainvc.purposestr=_purposetxt.text;
    if (leadarr.count>0) {
        if ([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"c"])
            mainvc.cpdict=[leadarr objectAtIndex:0];
    }
    [self.navigationController pushViewController:mainvc animated:YES];

    //            AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
//            mainvc.comefrom=@"frontoffice";
//            mainvc.projectstr=projectstxt.text;
//            mainvc.indstr=projectidstr;
//            mainvc.mobilestr=mobiletxt.text;
//            [self.navigationController pushViewController:mainvc animated:YES];
    
}
-(void)checkvisit
{
    [indicator removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.35, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [scrollView addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
     if ([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"cp"])
         [params setObject:[[leadarr objectAtIndex:0] objectForKey:@"lead_id"]   forKey:@"lead_unqiue_id_c"];
    
    else
    [params setObject:[[leadarr objectAtIndex:0] objectForKey:@"lead_unqiue_id_c"]   forKey:@"lead_unqiue_id_c"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getprojectvisit.php?",[prefs objectForKey:@"Link"]];

    if (![[params objectForKey:@"lead_unqiue_id_c"]isEqual:[NSNull null]]) {
        [indicator startAnimating];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", userDict);
            [indicator stopAnimating];
            visitarr =[[NSMutableArray alloc]init];
            visitarr=[[userDict objectForKey:@"Android"] objectForKey:@"sales_person"];
            if (visitarr.count>0) {
                [tableViewHome reloadData];
                betwlbl.hidden=NO;
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No visit found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)dp_Selected:(DownPicker*)dp {
    NSString* selectedValue = [dp text];
    
    if (dp==_Custypedropdown) {
        if ([selectedValue isEqualToString:@"New"]) {
            _custprojectxt.text=@"";
            _unitnotxt.text=@"";
            _custprojectxt.hidden=YES;
            _unitnotxt.hidden=YES;
        }
        else
        {
            _custprojectxt.hidden=NO;
            _unitnotxt.hidden=NO;
        }
    }
}
-(void)addrecord:(NSInteger)no:(NSInteger)index
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    NSMutableDictionary * dict;
    NSString * useridstr;
    for (int i=0; i<assignarr.count; i++) {
        if ([[assignarr objectAtIndex:i]isEqualToString:Assigntxt.text]) {
            useridstr=[assignidarr objectAtIndex:i];
        }
    }
    //revisit
    if (no==1) {
       dict=[visitarr objectAtIndex:index ];
        [params setObject:[dict objectForKey:@"customer_mobile_c"]  forKey:@"mobileno"];
        [params setObject:[dict objectForKey:@"project_name"]  forKey:@"project"];
        [params setObject:[dict objectForKey:@"assigned_user_id"]  forKey:@"assignto"];
        [params setObject:@"revisit"  forKey:@"visitstatus"];
        [params setObject: [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]] forKey:@"name"];
        [params setObject:[dict objectForKey:@"lead_number_c"]  forKey:@"lead_id"];
    }
    //p
    else if(no==0)
    {
        dict=[leadarr objectAtIndex:0];
        [params setObject:mobiletxt.text  forKey:@"mobileno"];
        [params setObject:[dict objectForKey:@"project_name"]  forKey:@"project"];
        [params setObject:useridstr  forKey:@"assignto"];
        [params setObject:@"new"  forKey:@"visitstatus"];
        [params setObject: [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]] forKey:@"name"];
        [params setObject:[dict objectForKey:@"lead_unqiue_id_c"]  forKey:@"lead_id"];
        [params setObject:_purposetxt.text  forKey:@"purpose"];
    }
    //cp
    else if(no==2)
    {
      //  dict=[visitarr objectAtIndex:0];
        NSMutableDictionary* dict1=[leadarr objectAtIndex:0];
        [params setObject:mobiletxt.text  forKey:@"mobileno"];
        [params setObject:[dict1 objectForKey:@"project_name"]  forKey:@"project"];
        [params setObject:useridstr  forKey:@"assignto"];
        [params setObject:@"customer"  forKey:@"visitstatus"];
        [params setObject: [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"fullname"]] forKey:@"name"];
        [params setObject:[dict1 objectForKey:@"lead_id"]  forKey:@"lead_id"];
        [params setObject:_purposetxt.text  forKey:@"purpose"];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savefrontdet.php",[prefs objectForKey:@"Link"]];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"attendby"];
    [params setObject:@"saveFrontoffice"  forKey:@"requestType"];
    [params setObject:datestr forKey:@"datetime"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)assign
{
    if ([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"c"]) {
        TakePhotoView = [[CustomIOS7AlertView alloc] init];
        [TakePhotoView setContainerView:[self signImageSetAlert]];
        [TakePhotoView setDelegate:self];
        [TakePhotoView setUseMotionEffects:true];
        [TakePhotoView show];
        
    //        AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
//        mainvc.comefrom=@"frontoffice";
//        mainvc.projectstr=projectstxt.text;
//        mainvc.indstr=projectidstr;
//        mainvc.mobilestr=mobiletxt.text;
//        mainvc.cpdict=[leadarr objectAtIndex:0];
//        [self.navigationController pushViewController:mainvc animated:YES];
    }
    else
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
    [topButton setTitle:@"Assign Sales Executive" forState:UIControlStateNormal];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    topButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
        _purposetxt= [[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,50, 280,40)];
        _purposetxt.textAlignment=NSTextAlignmentLeft;
        _purposetxt.delegate = self;
        _purposetxt.textColor=[UIColor blackColor];
        [_purposetxt setBackgroundColor:[UIColor clearColor]];
        _purposetxt.leftViewMode = UITextFieldViewModeAlways;
        [_purposetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        _purposetxt.returnKeyType=UIReturnKeyDone;
        _purposetxt.selectedLineColor = [UIColor redColor];
        _purposetxt.selectedPlaceHolderColor = [UIColor redColor];
        _purposetxt.placeHolderColor = [UIColor grayColor];
        _purposetxt.font = [UIFont systemFontOfSize:14];
        _purposetxt.placeholder=@"Purpose";
        [demoView addSubview:_purposetxt];
        NSMutableArray * purposearr=[[NSMutableArray alloc]initWithObjects:@"Exsistiong Booking query",@"new Booking query", nil];
        _purposedropdown = [[DownPicker alloc] initWithTextField:_purposetxt withData:purposearr];
        [_purposedropdown setPlaceholderWhileSelecting:@"Purpose"];
        [_purposedropdown showArrowImage:YES];
        [_purposedropdown addTarget:self action:@selector(dp_Selected:)
                   forControlEvents:UIControlEventValueChanged];
        _purposedropdown.placeholder=@"Purpose";
        [demoView addSubview:_purposedropdown];
    
    Assigntxt = [[UITextField alloc] initWithFrame:CGRectMake(10,100,280,40)];
    Assigntxt.textAlignment=NSTextAlignmentLeft;
    Assigntxt.delegate = self;
    Assigntxt.autoSuggestionDataSource = self;
    Assigntxt.showImmediately = true;
    [Assigntxt observeTextFieldChanges];
    Assigntxt.textColor=[UIColor blackColor];
    [Assigntxt setBackgroundColor:[UIColor clearColor]];
    Assigntxt.leftViewMode = UITextFieldViewModeAlways;
    [Assigntxt setKeyboardType:UIKeyboardTypeEmailAddress];
    Assigntxt.returnKeyType=UIReturnKeyDone;
    Assigntxt.fieldIdentifier=@"salesID";
    Assigntxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:Assigntxt];
    CALayer *bottomBorders3 = [CALayer layer];
    bottomBorders3.frame = CGRectMake(0.0f, Assigntxt.frame.size.height - 5, Assigntxt.frame.size.width, 1.0f);
    bottomBorders3.backgroundColor = [UIColor grayColor].CGColor;
    [Assigntxt.layer addSublayer:bottomBorders3];
    Assigntxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Assign To" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];

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
    [savebtn setTitle:@"Update" forState:UIControlStateNormal];
    [savebtn addTarget:self
                action:@selector(createvisit)
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
}
- (UITableViewCell *)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    static NSString *cellIdentifier = @"MonthAutoSuggestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ([field.fieldIdentifier isEqualToString:@"salesID"]) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSArray *months = [assignarr mutableCopy];
        if (text.length > 0) {
            NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
            months = [assignarr filteredArrayUsingPredicate:filterPredictate];
        }
        cell.textLabel.text =months[indexPath.row];
    }
    return cell;
}
- (NSInteger)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section forText:(NSString *)text {
    
    if (text.length == 0) {
        return assignarr.count;
    }
    NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
    NSInteger count = [assignarr filteredArrayUsingPredicate:filterPredictate].count;
    return count;
}
- (void)autoSuggestionField:(UITextField *)field textChanged:(NSString *)text {
   // [self loadWeekDays];
}

- (CGFloat)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    return 50;
}
- (void)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    NSLog(@"Selected suggestion at index row - %ld", (long)indexPath.row);
    NSArray *months = assignarr;
    if (text.length > 0) {
        NSPredicate *filterPredictate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", text];
        months = [assignarr filteredArrayUsingPredicate:filterPredictate];
    }
    Assigntxt.text =months[indexPath.row];
}
-(void)createvisit
{
    if ([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"c"]) {
        AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
        mainvc.comefrom=@"frontoffice";
        mainvc.projectstr=projectstxt.text;
        mainvc.indstr=projectidstr;
        mainvc.mobilestr=mobiletxt.text;
        mainvc.cpdict=[leadarr objectAtIndex:0];
        [self.navigationController pushViewController:mainvc animated:YES];
    }
    else if([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"p"])
    {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
   //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
    acttyindicator.color=[UIColor blackColor];
    [self.view addSubview:acttyindicator];
    [acttyindicator bringSubviewToFront:demoView];

    if (leadarr.count>0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *datestr = [formatter stringFromDate:[NSDate date]];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict=[leadarr objectAtIndex:0];
        
        NSString * useridstr=[prefs objectForKey:@"user_id"];
        for (int i=0; i<assignarr.count; i++) {
            if ([[assignarr objectAtIndex:i]isEqualToString:Assigntxt.text]) {
                useridstr=[assignidarr objectAtIndex:i];
            }
        }
        int visit= [[dict objectForKey:@"no_of_visits_c"]intValue];
        visit++;
        
        NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
        [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
        [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
        [data setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        [data setObject:@"Sales_Sales_Person"  forKey:@"module_name"];

        NSMutableDictionary* _submitdict=[[NSMutableDictionary alloc]init];
        [_submitdict setObject:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]] forKey:@"name"];
        [_submitdict setObject:@"555" forKey:@"mobile_id_c"];
        [_submitdict setObject:[dict objectForKey:@"phone_office"]  forKey:@"phone_office"];
        [_submitdict setObject:useridstr forKey:@"assigned_user_id"];
        [_submitdict setObject:datestr forKey:@"date_modified_mobile_c"];
        [_submitdict setObject:@"mobile"  forKey:@"record_updated_place_c"];
        [_submitdict setObject:projectstxt.text  forKey:@"project_sales_sales_person_1_name"];
        [_submitdict setObject:projectidstr  forKey:@"project_sales_sales_person_1project_ida"];
        [_submitdict setObject:@"Followup"  forKey:@"att_stage1_c"];
        [_submitdict setObject:datestr  forKey:@"att_date_c"];
        [_submitdict setObject:datestr  forKey:@"fu_date_c"];
        [_submitdict setObject:@"1"  forKey:@"_formatteddatestr"];
        [_submitdict setObject:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]]  forKey:@"customer_name_c"];
        [_submitdict setObject:mobiletxt.text  forKey:@"customer_mobile_c"];
        [_submitdict setObject:@"1"  forKey:@"no_of_visits_c"];
        [_submitdict setObject:@"0" forKey:@"visit_done_c"];
        [_submitdict setObject:[dict objectForKey:@"lead_stage_c"] forKey:@"prospect_stage_c"];
        [_submitdict setObject:[dict objectForKey:@"id"]  forKey:@"leads_sales_sales_person_1leads_ida"];
        [_submitdict setObject:[dict objectForKey:@"id"]  forKey:@"mobile_offline_parent_id_c"];

        NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
        [jsonDict setObject:@"25"forKey:@"ID"];
        NSMutableArray *arr =[NSMutableArray arrayWithObjects:_submitdict, nil];
        [jsonDict setObject:arr  forKey:@"data"];
        
        NSString *jsonString;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
            options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (! jsonData) {
            //  NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        [data setObject:encodedUrl  forKey:@"jsonParam"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@androupdatedatatocrm.php?",[prefs objectForKey:@"Link"]];
        
        [acttyindicator startAnimating];
        
        [manager GET:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSLog(@"JSON: %@", userDict);
            NSMutableArray *recordarr=[[userDict objectForKey:@"Android"] objectForKey:@"records"];
            
            NSDictionary *dict=[recordarr objectAtIndex:0];
            {
                if (![[dict objectForKey:@"mobile_id_c"] isEqualToString:@""]||!([dict objectForKey:@"mobile_id_c"]==nil)) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Sucessfully Saved."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self addrecord:0:0];
                    // [self.navigationController popViewControllerAnimated:YES];
                    CATransition *transition1 = [CATransition animation];
                    transition1.duration = 0.5;
                    transition1.type = kCATransitionPush;
                    transition1.subtype = kCATransitionFromLeft;
                    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    [demoView.layer addAnimation:transition1 forKey:nil];
                    demoView.hidden=YES;
                    [bgview removeFromSuperview];
                    [self checkvisit];
                    [ acttyindicator stopAnimating];
                }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to update"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [ acttyindicator stopAnimating];
                }
            }
                        
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [indicator stopAnimating];
        }];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No lead found" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create new", nil];
        alert.tag=100;
        alert.delegate=self;
        [alert show];
    }
    }
    else if ([[[leadarr objectAtIndex:0] objectForKey:@"Type"]isEqualToString:@"cp"])
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        acttyindicator.frame =CGRectMake(0,0 ,screenRect.size.width,screenRect.size.height*0.80);
        //     acttyindicator.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
        acttyindicator.color=[UIColor blackColor];
        [self.view addSubview:acttyindicator];
        [acttyindicator bringSubviewToFront:demoView];
        
        if (leadarr.count>0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *datestr = [formatter stringFromDate:[NSDate date]];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSDictionary *dict=[leadarr objectAtIndex:0];
            
            NSString * useridstr=[prefs objectForKey:@"user_id"];
            
            for (int i=0; i<assignarr.count; i++) {
                if ([[assignarr objectAtIndex:i]isEqualToString:Assigntxt.text]) {
                    useridstr=[assignidarr objectAtIndex:i];
                }
            }
            int visit= [[dict objectForKey:@"no_of_visits_c"]intValue];
            visit++;
            NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
            [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
            [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
            [data setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
            [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
            [data setObject:@"Sales_Sales_Person"  forKey:@"module_name"];

            NSMutableDictionary* _submitdict=[[NSMutableDictionary alloc]init];
            [_submitdict setObject:[dict objectForKey:@"lead_name"] forKey:@"name"];
            [_submitdict setObject:@"555" forKey:@"mobile_id_c"];
            [_submitdict setObject:@""  forKey:@"phone_office"];
            [_submitdict setObject:useridstr forKey:@"assigned_user_id"];
            [_submitdict setObject:datestr forKey:@"date_modified_mobile_c"];
            [_submitdict setObject:@"mobile"  forKey:@"record_updated_place_c"];
            [_submitdict setObject:projectstxt.text  forKey:@"project_sales_sales_person_1_name"];
            [_submitdict setObject:projectidstr  forKey:@"project_sales_sales_person_1project_ida"];
            [_submitdict setObject:@"Followup"  forKey:@"att_stage1_c"];
            [_submitdict setObject:datestr  forKey:@"att_date_c"];
            [_submitdict setObject:datestr  forKey:@"fu_date_c"];
            [_submitdict setObject:@"1"  forKey:@"_formatteddatestr"];
            [_submitdict setObject:[dict objectForKey:@"lead_name"]  forKey:@"customer_name_c"];
            [_submitdict setObject:mobiletxt.text  forKey:@"customer_mobile_c"];
            [_submitdict setObject:@"1"  forKey:@"no_of_visits_c"];
            [_submitdict setObject:@"0" forKey:@"visit_done_c"];
            [_submitdict setObject:@"Warm" forKey:@"prospect_stage_c"];
            [_submitdict setObject:[dict objectForKey:@"lead_no"]  forKey:@"leads_sales_sales_person_1leads_ida"];
            [_submitdict setObject:[dict objectForKey:@"lead_no"]  forKey:@"mobile_offline_parent_id_c"];
            NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
            [jsonDict setObject:@"25"forKey:@"ID"];
            NSMutableArray *arr =[NSMutableArray arrayWithObjects:_submitdict, nil];
            [jsonDict setObject:arr  forKey:@"data"];
            
            NSString *jsonString;
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            if (! jsonData) {
                //  NSLog(@"Got an error: %@", error);
            } else {
                jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
            NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            [data setObject:encodedUrl  forKey:@"jsonParam"];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSString*   urlString = [[NSString alloc]initWithFormat:@"%@androupdatedatatocrm.php?",[prefs objectForKey:@"Link"]];
            
            [acttyindicator startAnimating];
            
            [manager GET:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                NSLog(@"JSON: %@", userDict);
                NSMutableArray *recordarr=[[userDict objectForKey:@"Android"] objectForKey:@"records"];

                NSDictionary *dict=[recordarr objectAtIndex:0];
                {
                    if (![[dict objectForKey:@"mobile_id_c"] isEqualToString:@""]||!([dict objectForKey:@"mobile_id_c"]==nil)) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Sucessfully Saved."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        [self addrecord:2:0];

                        // [self.navigationController popViewControllerAnimated:YES];
                        CATransition *transition1 = [CATransition animation];
                        transition1.duration = 0.5;
                        transition1.type = kCATransitionPush;
                        transition1.subtype = kCATransitionFromLeft;
                        [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                        [demoView.layer addAnimation:transition1 forKey:nil];
                        demoView.hidden=YES;
                        [bgview removeFromSuperview];
                        [self checkvisit];
                        [ acttyindicator stopAnimating];
                        
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to update"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        [ acttyindicator stopAnimating];
                        
                    }
                }
                
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [indicator stopAnimating];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [indicator stopAnimating];
            }];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No lead found" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create new", nil];
            alert.tag=100;
            alert.delegate=self;
            [alert show];
        }
    
    }
}
-(void)deleteVisit:(NSInteger)index
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[visitarr objectAtIndex:index] objectForKey:@"id"] forKey:@"id"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@delete_visit.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
          NSLog(@"JSON: %@", userDict);
        
        NSMutableArray *copy=[visitarr mutableCopy];
        [copy removeObjectAtIndex:index];
        visitarr =[copy mutableCopy];
        [UIView transitionWithView: tableViewHome
                          duration: 0.35f
                           options: UIViewAnimationOptionTransitionFlipFromTop
                        animations: ^(void)
         {
             [tableViewHome reloadData];
         }
                        completion: nil];
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)getsalesperson
{
    if (assignarr.count<=0) {
        assignarr=[[NSMutableArray alloc]init];
        assignidarr=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        
        [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getSalesPersonList.php?",[prefs objectForKey:@"Link"]];

        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableArray *suerarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", suerarr);
            
            for (int i=0; i<suerarr.count; i++) {
                NSDictionary* dict=[suerarr objectAtIndex:i];
                [assignarr addObject:[dict objectForKey:@"sales_user"]];
                [assignidarr addObject:[dict objectForKey:@"user_id"]];
            }
            [indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self getsalesperson];
        }];
    }
}
-(void)revisit:(UIButton*)btn
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [indicator removeFromSuperview];
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    
    [self addrecord:1:btn.tag];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [indicator startAnimating];
    NSDictionary *dict=[visitarr objectAtIndex:btn.tag];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *datestr = [formatter stringFromDate:[NSDate date]];
        
        NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
        [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
        [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
        [data setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
        [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
        [data setObject:@"Sales_Sales_Person"  forKey:@"module_name"];
        
        int visit= [[dict objectForKey:@"no_of_visits_c"]intValue];
        visit++;
        NSMutableDictionary* _submitdict=[[NSMutableDictionary alloc]init];
        [_submitdict setObject:[dict objectForKey:@"id"] forKey:@"id"];
        [_submitdict setObject:[dict objectForKey:@"att_stage1_c"] forKey:@"att_stage1_c"];
        [_submitdict setObject:@"revisit" forKey:@"prospect_stage_c"];
        [_submitdict setObject:@"0" forKey:@"visit_done_c"];
        [_submitdict setObject:datestr forKey:@"fu_date_c"];
        [_submitdict setObject:datestr  forKey:@"date_modified_mobile_c"];
        [_submitdict setObject:datestr  forKey:@"att_date_c"];
        [_submitdict setObject:[NSString stringWithFormat:@"%d",visit]  forKey:@"no_of_visits_c"];
        [_submitdict setObject:@"Re assign" forKey:@"unqualified_reason_c"];
        
                NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
        [jsonDict setObject:@"25"forKey:@"ID"];
        NSMutableArray *arr =[NSMutableArray arrayWithObjects:_submitdict, nil];
        [jsonDict setObject:arr  forKey:@"data"];
        
        NSString *jsonString;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (! jsonData) {
            //  NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            // NSLog(@"Got Stringr %@",jsonString);
         
        }
        NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        [data setObject:encodedUrl  forKey:@"jsonParam"];
        
        [indicator startAnimating];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@androupdatedatatocrm.php?",[prefs objectForKey:@"Link"]];
        
        [indicator startAnimating];
        
        [manager GET:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

            NSLog(@"JSON: %@", userDict);
            NSMutableArray *recordarr=[[userDict objectForKey:@"Android"] objectForKey:@"records"];
            NSDictionary *dict=[recordarr objectAtIndex:0];
            {
                if (![[dict objectForKey:@"mobile_id_c"] isEqualToString:@""]||!([dict objectForKey:@"mobile_id_c"]==nil)) {
                 //   [self.navigationController popViewControllerAnimated:YES];
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Re-visited Sucessfully"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self checkvisit];
                }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to update"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            [ indicator stopAnimating];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [indicator stopAnimating];
        }];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
    if (pickerView == assignpicker)
    {
        rowItem = [assignsalesarr objectAtIndex: row];
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
         projectidstr=[NSString stringWithFormat:@"%@",[prosjectidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==assignpicker)
    {
        assignstr=[[NSString alloc]init];
        assignstr=[NSString stringWithFormat:@"%@",[assignsalesarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
    if (pickerView == assignpicker)
    {
        return [assignsalesarr objectAtIndex:row];
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==mobiletxt)
    {
        if(textField.text.length >9 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    assignpicker.hidden=YES;
    assigntoolbar.hidden=YES;
    [mobiletxt resignFirstResponder];
    
    projectarr=[[NSMutableArray alloc]init];
    prosjectidarr=[[NSMutableArray alloc]init];

    if (textField ==projectstxt) {
        for (int i=0; i<appDelegate.projectarr.count; i++) {
            NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
            [projectarr addObject:[dict objectForKey:@"name"]];
            [prosjectidarr addObject:[dict objectForKey:@"id"]];
        }
//        
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
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed4)];
//        [leftButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
//        [rightButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                   forState:UIControlStateNormal];
        
        projectoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:projectoolbar];
        
        projectoolbar.hidden=NO;
        [projectstxt resignFirstResponder];
        return NO;
    }
//    if (textField ==Assigntxt) {
//        assignsalesarr=[[NSMutableArray alloc]initWithObjects:@"Administrator",@"Pravin Kumar",@"Sagar",@"Ankita Sharma", nil];
//        assignpicker = [[UIPickerView alloc] init];
//        [assignpicker setDataSource: self];
//        [assignpicker setDelegate: self];
//        assignpicker.backgroundColor = [UIColor whiteColor];
//        [assignpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
//        projectpicker.showsSelectionIndicator = YES;
//        [projectpicker selectRow:0 inComponent:0 animated:YES];
//        [self.view addSubview: assignpicker];
//        assignpicker.hidden=NO;
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//            assigntoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
//        }
//        else{
//            assigntoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
//        }
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed2)];
//      
//        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
//       
//        
//        assigntoolbar.items = @[rightButton,flex,leftButton];
//        [self.view addSubview:assigntoolbar];
//        
//        assigntoolbar.hidden=NO;
//        [Assigntxt resignFirstResponder];
//        return NO;
//    }
    
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
    if ([pickerView isEqual: assignpicker]) {
        return [assignsalesarr count];
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
           projectidstr=[prosjectidarr objectAtIndex:0];
        }
    }
    else{
        projectstxt.text=projectstr;
    }
}
-(IBAction)doneBtnPressed2{
    assignpicker.hidden=YES;
    assigntoolbar.hidden=YES;
    
    if ([assignstr isEqualToString:@""] || assignstr==nil) {
        if (assignsalesarr.count>0) {
            Assigntxt.text=[assignsalesarr objectAtIndex:0];
        }
    }
    else{
        Assigntxt.text=assignstr;
    }
}
-(IBAction)cancelBtnpress{
    
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    assignpicker.hidden=YES;
    assigntoolbar.hidden=YES;
}
-(void)doneWithNumberPad{
    [mobiletxt resignFirstResponder];
}
-(void)add
{
    AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
    mainvc.comefrom=@"frontoffice";
    mainvc.projectstr=projectstxt.text;
    mainvc.indstr=projectidstr;
    mainvc.mobilestr=mobiletxt.text;
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)back
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Xrbia"
//                                                    message:@"Do you want to logout?"
//                                                   delegate:self
//                                          cancelButtonTitle:@"Cancel"
//                                          otherButtonTitles:@"Yes", nil];
//    [alert show];
    
    SalesHeadViewController *mainvc=[[SalesHeadViewController alloc] initWithNibName:@"SalesHeadViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
    
   // [self.navigationController popViewControllerAnimated:YES];

}
//- (void)alertView:(UIAlertView *)alertView
//clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == [alertView cancelButtonIndex]){
//        //cancel clicked ...do your action
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
