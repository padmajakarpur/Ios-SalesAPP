//
//  inventaryViewController.m
//  Sales App
//
//  Created by Infinitum on 13/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "inventaryViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "SWRevealViewController.h"
#import "FilterInvinteryViewController.h"
#import "BuildingViewController.h"
@interface inventaryViewController ()

@end

@implementation inventaryViewController
@synthesize buildingtxt,scrollView,TakePhotoView,collectioonview,indicator,buildingarr,buildingstr,buildingtoolbar,buildingpicker,numberToolbarzip,buildingidarr,buildingidstr,filterview,appDelegate,tableViewHome,searchview,totalarr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];

    appDelegate=[[UIApplication sharedApplication] delegate];
    {
        appDelegate.premiumstr=@"";
        appDelegate.unitMinSize=@"";
        appDelegate.unitMinValue=@"";
        appDelegate.unitMaxSize=@"";
        appDelegate.unitMaxValue=@"";
        appDelegate.projectId=@"";
        appDelegate.unitType=@"";
        appDelegate.projectstr=@"";
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"NotificationMessageEvent" object:nil];
    
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
    [self.view addSubview:navigationbtn];;
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Inventory";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UIButton *filterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.65,screenRect.size.height*0.03,screenRect.size.width*0.15,screenRect.size.height*0.07)];
    filterbtn.layer.cornerRadius = 4.0f;
    [filterbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filterbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    filterbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [filterbtn addTarget:self action:@selector(filter) forControlEvents:UIControlEventTouchUpInside];
    [filterbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [filterbtn setTitle:@"Filter" forState:UIControlStateNormal];
    [self.view addSubview:filterbtn];
    
    UIButton* filtbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.82,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [filtbtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [filtbtn setTitle:@"\uE8B6" forState:UIControlStateNormal];
    [filtbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filtbtn.titleLabel setFont:[UIFont fontWithName:@"MaterialIcons-Regular" size:25]];
    [filtbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:filtbtn];
    
    
    UIButton* sortbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.92,screenRect.size.height*0.03,screenRect.size.width*.08,screenRect.size.height*.07)];
    [sortbtn setTitle:@"\uE8D5" forState:UIControlStateNormal];
    [sortbtn addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    [sortbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sortbtn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [sortbtn.titleLabel setFont:customFontdregs];
    [self.view addSubview:sortbtn];;
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.11, screenRect.size.width,screenRect.size.height*.89)];
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
    [self getproject];
}

