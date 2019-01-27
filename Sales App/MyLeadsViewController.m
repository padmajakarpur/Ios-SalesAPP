//
//  MyLeadsViewController.m
//  Sales App
//
//  Created by Infinitum on 08/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "MyLeadsViewController.h"
#import "SWRevealViewController.h"
#import "UIColor+Expanded.h"
#import <QuartzCore/QuartzCore.h>
#import "LeadViewController.h"
#import "AddLeadViewController.h"
#import "HomeViewController.h"
#import <AFNetworking.h>
@interface MyLeadsViewController ()

@end
@implementation MyLeadsViewController
@synthesize tableViewHome,bgview,demoView,prostagetxt,prostatustxt,stagearr,stagestr,statusarr,statusstr,statuwpicker,stagestoolbar,stegespickeer,statustoolbar,projectstxt,flatsizetxt,projectarr,projectstr,projectoolbar,projectpicker,flatarr,flatstr,flatpicker,flatsizetoolbar,indicator,searchview,leadsarr,totalarr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
  //  appDelegate=[[UIApplication sharedApplication] delegate];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
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
    
//    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
//      [filtbtn addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
//    [filtbtn setTitle:@"\uE152" forState:UIControlStateNormal];
//    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [filtbtn.titleLabel setFont:customFontdregs];
//    [filtbtn setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:filtbtn];
    
    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.90,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setTitle:@"\uE145" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn.titleLabel setFont:customFontdregs];
    [addbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:addbtn];
    
    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [filtbtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [filtbtn setTitle:@"\uE8B6" forState:UIControlStateNormal];
    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filtbtn.titleLabel setFont:customFontdregs];
    [filtbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:filtbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Prospects";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
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

-(void)search
{
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    searchview=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:searchview];
    searchview.backgroundColor = [UIColor whiteColor];
    _searchtext=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.03,screenRect.size.width*0.80,screenRect.size.height*0.07)];
    _searchtext.placeholder=@"Search projects here...";
    _searchtext.delegate=self;
    [searchview addSubview:_searchtext];
    [_searchtext becomeFirstResponder];
    [self.view addSubview:searchview];
    
    UIButton* backbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbtn.titleLabel setFont:customFontdregs];
    [backbtn setBackgroundColor:[UIColor clearColor]];
    [searchview addSubview:backbtn];
}
-(void)viewWillAppear:(BOOL)animated
{
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
                NSError *error;
                if ([content isEqualToString:@""]) {
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [indicator stopAnimating];
                }else {
                    leadsarr=[[NSMutableArray alloc]init];
                   totalarr =[[NSMutableArray alloc]init];

                    //   NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSDictionary* userDict = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:&error];
                    NSLog(@"content %@",userDict);
                    NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
                    leadsarr=[dic objectForKey:@"leads"];
                    totalarr=[leadsarr mutableCopy];
                    [tableViewHome reloadData];
                    [indicator stopAnimating];
                }
            }
        }];
    }
    [tableViewHome reloadData];
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,0,screenRect.size.width*0.94,screenRect.size.height*0.19)];
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
    Srnolbl.text =[NSString stringWithFormat:@"Name :%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]];
    Srnolbl.backgroundColor = [UIColor clearColor];
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
    namelbl.text = [NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"project_name"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  idlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.085,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    idlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    idlbl.textAlignment = NSTextAlignmentLeft;
    NSString * str=[dict objectForKey:@"phone_mobile"];
    if ([[dict objectForKey:@"phone_mobile"] length] > 4)
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
    
    UILabel*  linelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13,screenRect.size.width*0.85,screenRect.size.height*0.003)];
    linelbl.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:linelbl];
    
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.68,screenRect.size.height*0.135,screenRect.size.width*0.08,screenRect.size.height*.05)];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    savebtn.layer.masksToBounds=YES;
    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    savebtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [savebtn setTitle:@"\uE0B0" forState:UIControlStateNormal];
    [headerView addSubview:savebtn];
    
    UIButton *phonebtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.76,screenRect.size.height*0.135,screenRect.size.width*0.10,screenRect.size.height*.05)];
    [phonebtn2 setBackgroundColor:[UIColor clearColor]];
    [phonebtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
    phonebtn2.tag=indexPath.row;
    [phonebtn2 setTitle:@"Call" forState:UIControlStateNormal];
    [phonebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phonebtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont* font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
    phonebtn2.titleLabel.font=font;
    [headerView addSubview:phonebtn2];
    
//    UIButton *statusbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.56,screenRect.size.height*0.135,screenRect.size.width*0.08,screenRect.size.height*.05)];
//    [statusbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    statusbtn.layer.masksToBounds=YES;
//    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
//    statusbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
//    [statusbtn setTitle:@"\uE254" forState:UIControlStateNormal];
//    [headerView addSubview:statusbtn];
//
//    UIButton *statusbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.64,screenRect.size.height*0.135,screenRect.size.width*0.30,screenRect.size.height*.05)];
//    [statusbtn2 setBackgroundColor:[UIColor clearColor]];
//    [statusbtn2 addTarget:self action:@selector(changestatus) forControlEvents:UIControlEventTouchUpInside];
//    statusbtn2.tag=indexPath.row;
//    [statusbtn2 setTitle:@"Change status" forState:UIControlStateNormal];
//    [statusbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    statusbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    statusbtn2.titleLabel.font=font;
//    [headerView addSubview:statusbtn2];
    
//    UIButton *editbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.65,screenRect.size.height*0.135,screenRect.size.width*0.08,screenRect.size.height*.05)];
//    [editbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    editbtn.layer.masksToBounds=YES;
//    //   [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
//    editbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
//    [editbtn setTitle:@"\uE14F" forState:UIControlStateNormal];
//    [headerView addSubview:editbtn];
//
//    UIButton *editbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.73,screenRect.size.height*0.135,screenRect.size.width*0.10,screenRect.size.height*.05)];
//    [editbtn2 setBackgroundColor:[UIColor clearColor]];
//  //  [editbtn2 addTarget:self action:@selector(openurl:) forControlEvents:UIControlEventTouchUpInside];
//    editbtn2.tag=indexPath.row;
//    [editbtn2 setTitle:@"Edit" forState:UIControlStateNormal];
//    [editbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    editbtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    editbtn2.titleLabel.font=font;
//    [headerView addSubview:editbtn2];
    
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
    LeadViewController *mainvc=[[LeadViewController alloc] initWithNibName:@"LeadViewController" bundle:nil];
        mainvc.dict=[leadsarr objectAtIndex:indexPath.row];
  //  [self.navigationController pushViewController:mainvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)add
{
    AddLeadViewController *mainvc=[[AddLeadViewController alloc] initWithNibName:@"AddLeadViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}

-(void)back
{

    [searchview removeFromSuperview];
    leadsarr= [[NSMutableArray alloc]init];
    [leadsarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
     
     }

-(void)filter: (id) sender
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    heig=150;
    
    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height*0.12, 300,270)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
//    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
//    [topButton setTitle:@"Update Prospect Status" forState:UIControlStateNormal];
//    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    topButton.layer.cornerRadius=1.0;
//    topButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
//    [topButton setBackgroundColor:[UIColor colorWithHexString:@"35a6e6"]];
//    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
//    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [demoView addSubview:topButton];
    
    prostagetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,10,280,40)];
    prostagetxt.textAlignment=NSTextAlignmentLeft;
    prostagetxt.delegate = self;
    prostagetxt.textColor=[UIColor blackColor];
    [prostagetxt setBackgroundColor:[UIColor clearColor]];
    prostagetxt.leftViewMode = UITextFieldViewModeAlways;
    [prostagetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prostagetxt.returnKeyType=UIReturnKeyDone;
    prostagetxt.selectedLineColor = [UIColor redColor];
    prostagetxt.selectedPlaceHolderColor = [UIColor redColor];
    prostagetxt.placeHolderColor = [UIColor grayColor];
    prostagetxt.placeholder=@"Prospect Stage";
    prostagetxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:prostagetxt];
   
    prostatustxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,60,280,40)];
    prostatustxt.textAlignment=NSTextAlignmentLeft;
    prostatustxt.delegate = self;
    prostatustxt.textColor=[UIColor blackColor];
    [prostatustxt setBackgroundColor:[UIColor clearColor]];
    prostatustxt.leftViewMode = UITextFieldViewModeAlways;
    [prostatustxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prostatustxt.returnKeyType=UIReturnKeyDone;
    prostatustxt.selectedLineColor = [UIColor redColor];
    prostatustxt.selectedPlaceHolderColor = [UIColor redColor];
    prostatustxt.placeHolderColor = [UIColor grayColor];
    prostatustxt.placeholder=@"Prospect Status";
    prostatustxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:prostatustxt];
    
    projectstxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,110,280,40)];
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
    projectstxt.placeholder=@"Projects";
    projectstxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:projectstxt];
    
    flatsizetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,160,280,40)];
    flatsizetxt.textAlignment=NSTextAlignmentLeft;
    flatsizetxt.delegate = self;
    flatsizetxt.textColor=[UIColor blackColor];
    [flatsizetxt setBackgroundColor:[UIColor clearColor]];
    flatsizetxt.leftViewMode = UITextFieldViewModeAlways;
    [flatsizetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    flatsizetxt.returnKeyType=UIReturnKeyDone;
    flatsizetxt.selectedLineColor = [UIColor redColor];
    flatsizetxt.selectedPlaceHolderColor = [UIColor redColor];
    flatsizetxt.placeHolderColor = [UIColor grayColor];
    flatsizetxt.placeholder=@"Flat size";
    flatsizetxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:flatsizetxt];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,215,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,215,125,40)];
    [savebtn setTitle:@"Search" forState:UIControlStateNormal];
    [savebtn addTarget:self
                action:@selector(closeAlert:)
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
-(void)changestatus
{
    bgview=[[UIView alloc]initWithFrame:self.view.frame];
    bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.view addSubview:bgview];
    int heig=0;
    heig=150;

    [demoView removeFromSuperview];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    demoView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2-150, screenRect.size.height/2-150, 300,230)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [topButton setTitle:@"Update Prospect Status" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    topButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [topButton setBackgroundColor:[UIColor colorWithHexString:@"35a6e6"]];
    [topButton setFont:[UIFont boldSystemFontOfSize:16]];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
    prostagetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,55,280,50)];
    prostagetxt.textAlignment=NSTextAlignmentLeft;
    prostagetxt.delegate = self;
    prostagetxt.textColor=[UIColor blackColor];
    [prostagetxt setBackgroundColor:[UIColor clearColor]];
    prostagetxt.leftViewMode = UITextFieldViewModeAlways;
    [prostagetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prostagetxt.returnKeyType=UIReturnKeyDone;
    prostagetxt.selectedLineColor = [UIColor redColor];
    prostagetxt.selectedPlaceHolderColor = [UIColor redColor];
    prostagetxt.placeHolderColor = [UIColor grayColor];
    prostagetxt.placeholder=@"Prospect Stage";
    prostagetxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:prostagetxt];
    
    prostatustxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(10,105,280,50)];
    prostatustxt.textAlignment=NSTextAlignmentLeft;
    prostatustxt.delegate = self;
    prostatustxt.textColor=[UIColor blackColor];
    [prostatustxt setBackgroundColor:[UIColor clearColor]];
    prostatustxt.leftViewMode = UITextFieldViewModeAlways;
    [prostatustxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prostatustxt.returnKeyType=UIReturnKeyDone;
    prostatustxt.selectedLineColor = [UIColor redColor];
    prostatustxt.selectedPlaceHolderColor = [UIColor redColor];
    prostatustxt.placeHolderColor = [UIColor grayColor];
    prostatustxt.placeholder=@"Prospect Status";
    prostatustxt.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:prostatustxt];
    
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(23,170,125,40)];
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
    
    UIButton *savebtn=[[UIButton alloc] initWithFrame:CGRectMake(152,170,125,40)];
    [savebtn setTitle:@"Save" forState:UIControlStateNormal];
    [savebtn addTarget:self
                action:@selector(closeAlert:)
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
-(void)closeAlert:(id)sender{
    CATransition *transition1 = [CATransition animation];
    transition1.duration = 0.5;
    transition1.type = kCATransitionPush;
    transition1.subtype = kCATransitionFromLeft;
    [transition1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [demoView.layer addAnimation:transition1 forKey:nil];
    demoView.hidden=YES;
    [bgview removeFromSuperview];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    if (pickerView == stegespickeer)
    {
        rowItem = [stagearr objectAtIndex: row];
    }
    if (pickerView == statuwpicker)
    {
        rowItem = [statusarr objectAtIndex: row];
    }
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
    if (pickerView == flatpicker)
    {
        rowItem = [flatarr objectAtIndex: row];
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
    if (pickerView ==stegespickeer)
    {
        stagestr=[[NSString alloc]init];
        stagestr=[NSString stringWithFormat:@"%@",[stagearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==statuwpicker)
    {
        statusstr=[[NSString alloc]init];
        statusstr=[NSString stringWithFormat:@"%@",[statusarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==projectpicker)
    {
        projectstr=[[NSString alloc]init];
        projectstr=[NSString stringWithFormat:@"%@",[projectarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==flatpicker)
    {
        flatstr=[[NSString alloc]init];
        flatstr=[NSString stringWithFormat:@"%@",[flatarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
   
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == stegespickeer)
    {
        return [stagearr objectAtIndex:row];
    }
    if (pickerView == statuwpicker)
    {
        return [statusarr objectAtIndex:row];
    }
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
    if (pickerView == flatpicker)
    {
        return [flatarr objectAtIndex:row];
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
    
    stagestoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    stegespickeer.hidden=YES;
    statustoolbar.hidden=YES;
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    flatpicker.hidden=YES;
    flatsizetoolbar.hidden=YES;
    if (textField ==prostagetxt) {
        stagearr=[[NSMutableArray alloc]initWithObjects:@"Warm",@"Hot",@"Cold", nil];
        
        stegespickeer = [[UIPickerView alloc] init];
        [stegespickeer setDataSource: self];
        [stegespickeer setDelegate: self];
        stegespickeer.backgroundColor = [UIColor whiteColor];
        [stegespickeer setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        stegespickeer.showsSelectionIndicator = YES;
        [stegespickeer selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: stegespickeer];
        stegespickeer.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            stagestoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            stagestoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [stagestoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        stagestoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:stagestoolbar];
        stagestoolbar.hidden=NO;
        [prostagetxt resignFirstResponder];
        return NO;
    }
    if (textField ==prostatustxt) {
        statusarr=[[NSMutableArray alloc]initWithObjects:@"Follow Up",@"Call later",@"Ringing",@"not Reachable",@"Switch Off", nil];
        statuwpicker = [[UIPickerView alloc] init];
        [statuwpicker setDataSource: self];
        [statuwpicker setDelegate: self];
        statuwpicker.backgroundColor = [UIColor whiteColor];
        [statuwpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        statuwpicker.showsSelectionIndicator = YES;
        [statuwpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: statuwpicker];
        statuwpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [statustoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        statustoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:statustoolbar];
        
        statustoolbar.hidden=NO;
        [prostatustxt resignFirstResponder];
        return NO;
    }
    if (textField ==projectstxt) {
        projectarr=[[NSMutableArray alloc]initWithObjects:@"Ambi",@"Riverfront",@"Adobe-Jambhul",@"Hinjewadi", nil];
        
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
        [projectstxt resignFirstResponder];
        return NO;
    }
    
    if (textField ==flatsizetxt) {
        flatarr=[[NSMutableArray alloc]initWithObjects:@"1BHK",@"2BHK",@"3BHK",@"4BHK",@"5BHK", nil];
        
        flatpicker = [[UIPickerView alloc] init];
        [flatpicker setDataSource: self];
        [flatpicker setDelegate: self];
        flatpicker.backgroundColor = [UIColor whiteColor];
        [flatpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        flatpicker.showsSelectionIndicator = YES;
        [flatpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: flatpicker];
        flatpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            flatsizetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            flatsizetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [flatsizetoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed5)];
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
        
        flatsizetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:flatsizetoolbar];
        
        flatsizetoolbar.hidden=NO;
        [flatsizetxt resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_searchtext) {
        leadsarr= [[NSMutableArray alloc]init];
        NSString*  textstr=textField.text;
        if ([string isEqualToString:@""]) {
            textstr= [textstr substringToIndex:[textstr length]-1];
        }
        else
        {
            textstr=[NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        for (int i=0; i<totalarr.count; i++) {
            NSDictionary *tempdict=[totalarr objectAtIndex:i];
            NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_name"]];
            NSString*  str2= [NSString stringWithFormat:@"Name :%@ %@",[tempdict objectForKey:@"first_name"],[tempdict objectForKey:@"last_name"]];
            if ([[str1 uppercaseString] containsString:[textstr uppercaseString] ]|| [[str2 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"phone_mobile"] uppercaseString] containsString:[textstr uppercaseString]]) {
                [leadsarr addObject:[totalarr objectAtIndex:i]];
            }
        }
        if (textstr.length<1) {
            [leadsarr addObjectsFromArray:totalarr];
        }
        [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: stegespickeer]) {
        return [stagearr count];
    }
    if ([pickerView isEqual: statuwpicker]) {
        return [statusarr count];
    }
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
    if ([pickerView isEqual: flatpicker]) {
        return [flatarr count];
    }
    return 0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(IBAction)doneBtnPressed2{
    stagestoolbar.hidden=YES;
    stegespickeer.hidden=YES;
    
    if ([stagestr isEqualToString:@""] || stagestr==nil) {
        if (stagearr.count>0) {
            prostagetxt.text=[stagearr objectAtIndex:0];
        }
    }
    else{
        prostagetxt.text=stagestr;
    }
}
-(IBAction)doneBtnPressed3{
    statustoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    
    if ([statusstr isEqualToString:@""] || statusstr==nil) {
        if (statusarr.count>0) {
            prostatustxt.text=[statusarr objectAtIndex:0];
        }
    }
    else{
        prostatustxt.text=statusstr;
    }
}
-(IBAction)doneBtnPressed4{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    
    if ([projectstr isEqualToString:@""] || projectstr==nil) {
        if (projectarr.count>0) {
            projectstxt.text=[projectarr objectAtIndex:0];
        }
    }
    else{
        projectstxt.text=projectstr;
    }
}
-(IBAction)doneBtnPressed5{
    flatpicker.hidden=YES;
    flatsizetoolbar.hidden=YES;
    
    if ([flatstr isEqualToString:@""] || flatstr==nil) {
        if (flatarr.count>0) {
            flatsizetxt.text=[flatarr objectAtIndex:0];
        }
    }
    else{
        flatsizetxt.text=flatstr;
    }
}
-(IBAction)cancelBtnpress{
    
    stagestoolbar.hidden=YES;
    statuwpicker.hidden=YES;
    stegespickeer.hidden=YES;
    statustoolbar.hidden=YES;
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    flatpicker.hidden=YES;
    flatsizetoolbar.hidden=YES;
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
    [params setObject:[prefs objectForKey:@"user_name"] forKey:@"phoneName"];
    [params setObject:[prefs objectForKey:@"did_no"] forKey:@"did"];
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
           
            [self savedata:dict:[userDict objectForKey:@"message"]];
        }
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"status"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)savedata:(NSMutableDictionary*)dict :(NSString*)message
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *datestr = [formatter stringFromDate:[NSDate date]];

   NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
    [params setObject:@"Prospect" forKey:@"module"];
    [params setObject:[dict objectForKey:@"phone_mobile"] forKey:@"mobile"];
    [params setObject:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]] forKey:@"name"];
    [params setObject:[dict objectForKey:@"project_name"] forKey:@"projectname"];
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"userid"];
    [params setObject:datestr forKey:@"date"];
    [params setObject:message forKey:@"message"];
    [params setObject:@"queued" forKey:@"status"];
    
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        if ([[userDict objectForKey:@"status"]intValue] ==1) {
            
        }
        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}


-(void)generatenavigation
{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView *headerimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30, screenRect.size.height*0.04, screenRect.size.width*0.40,screenRect.size.height*0.12)];
    headerimageview.image=[UIImage imageNamed:@"Xrbia Logo.png"];
    headerimageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headerimageview];
    
    NSArray * arr=[[NSArray alloc]init];
    UIButton *navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.08,screenRect.size.width*0.10,screenRect.size.height*0.06)];
    [navigationbtn setClipsToBounds:YES];
    navigationbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [navigationbtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navigationbtn];
    [navigationbtn setImage:[UIImage imageNamed:@"Menu Buttons.png"] forState:UIControlStateNormal];
    
    UIButton *searchbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.75,screenRect.size.height*0.08,screenRect.size.width*0.06,screenRect.size.height*0.04)];
    [searchbtn setClipsToBounds:YES];
    searchbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchbtn];
    [searchbtn setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.89,screenRect.size.height*0.08,screenRect.size.width*0.005,screenRect.size.height*0.05)];
//    lineView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:lineView];
    
    UIButton *alarbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.85,screenRect.size.height*0.08,screenRect.size.width*0.08,screenRect.size.height*0.04)];
    //    [searchbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alarbtn];
    [alarbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    alarbtn.font =[UIFont fontWithName:@"MaterialIcons-Regular" size:35];
    [alarbtn setTitle:@"\uE145" forState:UIControlStateNormal];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
