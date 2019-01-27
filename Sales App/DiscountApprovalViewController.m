//
//  DiscountApprovalViewController.m
//  Sales App
//
//  Created by Infinitum on 15/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "DiscountApprovalViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface DiscountApprovalViewController ()

@end
@implementation DiscountApprovalViewController
@synthesize dict,comestr,projectxt,fromunittxt,tounitxt,toprojectxt,disamountxt,indicator,projectarr,projectstr,projectidarr,projectidstr,projectoolbar,projectpicker,appDelegate,reasontxt,projectipadr,ipprojectidstr,unitdetails,scrollview,toschemetxt,shiftingreasontxt,schemearr,schemestr,schemepicker,schemetoolbar,agrvaluearr,discremark,buildingarr,buildingstr,buildingtxt,buildingpicker,buildingtoolbar,buildingidstr,floortxt,floorstr,flooidstr,floornamearray,flooridarr,floorpicker,floortoolbar,floorarr,unitstr,unitoolbar,unitidarr,unitpicker,numberToolbarzip,tableViewHome,listarr,revisiedagrlbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    agrvaluearr=[[NSMutableArray alloc]init];
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Discount Approval";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Add request", @"All request", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.11, screenRect.size.width*0.80,screenRect.size.height*0.05);
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    
    CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.17,screenRect.size.width,screenRect.size.height*0.83);
    scrollview = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
    scrollview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    scrollview.delegate = self;
    scrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollview];
    
    int  hig=screenRect.size.height*0.01;
    
        projectxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        projectxt.textAlignment=NSTextAlignmentLeft;
        projectxt.delegate = self;
        projectxt.textColor=[UIColor blackColor];
        [projectxt setBackgroundColor:[UIColor clearColor]];
        projectxt.leftViewMode = UITextFieldViewModeAlways;
        [projectxt setKeyboardType:UIKeyboardTypeEmailAddress];
        projectxt.returnKeyType=UIReturnKeyDone;
        projectxt.selectedLineColor = [UIColor redColor];
        projectxt.selectedPlaceHolderColor = [UIColor redColor];
        projectxt.placeHolderColor = [UIColor grayColor];
        projectxt.placeholder=@"Projects";
        projectxt.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:projectxt];
        
        hig=hig+screenRect.size.height*0.10;
        
        buildingtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        buildingtxt.textAlignment=NSTextAlignmentLeft;
        buildingtxt.delegate = self;
        buildingtxt.textColor=[UIColor blackColor];
        [buildingtxt setBackgroundColor:[UIColor clearColor]];
        buildingtxt.leftViewMode = UITextFieldViewModeAlways;
        [buildingtxt setKeyboardType:UIKeyboardTypeEmailAddress];
        buildingtxt.returnKeyType=UIReturnKeyDone;
        buildingtxt.selectedLineColor = [UIColor redColor];
        buildingtxt.selectedPlaceHolderColor = [UIColor redColor];
        buildingtxt.placeHolderColor = [UIColor grayColor];
        buildingtxt.placeholder=@"Buildings";
        buildingtxt.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:buildingtxt];
        
        hig=hig+screenRect.size.height*0.10;
        
        floortxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        floortxt.textAlignment=NSTextAlignmentLeft;
        floortxt.delegate = self;
        floortxt.textColor=[UIColor blackColor];
        [floortxt setBackgroundColor:[UIColor clearColor]];
        floortxt.leftViewMode = UITextFieldViewModeAlways;
        [floortxt setKeyboardType:UIKeyboardTypeEmailAddress];
        floortxt.returnKeyType=UIReturnKeyDone;
        floortxt.selectedLineColor = [UIColor redColor];
        floortxt.selectedPlaceHolderColor = [UIColor redColor];
        floortxt.placeHolderColor = [UIColor grayColor];
        floortxt.placeholder=@"Select Floor";
        floortxt.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:floortxt];
        
        hig=hig+screenRect.size.height*0.10;
        
        tounitxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        tounitxt.textAlignment=NSTextAlignmentLeft;
        tounitxt.delegate = self;
        tounitxt.textColor=[UIColor blackColor];
        [tounitxt setBackgroundColor:[UIColor clearColor]];
        tounitxt.leftViewMode = UITextFieldViewModeAlways;
        [tounitxt setKeyboardType:UIKeyboardTypeEmailAddress];
        tounitxt.returnKeyType=UIReturnKeyDone;
        tounitxt.selectedLineColor = [UIColor redColor];
        tounitxt.selectedPlaceHolderColor = [UIColor redColor];
        tounitxt.placeHolderColor = [UIColor grayColor];
        tounitxt.placeholder=@"To Unit";
        tounitxt.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:tounitxt];
        
        hig=hig+screenRect.size.height*0.10;
        
        toschemetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        toschemetxt.textAlignment=NSTextAlignmentLeft;
        toschemetxt.delegate = self;
        toschemetxt.textColor=[UIColor blackColor];
        [toschemetxt setBackgroundColor:[UIColor clearColor]];
        toschemetxt.leftViewMode = UITextFieldViewModeAlways;
        [toschemetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        toschemetxt.returnKeyType=UIReturnKeyDone;
        toschemetxt.selectedLineColor = [UIColor redColor];
        toschemetxt.selectedPlaceHolderColor = [UIColor redColor];
        toschemetxt.placeHolderColor = [UIColor grayColor];
        toschemetxt.placeholder=@"To Scheme";
        toschemetxt.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:toschemetxt];
        
        hig=hig+screenRect.size.height*0.10;
    
        disamountxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        disamountxt.textAlignment=NSTextAlignmentLeft;
        disamountxt.delegate = self;
        disamountxt.textColor=[UIColor blackColor];
        [disamountxt setBackgroundColor:[UIColor clearColor]];
        disamountxt.leftViewMode = UITextFieldViewModeAlways;
        [disamountxt setKeyboardType:UIKeyboardTypeEmailAddress];
        disamountxt.returnKeyType=UIReturnKeyDone;
        disamountxt.selectedLineColor = [UIColor redColor];
        disamountxt.selectedPlaceHolderColor = [UIColor redColor];
        disamountxt.placeHolderColor = [UIColor grayColor];
        disamountxt.placeholder=@"Discount amount";
        numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbarzip sizeToFit];
        disamountxt.inputAccessoryView = numberToolbarzip;
        disamountxt.leftViewMode = UITextFieldViewModeAlways;
        disamountxt.keyboardType = UIKeyboardTypeDecimalPad;
        disamountxt.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:disamountxt];

        hig=hig+screenRect.size.height*0.10;
        discremark = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
        discremark.textAlignment=NSTextAlignmentLeft;
        discremark.delegate = self;
        discremark.textColor=[UIColor blackColor];
        [discremark setBackgroundColor:[UIColor clearColor]];
        discremark.leftViewMode = UITextFieldViewModeAlways;
        [discremark setKeyboardType:UIKeyboardTypeEmailAddress];
        discremark.returnKeyType=UIReturnKeyDone;
        discremark.selectedLineColor = [UIColor redColor];
        discremark.selectedPlaceHolderColor = [UIColor redColor];
        discremark.placeHolderColor = [UIColor grayColor];
        discremark.placeholder=@"Discount remark";
        discremark.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:discremark];
        
        hig=hig+screenRect.size.height*0.10;
    
        _agrmentvaluelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.10,hig,screenRect.size.width*.85,screenRect.size.height*0.05)];
        _agrmentvaluelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
        _agrmentvaluelbl.text=[NSString stringWithFormat:@"To agr. Value:"];
        [_agrmentvaluelbl setTextColor:[UIColor blackColor]];
        _agrmentvaluelbl.textAlignment = NSTextAlignmentLeft;
        [scrollview addSubview:_agrmentvaluelbl];
   
    hig=hig+screenRect.size.height*0.05;
    
    revisiedagrlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.10,hig,screenRect.size.width*.85,screenRect.size.height*0.05)];
    revisiedagrlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
    revisiedagrlbl.text=[NSString stringWithFormat:@"Revised agr. value:"];
    [revisiedagrlbl setTextColor:[UIColor blackColor]];
    revisiedagrlbl.textAlignment = NSTextAlignmentLeft;
    [scrollview addSubview:revisiedagrlbl];
    
    hig=hig+screenRect.size.height*0.07;
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.06)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.045]];
    [Createvoucherbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn setTitle:@"Send Request" forState:UIControlStateNormal];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#4861AC"]] ;
    [scrollview addSubview:Createvoucherbtn];
    
    hig=hig+screenRect.size.height*0.10;
    
    scrollview.contentSize=CGSizeMake(screenRect.size.width,hig);
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.17, screenRect.size.width,screenRect.size.height*.83)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewHome.scrollEnabled=YES;
    [self.view addSubview:tableViewHome];
    tableViewHome.hidden=YES;
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict=[listarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.18)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.0,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Project: %@",[dict objectForKey:@"proj_name"]];
    
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  mobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.04,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    mobilelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    mobilelbl.textAlignment = NSTextAlignmentLeft;
    mobilelbl.text =[NSString stringWithFormat:@"Date: %@",[dict objectForKey:@"requested_date"]];
    mobilelbl.backgroundColor = [UIColor clearColor];
    mobilelbl.textColor=[UIColor blackColor];
    mobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    mobilelbl.numberOfLines = 0;
    [headerView addSubview:mobilelbl];
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.075,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    datelbl.textAlignment = NSTextAlignmentLeft;
    datelbl.text =[NSString stringWithFormat:@"Unit No: %@",[dict objectForKey:@"unit_no"]];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    UILabel*  amountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.11,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    amountlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    amountlbl.textAlignment = NSTextAlignmentLeft;
    amountlbl.text =[NSString stringWithFormat:@"Discount Amount: %@",[dict objectForKey:@"discount_amt"]];
    amountlbl.backgroundColor = [UIColor clearColor];
    amountlbl.textColor=[UIColor blackColor];
    amountlbl.lineBreakMode = NSLineBreakByWordWrapping;
    amountlbl.numberOfLines = 0;
    [headerView addSubview:amountlbl];
    
    
    UILabel*  statuslbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.145,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    statuslbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    statuslbl.textAlignment = NSTextAlignmentLeft;
    statuslbl.text =[NSString stringWithFormat:@"Status: %@",[dict objectForKey:@"status"]];
    statuslbl.backgroundColor = [UIColor clearColor];
    statuslbl.textColor=[UIColor blackColor];
    statuslbl.lineBreakMode = NSLineBreakByWordWrapping;
    statuslbl.numberOfLines = 0;
    [headerView addSubview:statuslbl];
    
    [cell.contentView addSubview:headerView];
    
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
    return screenRect.size.height*0.19;
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        tableViewHome.hidden=YES;
        scrollview.hidden=NO;
        //backgroundview.hidden=NO;
    }
    if(segment.selectedSegmentIndex == 1)
    {
        // code for the first button
        tableViewHome.hidden=NO;
        scrollview.hidden=YES;
        [self getlist];
        
        //  backgroundview.hidden=YES;
        projectpicker.hidden=YES;
        projectoolbar.hidden=YES;
        schemetoolbar.hidden=YES;
        schemepicker.hidden=YES;
        buildingtoolbar.hidden=YES;
        buildingpicker.hidden=YES;
        floortoolbar.hidden=YES;
        floorpicker.hidden=YES;
        unitpicker.hidden=YES;
        unitoolbar.hidden=YES;
        [tounitxt resignFirstResponder];
    }
}
-(void)getlist
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getBookings"  forKey:@"requestType"];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
   
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getdiscountlist.php?",[prefs objectForKey:@"Link"]];
    
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]    length:[responseObject length] encoding: NSUTF8StringEncoding];
        //NSLog(@"content %@",content);
        NSLog(@"JSON: %@", userDict);
        listarr=[[userDict objectForKey:@"Android"]objectForKey:@"bookings"];
        if (listarr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [tableViewHome reloadData];
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)submit
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    if (![projectxt.text isEqualToString:@""]) {
        if (![buildingtxt.text isEqualToString:@""]) {
            if (![floortxt.text isEqualToString:@""]) {
                if (![tounitxt.text isEqualToString:@""]) {
                    if (![toschemetxt.text isEqualToString:@""]) {
                          if (![disamountxt.text isEqualToString:@""])
                          {
                        NSLocale *locale = [NSLocale currentLocale];
                        NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
                        NSString *result = [_agrvalustr stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
                        
                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                        [params setObject:result  forKey:@"agvalue"];
                        [params setObject:@"saveDiscountvalue"  forKey:@"requestType"];
                        [params setObject:[prefs objectForKey:@"user_name"]  forKey:@"requestedby"];
                        [params setObject:projectxt.text  forKey:@"projname"];
                        [params setObject:tounitxt.text  forKey:@"unitno"];
                        [params setObject: disamountxt.text forKey:@"discount_amt"];
                        [params setObject:@"" forKey:@"discount_per"];
                        [params setObject:datestr  forKey:@"requestdate"];
                        [params setObject:discremark.text  forKey:@"remarks"];

                        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savediscountapproval.php?",[prefs objectForKey:@"Link"]];
                        
                        [indicator startAnimating];
                        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]    length:[responseObject length] encoding: NSUTF8StringEncoding];
                            NSLog(@"content %@",content);
                            //NSLog(@"JSON: %@", userDict);
                            int status=[[userDict objectForKey:@"status"]intValue];
                            if (status==1) {
                               NSString* _pkidstr=[userDict objectForKey:@"id"];
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"request has been sent for approval"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                                [self dismissViewControllerAnimated:YES completion:nil];

                            }
                            else
                            {
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Discount amount is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"scheme is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"unit is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"floor is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Building is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"project is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)backbtn{
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getbuilding
{
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"get_buildings"  forKey:@"requestType"];
        [params setObject:projectidstr forKey:@"projectId"];
        
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            buildingarr=[[NSMutableArray alloc]init];
            NSLog(@"JSON: %@", userDict);
            NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
            buildingarr=[dic objectForKey:@"buildings"];
            
            [indicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)getflowerunit:(NSString*)str
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"get_floors_units"  forKey:@"requestType"];
    [params setObject:str  forKey:@"buildingId"];
    [params setObject:projectidstr forKey:@"projectId"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        floorarr=[[NSMutableArray alloc]init];
        floorarr=[dic objectForKey:@"inventory_data"];
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)getunit
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"get_flats"  forKey:@"requestType"];
    [params setObject:buildingidstr  forKey:@"buildingId"];
    [params setObject:projectidstr forKey:@"projectId"];
    [params setObject:floortxt.text forKey:@"unitNumber"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        _unitsarr=[[NSMutableArray alloc]init];
        _unitsarr=[dic objectForKey:@"units"];
        [indicator stopAnimating];
        
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              [indicator stopAnimating];
              UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
              [alert show];
          }];
}
-(void)getscheme
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"get_flat_details"  forKey:@"requestType"];
    [params setObject:buildingidstr  forKey:@"buildingId"];
    [params setObject:tounitxt.text  forKey:@"unitCode"];
    [params setObject:projectidstr forKey:@"projectId"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        unitdetails=[[userDict objectForKey:@"Android"] objectForKey:@"flat_details"];
        _agrvalustr=[[[userDict objectForKey:@"Android"]objectForKey:@"flat_details"]objectForKey:@"agreement_value"];
        _agrmentvaluelbl.text=[NSString stringWithFormat:@"To agr. value:%@",_agrvalustr];
        NSMutableArray *arr=[[[userDict objectForKey:@"Android"]objectForKey:@"flat_details"]objectForKey:@"schemes"];\
        if (arr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            schemearr=[[NSMutableArray alloc]init];
            agrvaluearr=[[NSMutableArray alloc]init];
            
            for (int i=0; i<arr.count; i++) {
                [schemearr addObject:[[arr objectAtIndex:i]objectForKey:@"name"]];
                [agrvaluearr addObject:[[arr objectAtIndex:i]objectForKey:@"av"]];
            }
        }
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)submit:(UIButton*)btn
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];
    
    if ([btn.titleLabel.text isEqualToString:@"Shift"]) {
        
        if (![projectxt.text isEqualToString:@""]) {
            if (![buildingtxt.text isEqualToString:@""]) {
                if (![floortxt.text isEqualToString:@""]) {
                    if (![tounitxt.text isEqualToString:@""]) {
                        if (![toschemetxt.text isEqualToString:@""]) {
                            if (![shiftingreasontxt.text isEqualToString:@""]) {
                                
                            }
                            else
                            {
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"shiifting reason is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                        }
                        else
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"scheme is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"unit is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"floor is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Building is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"project is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        
        [params setObject:@"request_shifting"  forKey:@"requestType"];
        [params setObject:[dict objectForKey:@"id"] forKey:@"crm_booking_id"];
        [params setObject:[dict objectForKey:@"display_booking_id"]  forKey:@"sap_booking_id"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"initiated_by_c"];
        [params setObject:shiftingreasontxt.text  forKey:@"shifting_reason_c"];
        [params setObject:@""  forKey:@"cancelled_amount_c"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"crm_user_id"];
        [params setObject:[dict objectForKey:@"booking_date"]  forKey:@"booking_date"];
        [params setObject:[dict objectForKey:@"emp_code"]  forKey:@"employee_name"];
        [params setObject:[dict objectForKey:@"cutomer_name"]  forKey:@"customer_name"];
        [params setObject:[dict objectForKey:@"source"] forKey:@"source"];
        [params setObject:@""forKey:@"booking_remark"];
        [params setObject:[dict objectForKey:@"paid_amt"]forKey:@"paid_amount"];
        // [params setObject:[dict objectForKey:@"agvalue"]forKey:@"agreement_value"];
        [params setObject:[dict objectForKey:@"agvalue"]forKey:@"from_agreement_value"];
        [params setObject:_agrvalustr forKey:@"to_agreement_value"];
        [params setObject:disamountxt.text forKey:@"to_discount"];
        [params setObject:discremark.text forKey:@"to_discount_remark"];
        [params setObject:toschemetxt.text forKey:@"to_scheme_name"];
        [params setObject:[dict objectForKey:@"crm_proj_id"] forKey:@"from_crm_project_id"];
        [params setObject:[dict objectForKey:@"proj_id"] forKey:@"from_project_id"];
        [params setObject:[dict objectForKey:@"flat_no"] forKey:@"from_unit_no"];
        [params setObject:projectidstr forKey:@"to_crm_project_id"];
        [params setObject:ipprojectidstr forKey:@"to_project_id"];
        [params setObject:tounitxt.text forKey:@"to_unit_no"];
        [params setObject:toprojectxt.text forKey:@"from_project_name"];
        [params setObject:projectxt.text forKey:@"to_project_name"];
        [params setObject:[unitdetails objectForKey:@"flat_type"] forKey:@"to_flat_type"];
        [params setObject:[unitdetails objectForKey:@"total_amount_cost"] forKey:@"to_total_amount_cost"];
        //
        //
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@saveshifting.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                          length:[responseObject length] encoding: NSUTF8StringEncoding];
            NSLog(@"content %@",content);
            int status=[[userDict objectForKey:@"status"]intValue];
            if (status==1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
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
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        
        [params setObject:[dict objectForKey:@"id"] forKey:@"crm_booking_id"];
        [params setObject:[dict objectForKey:@"display_booking_id"]  forKey:@"sap_booking_id"];
        [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"initiated_by"];
        [params setObject: @"" forKey:@"approved_by_c"];
        [params setObject:reasontxt.text forKey:@"cancelled_reason"];
        [params setObject:@""forKey:@"cancelled_amount"];
        [params setObject:[dict objectForKey:@"booking_date"]  forKey:@"booking_date"];
        [params setObject:[dict objectForKey:@"emp_code"]  forKey:@"employee_name"];
        [params setObject:[dict objectForKey:@"cutomer_name"]  forKey:@"customer_name"];
        [params setObject:@""forKey:@"mobile_no"];
        [params setObject:[dict objectForKey:@"source"] forKey:@"source"];
        [params setObject:@""forKey:@"booking_remark"];
        [params setObject:[dict objectForKey:@"paid_amt"]forKey:@"paid_amount"];
        [params setObject:[dict objectForKey:@"agvalue"]forKey:@"agreement_value"];
        [params setObject:@""  forKey:@"inventory_id"];
        [params setObject:[dict objectForKey:@"crm_proj_id"] forKey:@"crm_project_id"];
        [params setObject:[dict objectForKey:@"proj_id"] forKey:@"ip_project_id"];
        [params setObject:[dict objectForKey:@"flat_no"] forKey:@"unit_no"];
        [params setObject:@"request_cancel"forKey:@"requestType"];
        [params setObject:[dict objectForKey:@"project_name"] forKey:@"project_name"];
        
        NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecancelation.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
                                                          length:[responseObject length] encoding: NSUTF8StringEncoding];
            NSLog(@"content %@",content);
            //  NSLog(@"content %@",userDict);
            
            int status=[[userDict objectForKey:@"status"]intValue];
            if (status==1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [indicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
    if (pickerView == schemepicker)
    {
        rowItem = [schemearr objectAtIndex: row];
    }
    if (pickerView == buildingpicker)
    {
        rowItem = [_sitenamearr objectAtIndex: row];
    }
    if (pickerView == floorpicker)
    {
        rowItem = [floornamearray objectAtIndex: row];
    }
    if (pickerView == unitpicker)
    {
        rowItem = [unitidarr objectAtIndex: row];
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
        projectidstr=[[NSString alloc]init];
        projectidstr=[NSString stringWithFormat:@"%@",[projectidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        ipprojectidstr=[[NSString alloc]init];
        ipprojectidstr=[NSString stringWithFormat:@"%@",[projectipadr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==schemepicker)
    {
        schemestr=[[NSString alloc]init];
        schemestr=[NSString stringWithFormat:@"%@",[schemearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        _agrvalustr=[[NSString alloc]init];
        _agrvalustr=[NSString stringWithFormat:@"%@",[agrvaluearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==buildingpicker)
    {
        buildingstr=[[NSString alloc]init];
        buildingstr=[NSString stringWithFormat:@"%@",[_sitenamearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        buildingidstr=[[NSString alloc]init];
        buildingidstr=[NSString stringWithFormat:@"%@",[_siteidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==floorpicker)
    {
        floorstr=[[NSString alloc]init];
        floorstr=[NSString stringWithFormat:@"%@",[floornamearray objectAtIndex:[pickerView selectedRowInComponent:0]]];
        
    }
    if (pickerView ==unitpicker)
    {
        unitstr=[[NSString alloc]init];
        unitstr=[NSString stringWithFormat:@"%@",[unitidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
    if (pickerView == schemepicker)
    {
        return [schemearr objectAtIndex:row];
    }
    if (pickerView == buildingpicker)
    {
        return [_sitenamearr objectAtIndex:row];
    }
    if (pickerView == floorpicker)
    {
        return [floornamearray objectAtIndex:row];
    }
    if (pickerView == unitpicker)
    {
        return [unitidarr objectAtIndex:row];
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
    
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    schemetoolbar.hidden=YES;
    schemepicker.hidden=YES;
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    floortoolbar.hidden=YES;
    floorpicker.hidden=YES;
    unitpicker.hidden=YES;
    unitoolbar.hidden=YES;
    [tounitxt resignFirstResponder];
    if (textField ==projectxt) {
        projectidarr=[[NSMutableArray alloc]init];
        projectarr=[[NSMutableArray alloc]init];
        projectipadr=[[NSMutableArray alloc]init];
        
        for (int i=0; i<appDelegate.projectarr.count; i++) {
            NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
            [projectarr addObject:[dict objectForKey:@"name"]];
            [projectidarr addObject:[dict objectForKey:@"id"]];
            [projectipadr addObject:[dict objectForKey:@"sap_project_id"]];
        }
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
        [projectxt resignFirstResponder];
        return NO;
    }
    
    if (textField ==toschemetxt) {
        
        schemepicker = [[UIPickerView alloc] init];
        [schemepicker setDataSource: self];
        [schemepicker setDelegate: self];
        schemepicker.backgroundColor = [UIColor whiteColor];
        [schemepicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        schemepicker.showsSelectionIndicator = YES;
        [schemepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: schemepicker];
        schemepicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            schemetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            schemetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [schemetoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        schemetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:schemetoolbar];
        
        schemetoolbar.hidden=NO;
        [toschemetxt resignFirstResponder];
        return NO;
    }
    if (textField ==buildingtxt) {
        if (buildingarr.count==0) {
            buildingarr=nil;
            _siteidarr=nil;
            _siteidarr=nil;
        }
        else
        {
            _sitenamearr=[[NSMutableArray alloc]init];
            _siteidarr=[[NSMutableArray alloc]init];
            for (int i=0; i<buildingarr.count; i++) {
                NSDictionary* dict=[buildingarr objectAtIndex:i];
                [_sitenamearr addObject:[dict objectForKey:@"name"]];
                [_siteidarr addObject:[dict objectForKey:@"id"]];
            }
        }
        buildingpicker = [[UIPickerView alloc] init];
        [buildingpicker setDataSource: self];
        [buildingpicker setDelegate: self];
        buildingpicker.backgroundColor = [UIColor whiteColor];
        [buildingpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        buildingpicker.showsSelectionIndicator = YES;
        [buildingpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: buildingpicker];
        buildingpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            buildingtoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            buildingtoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [buildingtoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed2)];
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
        
        buildingtoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:buildingtoolbar];
        
        buildingtoolbar.hidden=NO;
        [buildingtxt resignFirstResponder];
        return NO;
    }
    if (textField ==floortxt) {
        floornamearray=[[NSMutableArray alloc]init];
        if (floorarr.count==0) {
            floornamearray=nil;
        }
        for (int i=0; i<floorarr.count; i++) {
            NSMutableDictionary *dict=[floorarr objectAtIndex:i];
            [floornamearray addObject: [dict objectForKey:@"floor"]];
        }
        floorpicker = [[UIPickerView alloc] init];
        [floorpicker setDataSource: self];
        [floorpicker setDelegate: self];
        floorpicker.backgroundColor = [UIColor whiteColor];
        [floorpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        floorpicker.showsSelectionIndicator = YES;
        [floorpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: floorpicker];
        floorpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            floortoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            floortoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [floortoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed1)];
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
        
        floortoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:floortoolbar];
        
        floortoolbar.hidden=NO;
        [floortxt resignFirstResponder];
        return NO;
    }
    if (textField ==tounitxt) {
        unitidarr=[[NSMutableArray alloc]init];
        if (_unitsarr.count==0) {
            unitidarr=nil;
        }
        for (int i=0; i<_unitsarr.count; i++) {
            NSMutableDictionary *dict=[_unitsarr objectAtIndex:i];
            [unitidarr addObject: [dict objectForKey:@"id"]];
        }
        unitpicker = [[UIPickerView alloc] init];
        [unitpicker setDataSource: self];
        [unitpicker setDelegate: self];
        unitpicker.backgroundColor = [UIColor whiteColor];
        [unitpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        unitpicker.showsSelectionIndicator = YES;
        [unitpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: unitpicker];
        unitpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            unitoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            unitoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [unitoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed0)];
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
        
        unitoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:unitoolbar];
        
        unitoolbar.hidden=NO;
        [tounitxt resignFirstResponder];
        return NO;
    }
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
    if ([pickerView isEqual: schemepicker]) {
        return [schemearr count];
    }
    if ([pickerView isEqual: buildingpicker]) {
        return [_sitenamearr count];
    }
    if ([pickerView isEqual:floorpicker]) {
        return [floornamearray count];
    }
    if ([pickerView isEqual:unitpicker]) {
        return [unitidarr count];
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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    scrollview.frame = CGRectMake(scrollview.frame.origin.x,
                                  scrollview.frame.origin.y,
                                  scrollview.frame.size.width,
                                  scrollview.frame.size.height + 250 );
    if (textField==tounitxt) {
    }
    if (textField==disamountxt) {
        NSLocale *locale = [NSLocale currentLocale];
        NSString *thousandSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
        NSString *result = [_agrvalustr stringByReplacingOccurrencesOfString:thousandSeparator withString:@""];
        NSString * calculatedstr=[NSString stringWithFormat:@"%0.02f",[result floatValue]-[disamountxt.text floatValue]];
        if ([calculatedstr floatValue]<=0) {
            disamountxt.text=@"";
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Discount amount is reaching max limit" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            revisiedagrlbl.text=[NSString stringWithFormat:@"Revised agr. value:%@",_agrvalustr];
        }
        else
        {
            revisiedagrlbl.text=[NSString stringWithFormat:@"Revised agr. value:%@",calculatedstr];
        }
    }
}
-(void)doneWithNumberPad{
    [disamountxt resignFirstResponder];
}
-(IBAction)doneBtnPressed0{
    unitpicker.hidden=YES;
    unitoolbar.hidden=YES;
    
    if ([unitstr isEqualToString:@""] || unitstr==nil) {
        if (floornamearray.count>0) {
            tounitxt.text=[unitidarr objectAtIndex:0];
            unitstr=[unitidarr objectAtIndex:0];
        }
    }
    else{
        tounitxt.text=unitstr;
    }
    schemestr=@"";
    toschemetxt.text=@"";
    schemearr=nil;
    agrvaluearr=nil;
    [self getscheme];
}
-(IBAction)doneBtnPressed1{
    floortoolbar.hidden=YES;
    floorpicker.hidden=YES;
    
    if ([floorstr isEqualToString:@""] || floorstr==nil) {
        if (floornamearray.count>0) {
            floortxt.text=[floornamearray objectAtIndex:0];
            floorstr=[floornamearray objectAtIndex:0];
        }
    }
    else{
        floortxt.text=floorstr;
    }
    unitstr=@"";
    schemestr=@"";
    _unitsarr=nil;
    schemearr=nil;
    agrvaluearr=nil;
    
    tounitxt.text=@"";
    toschemetxt.text=@"";
    [self getunit];
}
-(IBAction)doneBtnPressed2{
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    
    if ([buildingstr isEqualToString:@""] || buildingstr==nil) {
        if (_sitenamearr.count>0) {
            buildingtxt.text=[_sitenamearr objectAtIndex:0];
            buildingidstr=[_siteidarr objectAtIndex:0];
        }
    }
    else{
        buildingtxt.text=buildingstr;
    }
   
    floorstr=@"";
    unitstr=@"";
    schemestr=@"";
    
    floorarr=nil;
    _unitsarr=nil;
    schemearr=nil;
    agrvaluearr=nil;
    
    floortxt.text=@"";
    tounitxt.text=@"";
    toschemetxt.text=@"";
    [self getflowerunit:buildingidstr];
}
-(IBAction)doneBtnPressed4{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    
    if ([projectstr isEqualToString:@""] || projectstr==nil) {
        if (projectarr.count>0) {
            projectxt.text=[projectarr objectAtIndex:0];
            projectidstr=[projectidarr objectAtIndex:0];
            ipprojectidstr =[projectipadr objectAtIndex:0];
        }
    }
    else{
        projectxt.text=projectstr;
    }
    buildingidstr=@"";
    buildingstr=@"";
    floorstr=@"";
    unitstr=@"";
    schemestr=@"";
    buildingarr=nil;
    floorarr=nil;
    _unitsarr=nil;
    schemearr=nil;
    agrvaluearr=nil;
    
    buildingtxt.text=@"";
    floortxt.text=@"";
    tounitxt.text=@"";
    toschemetxt.text=@"";
    [self getbuilding];
}
-(IBAction)doneBtnPressed3{
    schemetoolbar.hidden=YES;
    schemepicker.hidden=YES;
    
    if ([schemestr isEqualToString:@""] || schemestr==nil) {
        if (schemearr.count>0) {
            toschemetxt.text=[schemearr objectAtIndex:0];
            _agrvalustr=[agrvaluearr objectAtIndex:0];
        }
    }
    else{
        toschemetxt.text=schemestr;
    }
    _agrmentvaluelbl.text=[NSString stringWithFormat:@"To agr. value:%@",_agrvalustr];
    revisiedagrlbl.text=[NSString stringWithFormat:@"Revised agr. value:%@",_agrvalustr];
}
-(IBAction)cancelBtnpress{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    schemetoolbar.hidden=YES;
    schemepicker.hidden=YES;
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    floortoolbar.hidden=YES;
    floorpicker.hidden=YES;
    unitpicker.hidden=YES;
    unitoolbar.hidden=YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
    
    scrollview.frame = CGRectMake(scrollview.frame.origin.x,
                                  scrollview.frame.origin.y,
                                  scrollview.frame.size.width,
                                  scrollview.frame.size.height - 250 );
    //resize
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
