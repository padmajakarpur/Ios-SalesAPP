//
//  SalesHeadHandOverViewController.m
//  Sales App
//
//  Created by Infinitum on 16/05/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "SalesHeadHandOverViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface SalesHeadHandOverViewController ()<UITextFieldAutoSuggestionDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *weeks;

@end
@implementation SalesHeadHandOverViewController
@synthesize tableViewHome,indicator,curtemtext,handovertxt,assignarr,assignidarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];;
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
        horizontallbl.text=@"Hand Over";

    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UILabel *curentlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*0.10,screenRect.size.width*.45,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    curentlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.040];
    [curentlbl setTextColor:[UIColor blackColor]];
    curentlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:curentlbl];
    curentlbl.lineBreakMode = NSLineBreakByWordWrapping;
    curentlbl.numberOfLines = 0;
    curentlbl.text=@"Currenty\nresponsible";
    
    UILabel *handoverlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.55,screenRect.size.height*0.11,screenRect.size.width*.4,screenRect.size.height*0.05)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    handoverlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.040];
    [handoverlbl setTextColor:[UIColor blackColor]];
    handoverlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:handoverlbl];
    handoverlbl.text=@"Hand Over to";
    
    curtemtext = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*0.17,screenRect.size.width*.45,screenRect.size.height*0.06)];
    curtemtext.textAlignment=NSTextAlignmentLeft;
    curtemtext.delegate = self;
    [curtemtext setBackgroundColor:[UIColor clearColor]];
    curtemtext.leftViewMode = UITextFieldViewModeAlways;
    curtemtext.returnKeyType=UIReturnKeyDone;
    CALayer *bottomBorders3 = [CALayer layer];
    bottomBorders3.frame = CGRectMake(0.0f, curtemtext.frame.size.height - 5, curtemtext.frame.size.width, 1.0f);
    bottomBorders3.backgroundColor = [UIColor grayColor].CGColor;
    [curtemtext.layer addSublayer:bottomBorders3];
    curtemtext.placeholder=@"Select Person";
    curtemtext.font = [UIFont systemFontOfSize:14];
    curtemtext.showImmediately =true;
    [curtemtext observeTextFieldChanges];
    curtemtext.fieldIdentifier=@"salesID";
    [self.view addSubview:curtemtext];
      curtemtext.autoSuggestionDataSource = self;

    handovertxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*.52,screenRect.size.height*0.17,screenRect.size.width*.45,screenRect.size.height*0.06)];
    handovertxt.textAlignment=NSTextAlignmentLeft;
    handovertxt.delegate = self;
    [handovertxt setBackgroundColor:[UIColor clearColor]];
    handovertxt.leftViewMode = UITextFieldViewModeAlways;
    handovertxt.returnKeyType=UIReturnKeyDone;
    CALayer *bottomBorders2 = [CALayer layer];
    bottomBorders2.frame = CGRectMake(0.0f, curtemtext.frame.size.height - 5, curtemtext.frame.size.width, 1.0f);
    bottomBorders2.backgroundColor = [UIColor grayColor].CGColor;
    [handovertxt.layer addSublayer:bottomBorders2];
    handovertxt.placeholder=@"Select Person";
    handovertxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:handovertxt];
    handovertxt.showImmediately =true;
    [handovertxt observeTextFieldChanges];
    handovertxt.fieldIdentifier=@"salesIDTo";
    [self.view addSubview:handovertxt];
    handovertxt.autoSuggestionDataSource = self;

    UIButton *transbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.24,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    transbtn.layer.cornerRadius = 4.0f;
    [transbtn setClipsToBounds:YES];
    [transbtn setTitle:@"Transfer" forState:UIControlStateNormal];
    [transbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [transbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    transbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [transbtn addTarget:self action:@selector(transfer) forControlEvents:UIControlEventTouchUpInside];
    [transbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [transbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]] ;
    [self.view addSubview:transbtn];
    
    UIButton *historybtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.55,screenRect.size.height*0.24,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    historybtn.layer.cornerRadius = 4.0f;
    [historybtn setClipsToBounds:YES];
    [historybtn setTitle:@"History" forState:UIControlStateNormal];
    [historybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [historybtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    historybtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //  [historybtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [historybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [historybtn setBackgroundColor:[UIColor colorWithHexString:@"#4166B6"]] ;
    [self.view addSubview:historybtn];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.31, screenRect.size.width,screenRect.size.height*.69)];
    tableViewHome.backgroundColor=[UIColor whiteColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewHome];
//
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
}
-(void)transfer
{
    NSString *useridstr,*toidstr;
    for (int i=0; i<assignarr.count; i++) {
        if ([[assignarr objectAtIndex:i]isEqualToString:curtemtext.text]) {
            useridstr=[assignidarr objectAtIndex:i];
        }
        if ([[assignarr objectAtIndex:i]isEqualToString:handovertxt.text]) {
            toidstr=[assignidarr objectAtIndex:i];
        }
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:useridstr forKey:@"fromid"];
    [params setObject:toidstr  forKey:@"toid"];
    [params setObject:@"saveHandover"  forKey:@"requestType"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savehandover.php?",[prefs objectForKey:@"Link"]];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
      int status =[[userDict objectForKey:@"status"]intValue];
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
-(void)viewWillAppear:(BOOL)animated
{
    [self getsalesperson];
}
- (void)loadWeekDays {
    // cancel previous requests
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadWeekDaysInBackground) object:self];
    //    [salesname setLoading:false];
    //
    //    // clear previous results
    //    [self.weeks removeAllObjects];
    //    [salesname reloadContents];
    //
    //    // start loading
    //    [salesname setLoading:true];
    //    [self performSelector:@selector(loadWeekDaysInBackground) withObject:self afterDelay:2.0f];
}

- (void)loadWeekDaysInBackground {
    // finish loading
    [curtemtext setLoading:false];
    [self.weeks addObjectsFromArray:assignarr];
    [curtemtext reloadContents];
}

- (UITableViewCell *)autoSuggestionField:(UITextField *)field tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath forText:(NSString *)text {
    static NSString *cellIdentifier = @"MonthAutoSuggestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ([field.fieldIdentifier isEqualToString:@"salesID"]||[field.fieldIdentifier isEqualToString:@"salesIDTo"]) {
        
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
    if ([field.fieldIdentifier isEqualToString:@"salesIDTo"]) {
        handovertxt.text =months[indexPath.row];
    }
    else
    curtemtext.text =months[indexPath.row];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return true;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:screenRect.size.width*.04];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width,screenRect.size.height*0.07)];
        headerView.backgroundColor=[UIColor clearColor];
        
        //    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 2.0f)];
        //    lineView2.backgroundColor = [UIColor grayColor];
        //    [headerView addSubview:lineView2];
        
        UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.30,screenRect.size.height*0.07)];
        Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
        Srnolbl.textAlignment = NSTextAlignmentCenter;
        Srnolbl.text =@"Thir T" ;
        Srnolbl.backgroundColor = [UIColor clearColor];
        Srnolbl.textColor=[UIColor blackColor];
        Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
        Srnolbl.numberOfLines = 0;
        [headerView addSubview:Srnolbl];
        
        UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        namelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        namelbl.textAlignment = NSTextAlignmentCenter;
        namelbl.text = @"12";
        namelbl.backgroundColor = [UIColor clearColor];
        namelbl.textColor=[UIColor blackColor];
        namelbl.lineBreakMode = NSLineBreakByWordWrapping;
        namelbl.numberOfLines = 0;
        [headerView addSubview:namelbl];
        
        UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,0,screenRect.size.width*0.23,screenRect.size.height*0.07)];
        datelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        datelbl.textAlignment = NSTextAlignmentCenter;
        datelbl.text = @"47";
        datelbl.backgroundColor = [UIColor clearColor];
        datelbl.textColor=[UIColor blackColor];
        datelbl.lineBreakMode = NSLineBreakByWordWrapping;
        datelbl.numberOfLines = 0;
        [headerView addSubview:datelbl];
        
        UILabel*  cashlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,0,screenRect.size.width*0.25,screenRect.size.height*0.07)];
        cashlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        cashlbl.textAlignment = NSTextAlignmentCenter;
        cashlbl.text = @"23";
        cashlbl.backgroundColor = [UIColor clearColor];
        cashlbl.textColor=[UIColor blackColor];
        cashlbl.lineBreakMode = NSLineBreakByWordWrapping;
        cashlbl.numberOfLines = 0;
        [headerView addSubview:cashlbl];
        
        UILabel*  expencelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.85,0,screenRect.size.width*0.15,screenRect.size.height*0.07)];
        expencelbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        expencelbl.textAlignment = NSTextAlignmentCenter;
        expencelbl.text = @"11.03";
        expencelbl.backgroundColor = [UIColor clearColor];
        expencelbl.textColor=[UIColor blackColor];
        expencelbl.lineBreakMode = NSLineBreakByWordWrapping;
        expencelbl.numberOfLines = 0;
        [headerView addSubview:expencelbl];
        
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
    
    return screenRect.size.height*0.07;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
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
