

#import "TodayBookingBACVC.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "TodaysFollowupsBACCCell.h"
#import "ChangeStatusVC.h"
@interface TodayBookingBACVC (){
    NSMutableArray *bookingarr;
    NSMutableDictionary *tempObj;
    NSString *datestr ;
}

@end

@implementation TodayBookingBACVC
@synthesize ocrStr,str,sdcStr;
 UIActivityIndicatorView *indicator;
 NSMutableArray *resultArray;
 bool isFollowupClicked;
CGRect screenRect;
   UIButton *backBtn;
NSUserDefaults *DIDstr;
NSString * CallStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    //show follow up button enabled
   DIDstr = [NSUserDefaults standardUserDefaults];
    screenRect = [[UIScreen mainScreen] bounds];
    isFollowupClicked = true;
    [_btnFollowup setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]];
    [_btnHomeVisit setBackgroundColor:[UIColor grayColor]];
   
        [self loadBACFollowupData];
    
    _btnFollowup.tag = 1;
    _btnHomeVisit.tag = 1;
    _myTableview.delegate  = self;
    _myTableview.dataSource = self;
 
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];

    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
   
    if ([ocrStr isEqualToString:@"OCRStr"]){
         horizontallbl.text = @"OCR";
   
    }else if ([sdcStr isEqualToString:@"SDCStr"]){
        horizontallbl.text = @"SDC";
       
    }else{
         horizontallbl.text = @"BAC";
        
    }
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    [self addBackButtonWithImageName:@"backwhite"];
    [navigationView addSubview:backBtn];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadBACFollowupData];
}
- (void)addBackButtonWithImageName:(NSString *)imageName {
    // init your custom button, or your custom view

    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
-(void)backButtonPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:true];
}
+ (UIColor *) colorWithHexString: (NSString *)stringToConvert
{
    NSString *string = stringToConvert;
    if ([string hasPrefix:@"#"])
        string = [string substringFromIndex:1];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    unsigned hexNum;
    if (![scanner scanHexInt: &hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}
+ (UIColor *) colorWithRGBHex: (uint32_t)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
- (IBAction)btnHomeVisitClicked:(id)sender {
    isFollowupClicked = false;
    [_btnHomeVisit setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]];
    [_btnFollowup setBackgroundColor:[UIColor grayColor]];
    
         [self loadBACFollowupData];

}
- (IBAction)btnFollowUpClicked:(id)sender {
    isFollowupClicked = true;
     [_btnFollowup setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]];
    [_btnHomeVisit setBackgroundColor:[UIColor grayColor]];
    
        [self loadBACFollowupData];

}
-(void)loadBACFollowupData{
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
//    NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getbacdata.php"];
    NSString*   urlString;
    
    if ([ocrStr isEqualToString:@"OCRStr"]){
        urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getocrdata.php"];
    }else if ([sdcStr isEqualToString:@"SDCStr"]){
        urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getsdcdata.php"];
    }else{
        urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getbacdata.php"];
    }
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
     [params setObject:userId forKey:@"user_id"];
   // [params setObject:@"74563cbf-d690-f45f-8916-599acc92ae49" forKey:@"user_id"];
     [params setObject:@"getBookings" forKey:@"requestType"];
    
    if (isFollowupClicked == true){
        [params setObject:@"BS" forKey:@"mode"];
    }else{
        [params setObject:@"ES" forKey:@"mode"];
    }
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        resultArray = [[NSMutableArray alloc]init];
        resultArray = userDict[@"Android"][@"bookings"];
        //Remove*************************
        //[self removeallNullValueFromArray:resultArray];
        [self.myTableview reloadData];
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    
    }];
    }

