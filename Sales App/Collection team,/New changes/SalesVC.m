

#import "SalesVC.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
@interface SalesVC ()

@end

@implementation SalesVC
 UIButton *back;
 CGRect screenRect1;
 NSMutableArray *myResultArray;
 UIActivityIndicatorView *myActivityIndicator;
- (void)viewDidLoad {
    [super viewDidLoad];
     screenRect1 = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect1.size.width,screenRect1.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
   
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect1.size.width*.18,screenRect1.size.height*0.03,screenRect1.size.width*.64,screenRect1.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect1.size.width*0.055];
    horizontallbl.text=@"Cheque Bounce";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self addBackButtonWithImageName:@"backwhite"];
    [navigationView addSubview:back];
    [self.view addSubview:horizontallbl];
    
    _salesTableView.delegate = self;
    _salesTableView.dataSource = self;
    
    myActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    myActivityIndicator.frame = CGRectMake(screenRect1.size.width *0.35, screenRect1.size.height *0.40, screenRect1.size.width *0.30,screenRect1.size.width *0.30);
    myActivityIndicator.color=[UIColor whiteColor];
    myActivityIndicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:myActivityIndicator];
    [myActivityIndicator bringSubviewToFront:self.view];
    myActivityIndicator.layer.cornerRadius=15.0f;
    
    [self loadSalesData];

}
- (void)addBackButtonWithImageName:(NSString *)imageName {
    // init your custom button, or your custom view
    
    back = [[UIButton alloc]initWithFrame:CGRectMake(0,screenRect1.size.height*0.03,screenRect1.size.width*.18,screenRect1.size.height*.07)];
    [back setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
}
-(void)backBtnPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)loadSalesData{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
     NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/get_bounce.php"];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:@"get_list" forKey:@"requestType"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [myActivityIndicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        myResultArray = [[NSMutableArray alloc]init];
        myResultArray = userDict[@"Android"][@"projects"];
        if(![myResultArray isKindOfClass:[NSNull class]] && myResultArray.count>0){
            [self.salesTableView reloadData];
        }
        [myActivityIndicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [myActivityIndicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myResultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 257;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    SalesTableViewCell *cell = (SalesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SalesTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
        NSArray *tempObj1 = myResultArray[indexPath.row];
        cell.lblBookingNo.text = [tempObj1 valueForKey:@"bknum"];
        cell.lblUnitNo.text = [tempObj1 valueForKey:@"unit_no"];
        cell.lblMgEmpName.text = [tempObj1 valueForKey:@"mg_empname"];
        cell.lblAmt.text = [tempObj1 valueForKey:@"amt"];
        cell.lblChequeDate.text = [tempObj1 valueForKey:@"cheque_date"];
        cell.lblProjName.text = [tempObj1 valueForKey:@"proj_name"];
        cell.lblCustName.text = [tempObj1 valueForKey:@"name1"];
        cell.lblSrEmpName.text = [tempObj1 valueForKey:@"sr_empname"];
    cell.lblChangeNo.text = [tempObj1 valueForKey:@"cheque_no"];
    
   // }
    return  cell;
}
@end
