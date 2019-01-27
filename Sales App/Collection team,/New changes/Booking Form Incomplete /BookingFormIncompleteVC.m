//
//  BookingFormIncompleteVC.m
//  Sales App
//
//  Created by Infinitum on 11/01/19.
//  Copyright © 2019 Infinitumus.com. All rights reserved.
//

#import "BookingFormIncompleteVC.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ChangeStatusBkngFormIncVC.h"


@interface BookingFormIncompleteVC (){
    CGRect screenRect;
    NSArray *Pickerdata;
    NSString * CallStr;
    NSUserDefaults *DIDstr;
    NSMutableArray *bookingarr;
    NSMutableArray *resultArray2;
    NSString *datestr ;
    bool isfromChangeStatusbkng;


}

@end

@implementation BookingFormIncompleteVC
UIActivityIndicatorView *indicator2;
NSMutableArray *resultArray2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
     screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.70,screenRect.size.height*0.07)]; //64
    // horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Booking Form Incomplete";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
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

    
    [self loadBookingFormIncompleteData];

}
- (void)viewWillAppear:(BOOL)animated{
    [self loadBookingFormIncompleteData];
}
-(void)loadBookingFormIncompleteData{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
      NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getformincomplete.php"];

    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"userid"];
    [params setObject:@"getform" forKey:@"requestType"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator2 startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self->resultArray2 = [[NSMutableArray alloc]init];
        self->resultArray2 = userDict[@"Android"][@"projects"];
       // printf("%s", resultArray2);
        if(![self->resultArray2 isKindOfClass:[NSNull class]] && self->resultArray2.count>0){
            [self.myTableView reloadData];
            }
        [indicator2 stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator2 stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}
//Tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray2.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 236;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    BookingFormIncompleteCustCell *cell = (BookingFormIncompleteCustCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BookingFormIncompleteCustCell" owner:self options:nil] objectAtIndex:0];
    }
