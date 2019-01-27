

#import "ChangeStatusVC.h"
#import <AFNetworking.h>
@interface ChangeStatusVC ()
{
    NSArray *dataArr;
    NSDateFormatter *dateFormatter;
}

@end

@implementation ChangeStatusVC
NSArray *data;
UIActivityIndicatorView *indicator1;
NSMutableArray *resultArray1;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if (_isFromChangeStatusBtn){
        _cancelBtn.hidden = false;
    }else{
        _cancelBtn.hidden = true;
    }
    self.view.opaque = YES;
   // dataArr = @[@"Salary in bank",@"Salary by cash",@"Business transaction in bank",@"Business transaction in cash"];
  dataArr= @[@"Followup",@"Not Responding",@"BAC Collected"];

    
    
    //datePicker
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 280, 40)]; //320 280
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [_txtDateSelection setInputAccessoryView:toolBar];
    [_txtDateSelection setInputView:datePicker];

    //Picker view
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;

    UIToolbar *toolBarPicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    [toolBarPicker setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedPicker)];
    UIBarButtonItem *space1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [toolBarPicker setItems:[NSArray arrayWithObjects:space1,doneBtn1, nil]];
    [_txtPickerView setInputAccessoryView:toolBarPicker];
    [_txtPickerView setInputView:pickerView];

    //show done button on remark text field click
    UIToolbar *toolBarRemark = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    [toolBarRemark setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn2 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(remarkDoneButtonTapped)];
    UIBarButtonItem *space2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

    [toolBarRemark setItems:[NSArray arrayWithObjects:space2,doneBtn2, nil]];
    [_txtRemark setInputAccessoryView:toolBarRemark];
    
    //get current time date
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);

    indicator1 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator1.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator1.color=[UIColor whiteColor];
    indicator1.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator1];
    [indicator1 bringSubviewToFront:self.view];
    indicator1.layer.cornerRadius=15.0f;


}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

-(void)remarkDoneButtonTapped{
    [_txtRemark resignFirstResponder];
}
-(void)ShowSelectedPicker{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    _txtPickerView.text = [dataArr objectAtIndex:selectedRow];
    [_txtPickerView resignFirstResponder];
}
-(void)ShowSelectedDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MMM/YYYY"];
    _txtDateSelection.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [_txtDateSelection resignFirstResponder];
}


- (IBAction)btnCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnChangeStatusClicked:(id)sender {
    if (([_txtPickerView.text length] != 0) && ([_txtDateSelection.text length] != 0) && ([_txtRemark.text length] != 0)){
    [self loadChangeStatusData];
    }else{
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Fields should not be empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
    }
}
//Pickerview Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return dataArr.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return dataArr[row];
}
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    _lblSelectStatus.text = dataArr[row];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [self.view endEditing:true];
}

-(void)loadChangeStatusData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * userId = [prefs objectForKey:@"user_id"];
      NSString* urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/savestatus.php"];

    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:@"get_projects" forKey:@"requestType"];
    [params setObject:[_dictChangeStatus valueForKey:@"bknum"] forKey:@"bknum"];
    [params setObject:dateFormatter forKey:@"datetime"];
 [params setObject:[_dictChangeStatus valueForKey:@"foll_dt"] forKey:@"follow_date"];
    [params setObject:_txtPickerView.text forKey:@"fstatus"];
[params setObject:_txtRemark.text forKey:@"remark"];


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [indicator1 startAnimating];

    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *msg = [[userDict valueForKey:@"Android"] valueForKey:@"projects"];
        [indicator1 stopAnimating];
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        [self dismissViewControllerAnimated:YES completion:nil];
    
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator1 stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }];
}


@end