-(void)removeallNullValueFromArray :(NSMutableArray *)infoArray{
    
    if (infoArray.count > 0){
    NSMutableArray *newMutableArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in infoArray) {
        [newMutableArray addObject:[dict mutableCopy]];
    }
    
    for (NSMutableDictionary *itemDict in newMutableArray){
        for (NSString * key in [itemDict allKeys])
        {
        if ([[itemDict objectForKey:key] isKindOfClass:[NSNull class]])
                [itemDict setObject:@"" forKey:key];
        }
    }
        
    resultArray = [newMutableArray mutableCopy];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 343;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    TodaysFollowupsBACCCell *cell = (TodaysFollowupsBACCCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TodaysFollowupsBACCCell" owner:self options:nil] objectAtIndex:0];
    }
    if (isFollowupClicked) {
        // followup related code
        
        tempObj = resultArray[indexPath.row];
        cell.lblProjectName.text = [tempObj valueForKey:@"proj_name"];
        cell.lblCustName.text = [tempObj valueForKey:@"name1"];
        cell.lblFollStatus.text = [tempObj valueForKey:@"fstatus"];
        cell.lblFollDate.text = [tempObj valueForKey:@"foll_dt"];
        cell.lblUnitNo.text = [tempObj valueForKey:@"unit_no"];
        cell.lblMobNo.text = [tempObj valueForKey:@"mobile"];
        cell.lblBookingStatus.text = [tempObj valueForKey:@"bkng_stat"];
        cell.lblTotCollection.text = [tempObj valueForKey:@"amt_collected"];
        cell.lblCollBalance.text = [tempObj valueForKey:@"coll_bac"];
      
        
        //Manage title label
        if ([ocrStr isEqualToString:@"OCRStr"]){
            //OCR
            cell.lblTitleAmount.text = @"OCR Amount";
            cell.lblTitleBalance.text = @"OCR balance";
            
            cell.lblBACAmt.text = [tempObj valueForKey:@"ocr_amt"];
            cell.lblBACBal.text = [tempObj valueForKey:@"ocr_balance"];
        }else if ([sdcStr isEqualToString:@"SDCStr"]){
            //SDC
            cell.lblTitleAmount.text = @"SDC Amount";
            cell.lblTitleBalance.text = @"SDC balance";
            
            cell.lblBACAmt.text = [tempObj valueForKey:@"sdc_amt"];
            cell.lblBACBal.text = [tempObj valueForKey:@"sdc_balance"];
        }else{
            //BAC
            cell.lblTitleAmount.text = @"BAC Amount";
            cell.lblTitleBalance.text = @"BAC balance";
            
            cell.lblBACAmt.text = [tempObj valueForKey:@"bac_amt"];
            cell.lblBACBal.text = [tempObj valueForKey:@"bac_balance"];
        }
        cell.btnChangeStatus.tag = indexPath.row;
       
        [cell.btnChangeStatus addTarget:self action:@selector(ChangeStatusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //indexpath for call
         cell.btnCall.tag = indexPath.row;
         [cell.btnCall addTarget:self action:@selector(CallBtnClicked:) forControlEvents: UIControlEventTouchUpInside];
        
        NSLog(@"%@", resultArray);
        
    }else{
        NSArray *tempObj = resultArray[indexPath.row];
        cell.lblProjectName.text = [tempObj valueForKey:@"proj_name"];
        cell.lblCustName.text = [tempObj valueForKey:@"name1"];
        cell.lblFollStatus.text = [tempObj valueForKey:@"fstatus"];
        cell.lblFollDate.text = [tempObj valueForKey:@"foll_dt"];
        cell.lblUnitNo.text = [tempObj valueForKey:@"unit_no"];
        cell.lblMobNo.text = [tempObj valueForKey:@"mobile"];
        cell.lblBookingStatus.text = [tempObj valueForKey:@"bkng_stat"];
        cell.lblTotCollection.text = [tempObj valueForKey:@"amt_collected"];
        cell.lblCollBalance.text = [tempObj valueForKey:@"coll_bac"];
        
        //Manage title label
        if ([ocrStr isEqualToString:@"OCRStr"]){
            //OCR
            cell.lblTitleAmount.text = @"OCR Amount";
            cell.lblTitleBalance.text = @"OCR balance";
            
            cell.lblBACAmt.text = [tempObj valueForKey:@"ocr_amt"];
            cell.lblBACBal.text = [tempObj valueForKey:@"ocr_balance"];
        }else if ([sdcStr isEqualToString:@"SDCStr"]){
            //SDC
            cell.lblTitleAmount.text = @"SDC Amount";
            cell.lblTitleBalance.text = @"SDC balance";
            
            cell.lblBACAmt.text = [tempObj valueForKey:@"sdc_amt"];
            cell.lblBACBal.text = [tempObj valueForKey:@"sdc_balance"];
        }else{
            //BAC
            cell.lblTitleAmount.text = @"BAC Amount";
            cell.lblTitleBalance.text = @"BAC balance";
            
            cell.lblBACAmt.text = [tempObj valueForKey:@"bac_amt"];
            cell.lblBACBal.text = [tempObj valueForKey:@"bac_balance"];
        }
        //rating related code
        NSLog(@"%@", resultArray);
        cell.btnChangeStatus.tag = indexPath.row;
       //indexpath for change status
        [cell.btnChangeStatus addTarget:self action:@selector(ChangeStatusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //indexpath for call
         cell.btnCall.tag = indexPath.row;
        [cell.btnCall addTarget:self action:@selector(CallBtnClicked:) forControlEvents: UIControlEventTouchUpInside];
        
    }
    return  cell;
}

-(void)ChangeStatusBtnClicked:(UIButton*)sender{

    ChangeStatusVC *vc = [[ChangeStatusVC alloc] initWithNibName:@"ChangeStatusVC" bundle:nil];
    vc.dictChangeStatus = resultArray[sender.tag];
    NSString *module;
    if ([ocrStr isEqualToString:@"OCRStr"]){
        if (isFollowupClicked){
            module = @"Today OCR";
        }else{
            module = @"Home OCR";
        }

    }else if ([sdcStr isEqualToString:@"SDCStr"]){
        if (isFollowupClicked){
            module = @"Today SDC";
        }else{
            module = @"Home SDC";
        }

    }else{
        if (isFollowupClicked){
            module = @"Today BAC";
        }else{
            module = @"Home BAC";
        }


    }
      vc.moduleType = module;
    vc.isFromChangeStatusBtn = true;

    [self presentViewController:vc animated:YES completion:nil];
}

//for call
-(void)CallBtnClicked:(UIButton*)sender{
    NSLog(@"%ld", (long)sender.tag);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getdid.php"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:@"getdid" forKey:@"requestType"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *msg = [[userDict valueForKey:@"Android"] valueForKey:@"retpitem"];
        CallStr = [DIDstr objectForKey:msg];
        //Call this webservice aftr getting response
        [self loadCallService:(int)sender.tag];
        NSLog(@"CallStr");
        [indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
    
}
//-(void)loadCallService:(UIButton*)btn{
-(void)loadCallService: (int)selectedIndex{
    //NSMutableDictionary * dict=[bookingarr objectAtIndex:btn.tag];
   // NSString * str;
//    if ([btn.titleLabel.text isEqualToString:@"Call-1"]) {
//        str=[dict objectForKey:@"mobile"];
//    }
//    else
//        str=[dict objectForKey:@"mobile2"];
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dict objectForKey:@"phone_mobile"]]]];
    //NSMutableDictionary * dict=[bookingarr objectAtIndex:btn.tag];
    NSMutableDictionary * dict= bookingarr;
    NSString * str;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = @"http://cloudagent.in/CAServices/PhoneManualDial.php?";
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"xrbia"  forKey:@"userName"];
    [params setObject:@"KK9ef6a800420862e3eb8da94bb6288534" forKey:@"apiKey"];
    [params setObject:[[resultArray objectAtIndex:selectedIndex] valueForKey:@"mobile"] forKey:@"custNumber"];
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
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        
        if ([[userDict objectForKey:@"status"]isEqualToString:@"queued"]) {
           // [self savedata:dict:[userDict objectForKey:@"message"]:str];
           // [self savedata:tempObj :[userDict objectForKey:@"message"] :str];
            [self savedata:[resultArray objectAtIndex:selectedIndex] :[userDict objectForKey:@"message"]];
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

//-(void)savedata:(NSMutableDictionary*)dict :(NSString*)message :(NSString*) mobile
//-(void)savedata:(NSMutableDictionary*)tempObj :(NSString*)message :(NSString*) mobile
-(void)savedata:(NSMutableDictionary*)tempObj :(NSString*)message
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    datestr = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@savecallsdata.php",[prefs objectForKey:@"Link"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"Savecalldata"  forKey:@"requestType"];
   // [params setObject:@"module"  forKey:@"INC"];
    NSString *module;
    if ([ocrStr isEqualToString:@"OCRStr"]){
        if (isFollowupClicked){
            module = @"Today OCR";
        }else{
            module = @"Home OCR";
        }
        
    }else if ([sdcStr isEqualToString:@"SDCStr"]){
        if (isFollowupClicked){
            module = @"Today SDC";
        }else{
            module = @"Home SDC";
        }
        
    }else{
        if (isFollowupClicked){
            module = @"Today BAC";
        }else{
            module = @"Home BAC";
        }
    }
    [params setObject:module forKey:@"module"];
    [params setObject:[tempObj valueForKey:@"mobile"] forKey:@"mobile"];
   // [params setObject:[dict objectForKey:@"name"] forKey:@"name"];
    //[params setObject:[dict objectForKey:@"project_id"] forKey:@"projectname"];
    
    [params setObject:[tempObj valueForKey:@"name1"] forKey:@"name"];
    [params setObject:[tempObj valueForKey:@"proj_name"] forKey:@"projectname"];
    [params setObject:[prefs objectForKey:@"user_id"] forKey:@"userid"];
    [params setObject:datestr forKey:@"date"];
    [params setObject:message forKey:@"message"];
    [params setObject:@"queued" forKey:@"status"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [indicator startAnimating];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"JSON: %@", userDict);
        if ([[userDict objectForKey:@"status"]intValue] ==1) {
            
        }
        //Change Status
        ChangeStatusVC *vc = [[ChangeStatusVC alloc] initWithNibName:@"ChangeStatusVC" bundle:nil];
        vc.isFromChangeStatusBtn = false;
        vc.dictChangeStatus = tempObj;
        [self presentViewController:vc animated:YES completion:nil];
        

        [indicator stopAnimating];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

@end