//    if ([dict objectForKey:@"faqQues"] == [NSNull null]) {
//        // value is null, use your own value here
//    } else {
//        // good value to use
//    }
    NSMutableDictionary *tempObj = resultArray2[indexPath.row];
    if ([tempObj objectForKey:@"bknum"] == [NSNull null]){
        cell.lblBookingNumber.text = @"null";
    }else{
        cell.lblBookingNumber.text = [tempObj valueForKey:@"bknum"];
    }
   // cell.lblBookingNumber.text = [tempObj valueForKey:@"bknum"];
    if ([tempObj objectForKey:@"scheme"] == [NSNull null]){
        cell.lblScheme.text = @"null";
    }else{
        cell.lblScheme.text = [tempObj valueForKey:@"scheme"];
    }
    //cell.lblScheme.text = [tempObj valueForKey:@"scheme"];
    if ([tempObj objectForKey:@"unit_no"] == [NSNull null]){
        cell.lblUnitNo.text = @"null";
    }else{
        cell.lblUnitNo.text = [tempObj valueForKey:@"unit_no"];
    }
    //cell.lblUnitNo.text = [tempObj valueForKey:@"unit_no"];
    if ([tempObj objectForKey:@"name"] == [NSNull null]){
        cell.lblCustName.text = @"null";
    }else{
        cell.lblCustName.text = [tempObj valueForKey:@"name"];
    }
   // cell.lblCustName.text = [tempObj valueForKey:@"name"];
    if ([tempObj objectForKey:@"project_id"] == [NSNull null]){
        cell.lblProjName.text = @"null";

    }else{
        cell.lblProjName.text = [tempObj valueForKey:@"project_id"];
    }
   // cell.lblProjName.text = [tempObj valueForKey:@"project_id"];
    if ([tempObj objectForKey:@"date"] == [NSNull null]){
        cell.lblBookingDate.text = @"null";
        
    }else{
        cell.lblBookingDate.text = [tempObj valueForKey:@"date"];
    }
   // cell.lblBookingDate.text = [tempObj valueForKey:@"date"];
    if ([tempObj objectForKey:@"ctype"] == [NSNull null]){
        cell.lblCustomerType.text = @"null";
        
    }else{
        cell.lblCustomerType.text = [tempObj valueForKey:@"ctype"];
    }
    //cell.lblCustomerType.text = [tempObj valueForKey:@"ctype"];
    
    //indexpath for change status
    cell.btnChangeStatusBkng.tag = indexPath.row;
    [cell.btnChangeStatusBkng addTarget:self action:@selector(ChangeStatusBkngClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnCallBkng.tag = indexPath.row;
    [cell.btnCallBkng addTarget:self action:@selector(CallBkngClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
-(void)ChangeStatusBkngClicked:(UIButton*)sender{
    // ChangeStatusVC *vc = [[ChangeStatusVC alloc] initWithNibName:@"ChangeStatusVC" bundle:nil];
    ChangeStatusBkngFormIncVC *VC = [[ChangeStatusBkngFormIncVC alloc] initWithNibName:@"ChangeStatusBkngFormIncVC" bundle:nil];
    VC.dictChangeStatusbkng = resultArray2[sender.tag];
     [self presentViewController:VC animated:YES completion:nil];
    
}
-(void)CallBkngClicked:(UIButton*)sender{
    NSLog(@"%ld", (long)sender.tag);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getdid.php"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:@"getdid" forKey:@"requestType"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator2 startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *msg = [[userDict valueForKey:@"Android"] valueForKey:@"retpitem"];
        CallStr = [DIDstr objectForKey:msg];
        //Call this webservice aftr getting response
        //[self loadCallService:(int)sender.tag];
        [self loadCallService:(int)sender.tag];
        NSLog(@"CallStr");
        [indicator2 stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator2 stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
    
}

-(void)loadCallService: (int)selectedIndex{
    NSMutableDictionary * dict= bookingarr;
    NSString * str;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"xrbia"  forKey:@"userName"];
    [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
    [params setObject:[[resultArray2 objectAtIndex:selectedIndex] valueForKey:@"mobile"] forKey:@"custNumber"];
    [params setObject:[prefs objectForKey:@"user_name"] forKey:@"phoneName"];
    
    //if ([CallStr isEqualToString:@""]){
    if ((CallStr == (id)[NSNull null] || CallStr.length == 0 )){
        [params setObject:[prefs objectForKey:@"did_no"] forKey:@"did"];
    }else
    {
        [params setObject:CallStr forKey:@"did"];
    }
    [params setObject:@"1000" forKey:@"callLimit"];
    [params setObject:@"sap_test" forKey:@"uui"];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator2 startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        
        if ([[userDict objectForKey:@"status"]isEqualToString:@"queued"]) {
            // [self savedata:dict:[userDict objectForKey:@"message"]:str];
            // [self savedata:tempObj :[userDict objectForKey:@"message"] :str];
            [self savedata:[resultArray2 objectAtIndex:selectedIndex] :[userDict objectForKey:@"message"]];
        }
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"status"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [indicator2 stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator2 stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)savedata:(NSMutableDictionary*)tempObj :(NSString*)message
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    datestr = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
     [params setObject:@"module"  forKey:@"INCO"];
    [params setObject:[tempObj valueForKey:@"mobile"] forKey:@"mobile"];
    // [params setObject:[dict objectForKey:@"name"] forKey:@"name"];
    //[params setObject:[dict objectForKey:@"project_id"] forKey:@"projectname"];
    
    [params setObject:[tempObj valueForKey:@"name"] forKey:@"name"];
    [params setObject:[tempObj valueForKey:@"project_id"] forKey:@"projectname"];
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"userid"];
    [params setObject:datestr forKey:@"date"];
    [params setObject:message forKey:@"message"];
    [params setObject:@"queued" forKey:@"status"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator2 startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        if ([[userDict objectForKey:@"status"]intValue] ==1) {
            
        }
        //Change Status
        ChangeStatusBkngFormIncVC *VC = [[ChangeStatusBkngFormIncVC alloc] initWithNibName:@"ChangeStatusBkngFormIncVC" bundle:nil];
        VC.dictChangeStatusbkng = tempObj;
       // VC.isFromChangeStatusBtn = isfromChangeStatusbkng;
        VC.isFromChangeStatusBtn = true;

        [self presentViewController:VC animated:YES completion:nil];
        
        
        [indicator2 stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator2 stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
@end
