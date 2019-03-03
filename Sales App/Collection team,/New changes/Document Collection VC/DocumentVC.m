

#import "DocumentVC.h"
#import "DocFollowupCell.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "DocImageVC.h"

@interface DocumentVC (){
     CGRect screenRect;
    UIActivityIndicatorView *indicator;
    NSMutableArray *resultArray;
    UIButton *backBtn;
    bool isFollowupClicked;
}

@end

@implementation DocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    screenRect = [[UIScreen mainScreen] bounds];
    isFollowupClicked = true;
    [_btnDocFollowup setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]];
    [_btnDocHomeVisit setBackgroundColor:[UIColor grayColor]];
//
    [self loadDocFollowupData];
//
//    _btnFollowup.tag = 1;
//    _btnHomeVisit.tag = 1;
    _myTableview.delegate  = self;
    _myTableview.dataSource = self;
    isFollowupClicked = true;
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
     horizontallbl.text = @"DOC";
//    if ([ocrStr isEqualToString:@"OCRStr"]){
//        horizontallbl.text = @"OCR";
//        
//    }else if ([sdcStr isEqualToString:@"SDCStr"]){
//        horizontallbl.text = @"SDC";
//        
//    }else{
//        horizontallbl.text = @"BAC";
//        
//    }
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
    
    
   // [self loadDocFollowupData];

    
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
-(void)loadDocFollowupData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
  NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getdoccollection.php"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    // [params setObject:userId forKey:@"user_id"];
    //************REMOVE HARDCODE********//
     [params setObject:@"74563cbf-d690-f45f-8916-599acc92ae49" forKey:@"user_id"];
    [params setObject:@"getBookings" forKey:@"requestType"];
   [params setObject:@"BS" forKey:@"mode"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        printf("%@", userDict);
        self->resultArray = [[NSMutableArray alloc]init];
        self->resultArray = userDict[@"Android"][@"bookings"];
        [self.myTableview reloadData];
        [self->indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self->indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}
//-(void)viewWillAppear:(BOOL)animated{
//    [self loadDocFollowupData];
//}

- (IBAction)btnDocFollowupClicked:(id)sender {
    isFollowupClicked = true;
    [_btnDocFollowup setBackgroundColor:[UIColor colorWithHexString:@"#004c00"]];
    [_btnDocHomeVisit setBackgroundColor:[UIColor grayColor]];
    [self loadDocFollowupData];
}
- (IBAction)btnDocHomeVisitClicked:(id)sender {
}

//UiTableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray.count;
    //return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 213;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    DocFollowupCell *cell = (DocFollowupCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DocFollowupCell" owner:self options:nil] objectAtIndex:0];
    }
        NSArray *tempObj = resultArray[indexPath.row];
        cell.lblProjName.text = [tempObj valueForKey:@"proj_name"];
        cell.lblCustName.text = [tempObj valueForKey:@"name1"];
        cell.lblFollowupStatus.text = [tempObj valueForKey:@"fstatus"];
        cell.lblUnitNo.text = [tempObj valueForKey:@"unit_no"];
        cell.lblMobNo.text = [tempObj valueForKey:@"mobile"];
    
    cell.btnUploadDoc.tag = indexPath.row;
    [cell.btnUploadDoc addTarget:self action:@selector(UploadDocBtnClicked:) forControlEvents: UIControlEventTouchUpInside];
    
    return cell;
}
-(void)UploadDocBtnClicked:(UIButton*)sender{
    DocImageVC *Objvc = [[DocImageVC alloc] initWithNibName:@"DocImageVC" bundle:nil];
    Objvc.InfoDict = resultArray[sender.tag];
    
    [[self navigationController] pushViewController:Objvc animated:YES];
}
@end
