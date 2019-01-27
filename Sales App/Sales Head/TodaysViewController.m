//
//  TodaysViewController.m
//  Sales App
//
//  Created by Infinitum on 07/06/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "TodaysViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface TodaysViewController ()

@end

@implementation TodaysViewController
bool isTodayBookingSegment;
@synthesize tableViewHome,indicator,teamarr,segmentedControl,typestr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isTodayBookingSegment = false;
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
    horizontallbl.text=[typestr stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];

//    NSArray *itemArray = [NSArray arrayWithObjects: @"Todays Visit", @"Todays Booking", nil];
// segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
//    segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.11, screenRect.size.width*0.80,screenRect.size.height*0.05);
//    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
//    segmentedControl.selectedSegmentIndex = 0;
//    [self.view addSubview:segmentedControl];
    
//    if (isTodayBookingSegment == true){
//         UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Today's Booking", @"Booking Per Project", nil]];
//        segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.110, screenRect.size.width*0.80, screenRect.size.height*0.050);
//            segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//            segmentedControl.selectedSegmentIndex = 0;
//            segmentedControl.tintColor = [UIColor colorWithHexString:@"#004c00"];
//            [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
//            [self.view addSubview:segmentedControl];
//    }else{
//        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Today's Visit", @"Visit Per Project", nil]];
//        segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.110, screenRect.size.width*0.80, screenRect.size.height*0.050);
//        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//        segmentedControl.selectedSegmentIndex = 0;
//        segmentedControl.tintColor = [UIColor colorWithHexString:@"#004c00"];
//        [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
//        [self.view addSubview:segmentedControl];
//
//    }
    UISegmentedControl *segmentedControl;
    if ([typestr isEqualToString:@"Todays Visit"]) {
       segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Today's Visit", @"Visit Per Project", nil]];
        
    }else{
        segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Today's Booking", @"Booking Per Project", nil]];
    }
    
    segmentedControl.frame = CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.110, screenRect.size.width*0.80, screenRect.size.height*0.050);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithHexString:@"#004c00"];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.17, screenRect.size.width,screenRect.size.height*.89)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewHome.scrollEnabled=YES;
    [self.view addSubview:tableViewHome];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
}
- (void)valueChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        [self getvisit];
        isTodayBookingSegment = false;
       
        //action for the first button (All)
    }else if(segment.selectedSegmentIndex == 1 && [typestr isEqualToString:@"Todays Visit"]){

        //action for the second button (Present)
        [self getVisitPerProject];
         isTodayBookingSegment = true;
    }else if(segment.selectedSegmentIndex == 1){
        [self getBooking];
        isTodayBookingSegment = true;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getvisit];
    //[self getBooking];
}
-(void)getVisitPerProject{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    NSString*   urlString;
    if ([typestr isEqualToString:@"Todays Visit"])  {
        urlString = [[NSString alloc]initWithFormat:@"%@getprojvisit.php?",[prefs objectForKey:@"Link"]];
        [indicator startAnimating];
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            teamarr=[[NSMutableArray alloc]init];
            teamarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"JSON: %@", teamarr);
            
            if (teamarr.count==0) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            [indicator stopAnimating];
            [tableViewHome reloadData];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [indicator stopAnimating];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
}
}

-(void)getvisit
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    NSString*   urlString;
    if ([typestr isEqualToString:@"Todays Visit"])   {
         urlString = [[NSString alloc]initWithFormat:@"%@getfrontdet.php?",[prefs objectForKey:@"Link"]];
        // if(isTodayBookingSegment){
         }
    
    else
  {
      urlString = [[NSString alloc]initWithFormat:@"%@gettodaysbooking.php?",[prefs objectForKey:@"Link"]];
  }
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        teamarr=[[NSMutableArray alloc]init];
        teamarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", teamarr);
        
        if (teamarr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [indicator stopAnimating];
        [tableViewHome reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)getBooking{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];

    [params setObject:@"get_list" forKey:@"requestType"];
    NSString*   urlString;
    urlString = [[NSString alloc]initWithFormat:@"%@totalbooking.php?",[prefs objectForKey:@"Link"]];

    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        teamarr=[[NSMutableArray alloc]init];
        teamarr= resultDict[@"Android"][@"projects"];
        NSLog(@"JSON: %@", teamarr);

        if (teamarr.count==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"No data found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [indicator stopAnimating];
        [tableViewHome reloadData];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Data not found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
  //  [self getvisit];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return teamarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSDictionary *dict=[teamarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
 
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.13)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 0.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.01,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Location:%@",[dict objectForKey:@"location"]];
    
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  mobilelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    mobilelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    mobilelbl.textAlignment = NSTextAlignmentLeft;
    mobilelbl.text =[NSString stringWithFormat:@"Executive: %@",[dict objectForKey:@"attend_name"]];
    mobilelbl.backgroundColor = [UIColor clearColor];
    mobilelbl.textColor=[UIColor blackColor];
    mobilelbl.lineBreakMode = NSLineBreakByWordWrapping;
    mobilelbl.numberOfLines = 0;
    [headerView addSubview:mobilelbl];
    
    UILabel*  datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.09,screenRect.size.width*0.80,screenRect.size.height*0.035)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    datelbl.textAlignment = NSTextAlignmentLeft;
    
    datelbl.text =[NSString stringWithFormat:@"Total attended: %@",[dict objectForKey:@"count"]];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.textColor=[UIColor blackColor];
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    datelbl.numberOfLines = 0;
    [headerView addSubview:datelbl];
    
    if (![typestr isEqualToString:@"Todays Visit"]) {
        Srnolbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"project_name"]];
        mobilelbl.text =[NSString stringWithFormat:@"Executive: %@",[dict objectForKey:@"user_name"]];
        datelbl.text =[NSString stringWithFormat:@"No of booking: %@",[dict objectForKey:@"Count"]];
    }
    
    //check whether segment one is cliked
    if(isTodayBookingSegment){
        Srnolbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"proj_name"]];
        mobilelbl.text = [NSString stringWithFormat:@"No. of booking: %@",[dict objectForKey:@"booking"]];
        datelbl.text = @"";
    }
    if(isTodayBookingSegment && ([typestr isEqualToString:@"Todays Visit"])){
        Srnolbl.text =[NSString stringWithFormat:@"Location:%@",[dict objectForKey:@"location"]];
        mobilelbl.text = [NSString stringWithFormat:@"No. of Visit: %@",[dict objectForKey:@"count"]];
        datelbl.text = @"";
    }
   
    //****Deleted
//    if ([typestr isEqualToString:@"Todays Visit"]){
//    if(isTodayBookingSegment){
//                Srnolbl.text =[NSString stringWithFormat:@"Project:%@",[dict objectForKey:@"proj_name"]];
//                mobilelbl.text = [NSString stringWithFormat:@"No. of booking: %@",[dict objectForKey:@"booking"]];
//                datelbl.text = @"";
//            }
//    }
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
    if (isTodayBookingSegment) {
        return screenRect.size.height*0.145;
    }else{
      return screenRect.size.height*0.145;
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