-(NSString*)shownumber:(NSString*)str
{
    str= [NSString stringWithFormat:@"%0.02f",[str doubleValue]];
    float value=[str floatValue]+0.002;
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setPositiveFormat:@"##,##,###"];
    formatter.maximumFractionDigits = 02;
    NSString*  defalutstr=[NSString stringWithFormat:@"₹ %@",[formatter stringFromNumber:[NSNumber numberWithFloat:value]]];
    
    if ([defalutstr rangeOfString:@"."].location == NSNotFound) {
        defalutstr = [defalutstr stringByAppendingString:@".00"]; //str is now "hello world"
    } else {
        return defalutstr;
    }
    
    //
    return defalutstr;
}
-(void)sort:(UIButton*)btn
{
    if (btn.selected) {
        btn.selected=NO;
    }
    else
    {
        btn.selected=YES;
    }
    buildingarr=[[[buildingarr reverseObjectEnumerator] allObjects] mutableCopy];
    [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)getproject
{
    [indicator startAnimating];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@""  forKey:@"projectId"];
    [params setObject:@"" forKey:@"unitType"];
    [params setObject:@""  forKey:@"unitMinSize"];
    [params setObject:@""  forKey:@"unitMinValue"];
    [params setObject:@"" forKey:@"unitMaxSize"];
    [params setObject:@""  forKey:@"unitMaxValue"];
    [params setObject:@""  forKey:@"premium"];
    [params setObject:@"getBuildingByFilters"  forKey:@"requestType"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        buildingarr=[[NSMutableArray alloc]init];
        _floorarr=[[NSMutableArray alloc]init];

        NSLog(@"JSON: %@", userDict);
      buildingarr=[[userDict objectForKey:@"Android"]objectForKey:@"buildings"];
       _floorarr =[[userDict objectForKey:@"Android"]objectForKey:@"units"];
        totalarr=[_floorarr mutableCopy];
        [indicator stopAnimating];
        [tableViewHome reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void) viewWillAppear:(BOOL)animated
{
    
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_searchtext) {
     
            buildingarr= [[NSMutableArray alloc]init];
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
                NSString *str1=[NSString stringWithFormat:@"%@",[tempdict objectForKey:@"project_name"]]
                ;
                if ([[str1 uppercaseString] containsString:[textstr uppercaseString]]|| [[[tempdict objectForKey:@"name"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"customer_mobile_c"] uppercaseString] containsString:[textstr uppercaseString]]||[[[tempdict objectForKey:@"fu_date_c"] uppercaseString] containsString:[textstr uppercaseString]]) {
                    [buildingarr addObject:[totalarr objectAtIndex:i]];
                }

            }
            if (textstr.length<1) {
                [buildingarr addObjectsFromArray:totalarr];
            }
            [tableViewHome reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
}

-(void)back
{
    [searchview removeFromSuperview];
    buildingarr=[[NSMutableArray alloc]init];
    [buildingarr addObjectsFromArray:totalarr];
    [tableViewHome reloadData];
}

-(void)filter
{
    FilterInvinteryViewController *mainvc=[[FilterInvinteryViewController alloc] initWithNibName:@"FilterInvinteryViewController" bundle:nil];
    [self.navigationController presentViewController:mainvc animated:YES completion:nil];
}


-(void) triggerAction:(NSNotification *) notification
{
    buildingarr  = [notification.userInfo objectForKey:@"buildings"];
    [tableViewHome reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return buildingarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSDictionary *dict=[buildingarr objectAtIndex:indexPath.row];
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,0,screenRect.size.width*0.94,screenRect.size.height*0.185)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.0,screenRect.size.width*0.30,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Project"];
    ;
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    
    UILabel*  Srnolbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.0,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    Srnolbl2.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl2.textAlignment = NSTextAlignmentLeft;
    Srnolbl2.text =[NSString stringWithFormat:@": %@",[dict objectForKey:@"project_name"]];
    Srnolbl2.backgroundColor = [UIColor clearColor];
    Srnolbl2.textColor=[UIColor blackColor];
    Srnolbl2.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl2.numberOfLines = 0;
    [headerView addSubview:Srnolbl2];
    
    
    UILabel*  valuelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.04,screenRect.size.width*0.30,screenRect.size.height*0.035)];
    valuelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    valuelbl.textAlignment = NSTextAlignmentLeft;
    valuelbl.text =[NSString stringWithFormat:@"Agrement value"];
    valuelbl.backgroundColor = [UIColor clearColor];
    valuelbl.textColor=[UIColor blackColor];
    valuelbl.lineBreakMode = NSLineBreakByWordWrapping;
    valuelbl.numberOfLines = 0;
    [headerView addSubview:valuelbl];
    
    UILabel*  valuelb2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.04,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    valuelb2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    valuelb2.textAlignment = NSTextAlignmentLeft;
    valuelb2.text =[NSString stringWithFormat:@": %@",[self shownumber:[NSString stringWithFormat:@"%@",[dict objectForKey:@"agreement_value"]]]];
    valuelb2.backgroundColor = [UIColor clearColor];
    valuelb2.textColor=[UIColor blackColor];
    valuelb2.lineBreakMode = NSLineBreakByWordWrapping;
    valuelb2.numberOfLines = 0;
    [headerView addSubview:valuelb2];
    
    UILabel*  arealbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.075,screenRect.size.width*0.30,screenRect.size.height*0.035)];
    arealbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    arealbl.textAlignment = NSTextAlignmentLeft;
    arealbl.text =[NSString stringWithFormat:@"Area"];
    arealbl.backgroundColor = [UIColor clearColor];
    arealbl.textColor=[UIColor blackColor];
    arealbl.lineBreakMode = NSLineBreakByWordWrapping;
    arealbl.numberOfLines = 0;
    [headerView addSubview:arealbl];
    
    UILabel*  arealbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.075,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    arealbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    arealbl2.textAlignment = NSTextAlignmentLeft;
    arealbl2.text =[NSString stringWithFormat:@": %@",[dict objectForKey:@"saleable_area"]];
    arealbl2.backgroundColor = [UIColor clearColor];
    arealbl2.textColor=[UIColor blackColor];
    arealbl2.lineBreakMode = NSLineBreakByWordWrapping;
    arealbl2.numberOfLines = 0;
    [headerView addSubview:arealbl2];
    
    
    UILabel*  buildlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11,screenRect.size.width*0.30,screenRect.size.height*0.035)];
    buildlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    buildlbl.textAlignment = NSTextAlignmentLeft;
    buildlbl.text =[NSString stringWithFormat:@"Building:"];
    buildlbl.backgroundColor = [UIColor clearColor];
    buildlbl.textColor=[UIColor blackColor];
    buildlbl.lineBreakMode = NSLineBreakByWordWrapping;
    buildlbl.numberOfLines = 0;
    [headerView addSubview:buildlbl];
    
    UILabel*  buildlbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.11,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    buildlbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    buildlbl2.textAlignment = NSTextAlignmentLeft;
    buildlbl2.text =[NSString stringWithFormat:@": %@",[dict objectForKey:@"name"]];
    buildlbl2.backgroundColor = [UIColor clearColor];
    buildlbl2.textColor=[UIColor blackColor];
    buildlbl2.lineBreakMode = NSLineBreakByWordWrapping;
    buildlbl2.numberOfLines = 0;
    [headerView addSubview:buildlbl2];
    
    UILabel*  type = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.145,screenRect.size.width*0.30,screenRect.size.height*0.035)];
    type.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    type.textAlignment = NSTextAlignmentLeft;
    type.text =[NSString stringWithFormat:@"Type:"];
    type.backgroundColor = [UIColor clearColor];
    type.textColor=[UIColor blackColor];
    type.lineBreakMode = NSLineBreakByWordWrapping;
    type.numberOfLines = 0;
    [headerView addSubview:type];
    
    UILabel*  type2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.145,screenRect.size.width*0.40,screenRect.size.height*0.04)];
    type2.font=[UIFont systemFontOfSize:screenRect.size.width*0.035];
    type2.textAlignment = NSTextAlignmentLeft;
    type2.text =[NSString stringWithFormat:@": %@",[dict objectForKey:@"type"]];
    type2.backgroundColor = [UIColor clearColor];
    type2.textColor=[UIColor blackColor];
    type2.lineBreakMode = NSLineBreakByWordWrapping;
    type2.numberOfLines = 0;
    [headerView addSubview:type2];
    
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
    NSDictionary *dict=[buildingarr objectAtIndex:indexPath.row];
    _forwardarr=[[NSMutableArray alloc]init];
    for (int i=0; i<_floorarr.count; i++) {
        NSMutableDictionary * innnerdict=[_floorarr objectAtIndex:i];
        if ([[dict objectForKey:@"building_name"] isEqualToString:[innnerdict objectForKey:@"building_name"]]) {
            if ([[dict objectForKey:@"project_name"] isEqualToString:[innnerdict objectForKey:@"project_name"]]) {
                [_forwardarr addObject:innnerdict];
            }
        }
    }
    if (_forwardarr.count>0) {
                BuildingViewController *mainvc=[[BuildingViewController alloc] initWithNibName:@"BuildingViewController" bundle:nil];
            mainvc.buildingarr=_forwardarr;
                [self.navigationController pushViewController:mainvc animated:YES];
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.20;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _floorarr.count;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    return CGSizeMake(screenRect.size.width*0.025,screenRect.size.width*0.025);
//
//}
- (UICollectionViewCell *)collectionView:(UICollectionView* )collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    NSMutableDictionary * dict=[_floorarr objectAtIndex:indexPath.row];
    UILabel *linelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.0,screenRect.size.width*0.20,screenRect.size.height*0.07)];
    linelbl2.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    linelbl2.text=[NSString stringWithFormat:@"Floor %@",[dict objectForKey:@"floor"]];
    [linelbl2 setTextColor:[UIColor blackColor]];
    linelbl2.backgroundColor=[UIColor clearColor];
    linelbl2.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:linelbl2];
    linelbl2.layer.borderColor = [UIColor blackColor].CGColor;
    linelbl2.layer.borderWidth = 1.0;
    
    UILabel *linelbl1 = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.07,screenRect.size.width*0.20,screenRect.size.height*0.05)];
    linelbl1.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    linelbl1.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"units"]];
    [linelbl1 setTextColor:[UIColor whiteColor]];
    linelbl1.backgroundColor=[UIColor blackColor];
    linelbl1.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:linelbl1];
    
    cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath* )indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenRect.size.width*.20, screenRect.size.height*0.13);
}

