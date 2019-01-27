//
//  BackOfficeViewController.m
//  Sales App
//
//  Created by Infinitum on 19/10/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "BackOfficeViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "BackOffCustomerListViewController.h"
#import <AFNetworking.h>
@interface BackOfficeViewController ()
@property(nonatomic,retain) NSMutableArray * tittlearr;

@end
@implementation BackOfficeViewController
@synthesize tableViewHome,indicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    //  [self generatenavigation];
    
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
    horizontallbl.text=@"Back Office ESC";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.20, screenRect.size.width,screenRect.size.height*.70)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewHome.bounces=NO;
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"user_id"];
    [params setObject:@"getblist" forKey:@"requestType"];
  //  [params setObject:@"7e41cd4e-1b4f-6243-d849-599ad02046c5"  forKey:@"user_id"];

     NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getboffice.php?",[prefs objectForKey:@"Link"]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self->_tittlearr=[[NSMutableArray alloc]init];
        
        NSLog(@"JSON: %@", userDict);
        self.tittlearr=[[userDict objectForKey:@"Android"] objectForKey:@"projects"];
        if (_tittlearr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data avaible"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self.tableViewHome reloadData];
        [self.indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tittlearr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
   // NSDictionary *dict=[visitarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    NSMutableDictionary * dict=[_tittlearr objectAtIndex:indexPath.row];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.71,screenRect.size.height*0.07)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.borderColor = [UIColor grayColor].CGColor;
    headerView.layer.borderWidth = 1.0;
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.00,screenRect.size.width*0.50,screenRect.size.height*0.07)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[dict objectForKey:@"process"];
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
   
    
    UILabel*  mobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.51,screenRect.size.height*0.00,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    mobilelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    mobilelbl.textAlignment = NSTextAlignmentCenter;
    mobilelbl.text =[dict objectForKey:@"zcount"];
    mobilelbl.backgroundColor = [UIColor clearColor];
    mobilelbl.textColor=[UIColor blackColor];
    mobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    mobilelbl.numberOfLines = 0;
    [headerView addSubview:mobilelbl];
    mobilelbl.layer.borderColor = [UIColor grayColor].CGColor;
    mobilelbl.layer.borderWidth = 1.0;
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
        BackOffCustomerListViewController *mainvc=[[BackOffCustomerListViewController alloc] initWithNibName:@"BackOffCustomerListViewController" bundle:nil];
    mainvc.processstr=[[_tittlearr objectAtIndex:indexPath.row]objectForKey:@"process"];        [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.07;
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
