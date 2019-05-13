

#import "InventoryDetailsVC.h"
#import "UIColor+Expanded.h"
#import "InventoryDetailsCustomCell.h"
#import <AFNetworking.h>

@interface InventoryDetailsVC (){
     CGRect screenRect;
    UIActivityIndicatorView *indicator;
    NSMutableArray *resultArray;
    NSMutableArray *resultArray1;
    UIButton *backBtn;
   
    NSArray *demoArray;
    UIPickerView *pickerView;
  
    NSString *textStr;
    UIToolbar *toolBar;
   
}

@end

@implementation InventoryDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableview.delegate = self;
    _myTableview.dataSource = self;
    //demoArray = @[@"Followup",@"Not Responding",@"BAC Collected"];
    
    
    screenRect = [[UIScreen mainScreen] bounds];
   
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text = @"Inventory Details";
    
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
    
    //Picker view
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    UIToolbar *toolBarPicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    [toolBarPicker setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedPicker)];
    UIBarButtonItem *space1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//     UIBarButtonItem *Cancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(ShowCancel)];
    UIBarButtonItem *Cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(ShowCancel)];
    [toolBarPicker setItems:[NSArray arrayWithObjects:doneBtn1,space1,Cancel, nil]];
    [_txtProjectList setInputAccessoryView:toolBarPicker];
    [_txtProjectList setInputView:pickerView];
  
    //for hide keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}
-(void)dismissKeyboard {
    [_txtUnit_no resignFirstResponder];
   
}
-(void)ShowCancel{
    [self.view endEditing:YES];
    
}
-(void)ShowSelectedPicker{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
   // _txtProjectList.text = [resultArray objectAtIndex:selectedRow];
    NSArray *tempObj = [resultArray objectAtIndex:selectedRow];
    self.txtProjectList.text = [tempObj valueForKey:@"name"];
    [_txtProjectList resignFirstResponder];
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
//UiTableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger numofSections = 0;
    if ((resultArray1 == (id)[NSNull null] || [resultArray1 count] == 0)) {
        
        UILabel * DataLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
        DataLable.text = @"No data available";
        DataLable.textAlignment = UITextAlignmentCenter;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundView = DataLable;
    }else{
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        numofSections = 1;
        tableView.backgroundView = nil;
    }
    return numofSections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray1.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    InventoryDetailsCustomCell *cell = (InventoryDetailsCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InventoryDetailsCustomCell" owner:self options:nil] objectAtIndex:0];
    }
    NSArray *tempObj = resultArray1[indexPath.row];
   //
    if ([tempObj valueForKey:@"project_name"] == [NSNull null]) {
        cell.lblProjName.text = @"";
    }else{
        cell.lblProjName.text = [tempObj valueForKey:@"project_name"];
    }
    
   
    if ([tempObj valueForKey:@"unit_number"] == [NSNull null]) {
        cell.lblUnit_No.text = @"";
    }else{
        cell.lblUnit_No.text = [tempObj valueForKey:@"unit_number"];
    }
    
    if ([tempObj valueForKey:@"flat_cat"] == [NSNull null]) {
        cell.lblFlatCat.text = @"";
    }else{
        cell.lblFlatCat.text = [tempObj valueForKey:@"flat_cat"];
    }
    
    if ([tempObj valueForKey:@"unit_type"] == [NSNull null]) {
        cell.lblUnit_Type.text = @"";
    }else{
         cell.lblUnit_Type.text = [tempObj valueForKey:@"unit_type"];
    }
    
    if ([tempObj valueForKey:@"total_amount_cost"] == [NSNull null]) {
        cell.lblTotAmtCost.text = @"";
    }else{
        cell.lblTotAmtCost.text = [tempObj valueForKey:@"total_amount_cost"];
    }
   
    if ([tempObj valueForKey:@"carpet_area"] == [NSNull null]) {
        cell.lblCarpet_Area.text = @"";
    }else{
        cell.lblCarpet_Area.text = [tempObj valueForKey:@"carpet_area"];
    }
    
    if ([tempObj valueForKey:@"saleable_area"] == [NSNull null]) {
         cell.lblSaleable_Area.text = @"";
    }else{
       cell.lblSaleable_Area.text = [tempObj valueForKey:@"saleable_area"];
    }
    
    if ([tempObj valueForKey:@"agreement_value"] == [NSNull null]) {
        cell.lblAgreementValue.text = @"";
    }else{
        cell.lblAgreementValue.text = [tempObj valueForKey:@"agreement_value"];
    }
    
    if ([tempObj valueForKey:@"unit_status"] == [NSNull null]) {
        cell.lblUnit_Status.text = @"";
    }else{
        cell.lblUnit_Status.text = [tempObj valueForKey:@"unit_status"];
    }
    
    
    return cell;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self loadProjectListData];
}
-(void)loadProjectListData{
    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   // NSString * userId = [prefs objectForKey:@"user_id"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getsyncproject.php?"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
   // [params setObject:userId forKey:@"user_id"];
    //************REMOVE HARDCODE********//
    // [params setObject:@"74563cbf-d690-f45f-8916-599acc92ae49" forKey:@"user_id"];
   // [params setObject:@"get_list" forKey:@"requestType"];
   // [params setObject:@"BS" forKey:@"mode"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        printf("%@", userDict);
        self->resultArray = [[NSMutableArray alloc]init];
        self->resultArray = userDict[@"Android"][@"projects"];
       // [self.myTableview reloadData];
        [self->indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self->indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [resultArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //return [resultArray objectAtIndex:row];
    NSArray *tempObj = [resultArray objectAtIndex:row];
    return [tempObj valueForKey:@"name"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //self.txtProjectList.text=[resultArray objectAtIndex:row];
     NSArray *tempObj = [resultArray objectAtIndex:row];
    self.txtProjectList.text = [tempObj valueForKey:@"name"];
}
- (IBAction)btnSubmitClicked:(id)sender {
    if([_txtProjectList.text isEqualToString:@""] || [_txtUnit_no.text isEqualToString:@""] )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Xrbia Sales App" message:@"Fields should not be empty" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }else{
    [self loadSubmitData];
}
}
-(void)loadSubmitData{
    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // NSString * userId = [prefs objectForKey:@"user_id"];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/getinvdetail.php?"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getlist" forKey:@"requestType"];
    [params setObject:[NSString stringWithFormat:@"%@", _txtProjectList.text] forKey:@"proj_name"];
    [params setObject:[NSString stringWithFormat:@"%@", _txtUnit_no.text] forKey:@"unit_no"];
//    [params setObject:@"XRBIA%20MARKET%20YARD" forKey:@"proj_name"];
//     [params setObject:@"A-316" forKey:@"unit_no"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [indicator startAnimating];
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        printf("%@", userDict);
        self->resultArray1 = [[NSMutableArray alloc]init];
        self->resultArray1 = userDict[@"Android"][@"projects"];
         [self.myTableview reloadData];
        [self->indicator stopAnimating];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self->indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
}


@end
