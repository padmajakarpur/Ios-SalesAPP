//
//  VisitScheduleViewController.m
//  Sales App
//
//  Created by Infinitum on 09/05/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "VisitScheduleViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface VisitScheduleViewController ()

@end
@implementation VisitScheduleViewController
@synthesize tableViewHome,indicator,leadsarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Visit Schedule";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];

    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];

    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];

    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.12, screenRect.size.width,screenRect.size.height*.88)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewHome];
    
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

    [indicator startAnimating];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSString*   urlString = @"http://13.126.129.245/xrbia/mobilecrm/frontoffice/getFrontOfficeVisitsToday.php?";
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
                NSError *error;
                if ([content isEqualToString:@""]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [indicator stopAnimating];
                }else {
                    leadsarr=[[NSMutableArray alloc]init];
                    
                    NSDictionary* userDict = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:&error];
                    NSLog(@"content %@",userDict);
                    
                    leadsarr=[userDict objectForKey:@"data"];
                    [tableViewHome reloadData];
                    if (leadsarr.count==0) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    [indicator stopAnimating];
                }
            }
        }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return leadsarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict=[leadsarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    //    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.02,screenRect.size.height*0.12)];
    //    leftview.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    //    leftview.layer.shadowOffset = CGSizeMake(0, 2.0f);
    //    leftview.layer.shadowOpacity = 1.0f;
    //    leftview.layer.shadowRadius = 0.0f;
    //    leftview.layer.masksToBounds = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,0,screenRect.size.width*0.94,screenRect.size.height*0.13)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.70,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Name:%@",[dict objectForKey:@"customer_name"]];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    //    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.01,screenRect.size.width*0.30,screenRect.size.height*0.04)];
    //    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    //    datelbl.textAlignment = NSTextAlignmentRight;
    //    datelbl.text =@"08 Feb 2018";
    //    datelbl.backgroundColor = [UIColor clearColor];
    //    datelbl.textColor=[UIColor blackColor];
    //    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    //    datelbl.numberOfLines = 0;
    //    [headerView addSubview:datelbl];
    
    //    UIImageView *dashbgimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.02, screenRect.size.height*0.09,screenRect.size.height*0.09)];
    //    dashbgimageview.contentMode = UIViewContentModeScaleAspectFit;
    //    dashbgimageview.backgroundColor=[UIColor lightGrayColor];
    //    dashbgimageview.layer.cornerRadius=screenRect.size.height*0.045;
    //    dashbgimageview.clipsToBounds=YES;
    //    [dashbgimageview.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    //    [dashbgimageview.layer setBorderWidth: 3.0];
    //    [headerView addSubview:dashbgimageview];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text = [NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"site_visit_for_project"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.085,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    idlbl.textAlignment = NSTextAlignmentLeft;
    NSString * str=[dict objectForKey:@"phone_mobile"];
    if ([[dict objectForKey:@"phone_mobile"] length] > 0)
    {
        str = [str substringToIndex:[str length] - 4];
        str = [str stringByAppendingString:@"XXXX"];
    }
    idlbl.text =[NSString stringWithFormat:@"Mobile:%@",str];
    idlbl.backgroundColor = [UIColor clearColor];
    idlbl.textColor=[UIColor blackColor];
    idlbl.lineBreakMode = NSLineBreakByWordWrapping;
    idlbl.numberOfLines = 0;
    [headerView addSubview:idlbl];  
    
    
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
//    mainvc.dict=[leadsarr objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.14;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)openurl:(UIButton*)btn
{
    NSDictionary *dict=[leadsarr objectAtIndex:btn.tag];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dict objectForKey:@"phone_mobile"]]]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"xrbia"  forKey:@"userName"];
    [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
    [params setObject:[dict objectForKey:@"phone_mobile"] forKey:@"custNumber"];
    [params setObject:@"THIRU" forKey:@"phoneName"];
    [params setObject:@"912262495900" forKey:@"did"];
    [params setObject:@"1000" forKey:@"callLimit"];
    [params setObject:@"sap_test" forKey:@"uui"];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        
        if ([[userDict objectForKey:@"status"]isEqualToString:@"queued"]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"status"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