-(void)collectionView:(UICollectionView* )collectionView didSelectItemAtIndexPath:(NSIndexPath* )indexPath
{
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"get_flats"  forKey:@"requestType"];
//    [params setObject:siteidstr  forKey:@"buildingId"];
//    [params setObject:[_dict objectForKey:@"project_id"] forKey:@"projectId"];
//    [params setObject:[[_floorarr objectAtIndex:indexPath.row] objectForKey:@"id"] forKey:@"unitNumber"];
//    
//    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
//    [indicator startAnimating];
//    
//    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"JSON: %@", userDict);
//        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//        unitsarr=[[NSMutableArray alloc]init];
//        unitsarr=[dic objectForKey:@"units"];
//        [indicator stopAnimating];
//        TakePhotoView = [[CustomIOS7AlertView alloc] init];
//        [TakePhotoView setContainerView:[self signImageSetAlert]];
//        [TakePhotoView setDelegate:self];
//        [TakePhotoView setUseMotionEffects:true];
//        [TakePhotoView show];
//        
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [indicator stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
    
   

}
-(UIView *)signImageSetAlert{
    int heig=0;
    UIView *demoView;
    heig=150;
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,210)];
    
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UILabel*  tittlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 300, 50)];
    tittlelbl.font=[UIFont systemFontOfSize:18];
    tittlelbl.textAlignment = NSTextAlignmentCenter;
    tittlelbl.text =@"Select unit";
    tittlelbl.backgroundColor = [UIColor clearColor];
    tittlelbl.textColor=[UIColor blackColor];
    [demoView addSubview:tittlelbl];
    
    UIButton *checkboxbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, 30,20)];
    checkboxbtn.font=[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [checkboxbtn setTitle:@"\uE836" forState:UIControlStateNormal];
    [checkboxbtn setTitle:@"\uE837" forState:UIControlStateSelected];
    [checkboxbtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [checkboxbtn addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:checkboxbtn];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 100, 40)];
    namelbl.font=[UIFont systemFontOfSize:15];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =@"C1 304";
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    [demoView addSubview:namelbl];
    
    UIButton *checkboxbtn2 = [[UIButton alloc] initWithFrame:CGRectMake(160, 60, 30,20)];
    checkboxbtn2.font=[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [checkboxbtn2 setTitle:@"\uE836" forState:UIControlStateNormal];
    [checkboxbtn2 setTitle:@"\uE837" forState:UIControlStateSelected];
    [checkboxbtn2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [checkboxbtn2 addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:checkboxbtn2];
    
    UILabel*  namelbl2 = [[UILabel alloc] initWithFrame:CGRectMake(190, 50, 100, 40)];
    namelbl2.font=[UIFont systemFontOfSize:15];
    namelbl2.textAlignment = NSTextAlignmentLeft;
    namelbl2.text =@"C1 302";
    namelbl2.backgroundColor = [UIColor clearColor];
    namelbl2.textColor=[UIColor blackColor];
    [demoView addSubview:namelbl2];
    
    UIButton *checkboxbtn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 30,20)];
    checkboxbtn3.font=[UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    [checkboxbtn3 setTitle:@"\uE836" forState:UIControlStateNormal];
    [checkboxbtn3 setTitle:@"\uE837" forState:UIControlStateSelected];
    [checkboxbtn3 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [checkboxbtn3 addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:checkboxbtn3];
    
    UILabel*  namelbl3 = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 100, 40)];
    namelbl3.font=[UIFont systemFontOfSize:15];
    namelbl3.textAlignment = NSTextAlignmentLeft;
    namelbl3.text =@"C1 303";
    namelbl3.backgroundColor = [UIColor clearColor];
    namelbl3.textColor=[UIColor blackColor];
    [demoView addSubview:namelbl3];
    
    UIButton *blockbtn=[[UIButton alloc] initWithFrame:CGRectMake(05,150,90,40)];
    [blockbtn setTitle:@"Block" forState:UIControlStateNormal];
    [blockbtn addTarget:self
                 action:@selector(closeAlert:)
       forControlEvents:UIControlEventTouchUpInside];
    [blockbtn setBackgroundColor:[UIColor clearColor]];
    blockbtn.font=[UIFont systemFontOfSize:14];
    [blockbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [blockbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    blockbtn.layer.borderColor = [UIColor grayColor].CGColor;
    blockbtn.layer.borderWidth = 1.0;
    [demoView addSubview:blockbtn];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(100,150,90,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.font=[UIFont systemFontOfSize:14];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    cancelBtn.layer.borderWidth = 1.0;
    [demoView addSubview:cancelBtn];
    
    UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(195,150,100,40)];
    [okbtn setTitle:@"View details" forState:UIControlStateNormal];
    okbtn.font=[UIFont systemFontOfSize:14];
  //  [okbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    okbtn.tag=2;
    [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    okbtn.layer.borderColor = [UIColor grayColor].CGColor;
    okbtn.layer.borderWidth = 1.0;
    [demoView addSubview:okbtn];
    return demoView;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
   
    if (pickerView == buildingpicker)
    {
        rowItem = [buildingarr objectAtIndex: row];
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
    
    if (pickerView ==buildingpicker)
    {
        buildingstr=[[NSString alloc]init];
        buildingstr=[NSString stringWithFormat:@"%@",[buildingarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        buildingidstr=[[NSString alloc]init];
        buildingidstr=[NSString stringWithFormat:@"%@",[buildingidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
   
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  
    if (pickerView == buildingpicker)
    {
        return [buildingarr objectAtIndex:row];
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
    
    
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
   
    
  
    if (textField ==buildingtxt) {
  
        //
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
        
        buildingtoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:buildingtoolbar];
        
        buildingtoolbar.hidden=NO;
        return NO;
    }
   
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
   
    if ([pickerView isEqual: buildingpicker]) {
        return [buildingarr count];
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

-(IBAction)doneBtnPressed1{
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
    
    if ([buildingstr isEqualToString:@""] || buildingstr==nil) {
        if (buildingarr.count>0) {
            buildingtxt.text=[buildingarr objectAtIndex:0];
            buildingidstr=[buildingidarr objectAtIndex:0];
        }
    }
    else{
        buildingtxt.text=buildingstr;
    }
    [self getflowerunit:buildingidstr];
}


-(IBAction)cancelBtnpress{
  
    buildingtoolbar.hidden=YES;
    buildingpicker.hidden=YES;
  
}



//-(void)sortbycheckbox
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    acttyindicator.frame = CGRectMake(screenRect.size.width *0.30, screenRect.size.height *0.0, screenRect.size.width *0.10,screenRect.size.width *0.10);
//    //    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
//    [buildingtxt addSubview:acttyindicator];
//
//    NSString* encodedUrl = [protypetxt.text stringByAddingPercentEscapesUsingEncoding:
//                            NSUTF8StringEncoding];
//    [acttyindicator startAnimating];
//    NSString* premstr;
//    if (checkboxbtn.selected) {
//        premstr=@"1";
//    }
//    else
//        premstr=@"0";
//
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"get_buildings_by_value"  forKey:@"requestType"];
//    [params setObject:projectidstr  forKey:@"projectId"];
//    [params setObject:encodedUrl  forKey:@"unit_type"];
//    [params setObject:sizetxt.text  forKey:@"unit_size"];
//    [params setObject:valuetxt.text  forKey:@"unit_value"];
//    [params setObject:premstr  forKey:@"unit_premium"];
//    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
//
//    [acttyindicator startAnimating];
//
//    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        buildingarr=[[NSMutableArray alloc]init];
//        buildingidarr=[[NSMutableArray alloc]init];
//        _floorarr=[[NSMutableArray alloc]init];
//        [collectioonview reloadData];
//        buildingtxt.text=@"";
//
//        NSLog(@"JSON: %@", userDict);
//        NSMutableArray *build=[[userDict objectForKey:@"Android"] objectForKey:@"buildings"];
//        for (int i=0; i<build.count;i++) {
//            NSMutableDictionary *dict=[build objectAtIndex:i];
//            [buildingarr addObject:[dict objectForKey:@"name"]];
//            [buildingidarr addObject:[dict objectForKey:@"id"]];
//        }
//
//        [acttyindicator stopAnimating];
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [acttyindicator stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
//}

-(void)getflowerunit:(NSString*)str
{
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"get_floors_units"  forKey:@"requestType"];
//    [params setObject:str  forKey:@"buildingId"];
//    [params setObject:projectidstr forKey:@"projectId"];
//
//    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getinventorydata.php?",[prefs objectForKey:@"Link"]];
//    [indicator startAnimating];
//
//    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"JSON: %@", userDict);
//        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
//        _floorarr=[[NSMutableArray alloc]init];
//        _floorarr=[dic objectForKey:@"inventory_data"];
//        [indicator stopAnimating];
//        [collectioonview reloadData];
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [indicator stopAnimating];
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
}

-(void)closeAlert:(id)sender{
    [TakePhotoView close];
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
