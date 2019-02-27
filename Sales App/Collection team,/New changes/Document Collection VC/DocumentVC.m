

#import "DocumentVC.h"
#import "DocFollowupCell.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>{

@interface DocumentVC (){
     CGRect screenRect;
    UIActivityIndicatorView *indicator;
    NSMutableArray *resultArray;
}

@end

@implementation DocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableview.delegate = self;
    _myTableview.dataSource = self;
    screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.70,screenRect.size.height*0.07)]; //64
    // horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Document Collection";
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
    
    
    [self loadDocFollowupData];

    
}
-(void)loadDocFollowupData{
  NSString*   urlString = [[NSString alloc]initWithFormat:@"13.126.129.245/xrbia/mobilecrm/sales/getdoccollection.php"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
     [params setObject:@"74563cbf-d690-f45f-8916-599acc92ae49" forKey:@"user_id"];
    [params setObject:@"getBookings" forKey:@"requestType"];
   [params setObject:@"BS" forKey:@"mode"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
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
-(void)viewWillAppear:(BOOL)animated{
    [self loadDocFollowupData];
}

- (IBAction)btnDocFollowupClicked:(id)sender {
}
- (IBAction)btnDocHomeVisitClicked:(id)sender {
}

//UiTableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 213;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    DocFollowupCell *cell = (DocFollowupCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DocFollowupCell" owner:self options:nil] objectAtIndex:0];
        NSArray *tempObj = resultArray[indexPath.row];
        cell.lblProjName.text = [tempObj valueForKey:@"proj_name"];
        cell.lblCustName.text = [tempObj valueForKey:@"name1"];
        cell.lblFollowupStatus.text = [tempObj valueForKey:@"fstatus"];
        cell.lblUnitNo.text = [tempObj valueForKey:@"unit_no"];
        cell.lblMobNo.text = [tempObj valueForKey:@"mobile"];
       
       }
    return cell;
}


@end
