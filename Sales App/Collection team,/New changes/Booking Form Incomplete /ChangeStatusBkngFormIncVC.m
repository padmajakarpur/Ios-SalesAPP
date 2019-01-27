

#import "ChangeStatusBkngFormIncVC.h"
#import <AFNetworking.h>

@interface ChangeStatusBkngFormIncVC (){
    NSArray *pickerArr;
    BOOL checked;
    NSString *selectedCustType;
    UIActivityIndicatorView *indicator2;
        NSString *datestr ;
}

@end

@implementation ChangeStatusBkngFormIncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
   // _isFromChangeStatusBtn = true;
    
    if (_isFromChangeStatusBtn){
        _btnCancel.hidden = true;
        _xpositionchangestatusbkng.constant = 80;
        _trailingChangeStatbkng.constant = -60;
            }else{
        _btnCancel.hidden = false;
    }
    
     pickerArr = @[@"Salary in bank",@"Salary by cash",@"Business transaction in bank",@"Business transaction in cash"];
    //Picker view
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _txtEmployerDetails.delegate = self;
    
    UIToolbar *toolBarPicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    [toolBarPicker setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedPicker)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [toolBarPicker setItems:[NSArray arrayWithObjects:space,doneBtn1, nil]];
    [_txtPickerView setInputAccessoryView:toolBarPicker];
    [_txtPickerView setInputView:pickerView];
    
    _txtEmployerDetails.hidden = YES;
    _heightConstraintBusDet.constant = 0;

    [self grayoutAll];
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.txtEmployerDetails.inputAccessoryView = keyboardToolbar;
 
    indicator2 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator2.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator2.color=[UIColor whiteColor];
    indicator2.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator2];
    [indicator2 bringSubviewToFront:self.view];
    indicator2.layer.cornerRadius=15.0f;

}
-(void)yourTextViewDoneButtonPressed
{
    [self.txtEmployerDetails resignFirstResponder];
}

-(void)grayoutAll{
    [_imgForm16 setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnForm16.userInteractionEnabled = false;
    _viewform16.alpha = 0.5;
    
    [_imgSalSlip setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnSalarySlip.userInteractionEnabled = false;
    _viewSalSlip.alpha = 0.5;
    
    [_imgBankStat setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnBankStat.userInteractionEnabled = false;
    _viewBankStat.alpha = 0.5;
    
    [_imgBadge setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnBadge.userInteractionEnabled = false;
    _viewBadge.alpha = 0.5;
    
    [_imgIPR setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnIPR.userInteractionEnabled = false;
    _viewIPR.alpha = 0.5;
    
    [_imgEmployerCer setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnEmployerCer.userInteractionEnabled = false;
    _viewEmploymentCer.alpha = 0.5;
    
    [_imgProofofBus setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnProofofBus.userInteractionEnabled = false;
    _viewProofofBus.alpha = 0.5;
    
    [_imgAppointmentRep setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnAppointmentRep.userInteractionEnabled = false;
    _viewAppointmentRep.alpha = 0.5;
    
    [_imgShopAct setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnShopAct.userInteractionEnabled = false;
    _viewShopAct.alpha = 0.5;
    
    [_imgInvestigationRep setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnInvestigationRep.userInteractionEnabled = false;
    _viewInvestigationRep.alpha = 0.5;
    
    [_imgPDAss setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnPDAssessment.userInteractionEnabled = false;
    _viewPDAssesment.alpha = 0.5;
}
-(void)salaryInBankSelected{
    [_imgForm16 setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnForm16.userInteractionEnabled = true;
    _viewform16.alpha = 2.0;
    
    [_imgSalSlip setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnSalarySlip.userInteractionEnabled = true;
    _viewSalSlip.alpha = 2.0;
    
    [_imgBankStat setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnBankStat.userInteractionEnabled = true;
    _viewBankStat.alpha = 2.0;
    
    [_imgAppointmentRep setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnAppointmentRep.userInteractionEnabled = true;
    _viewAppointmentRep.alpha = 1.5;
    
    [_imgSalSlip setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnSalarySlip.userInteractionEnabled = true;
    _viewSalSlip.alpha = 1.5;

    
    _txtEmployerDetails.hidden = YES;
    _heightConstraintBusDet.constant = 0;
    
}

-(void)salaryByCashSelected{
    [_imgSalSlip setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnSalarySlip.userInteractionEnabled = true;
    _viewSalSlip.alpha = 1.0;
    
    [_imgBankStat setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnBankStat.userInteractionEnabled = true;
    _viewBankStat.alpha = 1.0;
    
    [_imgEmployerCer setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnEmployerCer.userInteractionEnabled = true;
    _viewEmploymentCer.alpha = 1.0;
    
    [_imgInvestigationRep setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnInvestigationRep.userInteractionEnabled = true;
    _viewInvestigationRep.alpha = 1.0;
    
    _txtEmployerDetails.hidden = NO;
    _txtEmployerDetails.placeholder = @"Employer Details";
    _heightConstraintBusDet.constant = 45.0;

}

-(void)BusinesstransactioninbankSelected{
    [_imgBankStat setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnBankStat.userInteractionEnabled = true;
    _viewBankStat.alpha = 1.0;
    
    [_imgIPR setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnIPR.userInteractionEnabled = true;
    _viewIPR.alpha = 1.0;
    
    [_imgProofofBus setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnProofofBus.userInteractionEnabled = true;
    _viewProofofBus.alpha = 1.0;
    
    [_imgShopAct setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnShopAct.userInteractionEnabled = true;
    _viewShopAct.alpha = 1.0;
    
    _txtEmployerDetails.hidden = YES;
    _heightConstraintBusDet.constant = 0;


}
-(void)BusinesstransactionincashSelected{
    
    [_imgBadge setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnBadge.userInteractionEnabled = true;
    _viewBadge.alpha = 1.0;
    
    [_imgProofofBus setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnProofofBus.userInteractionEnabled = true;
    _viewProofofBus.alpha = 1.0;
    
    [_imgPDAss setImage:[UIImage imageNamed:@"uncheck1"]];
    _btnPDAssessment.userInteractionEnabled = true;
    _viewPDAssesment.alpha = 1.0;
    
    _txtEmployerDetails.hidden = NO;
    _txtEmployerDetails.placeholder = @"Business Details";
    _heightConstraintBusDet.constant = 45.0;

    
}
-(void)ShowSelectedPicker{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    _txtPickerView.text = [pickerArr objectAtIndex:selectedRow];
    [_txtPickerView resignFirstResponder];
    
    [self grayoutAll];
    if ([_txtPickerView.text isEqualToString:@"Salary in bank"]) {
        selectedCustType = @"SalaryBank";
        [self salaryInBankSelected];
       }else if
           
        ([_txtPickerView.text isEqualToString:@"Salary by cash"]){
            selectedCustType = @"SalaryCash";
            [self salaryByCashSelected];
            
        }else if ([_txtPickerView.text isEqualToString:@"Business transaction in bank"]){
            selectedCustType = @"BusinessBank";
            [self BusinesstransactioninbankSelected];
            
        }else{
            selectedCustType = @"BusinessCash";
            [self BusinesstransactionincashSelected];
           }
    }
- (void)myButtonTapped{
//    if (_btnForm16.isSelected ==  true) {
//        _btnForm16.isSelected = NO;
//    }else {
//        _btnForm16.isSelected = YES;
//    }
}

//Pickerview Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArr.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return pickerArr[row];
}

- (IBAction)btnSelectCustTypeClicked:(id)sender {

}

//All button action
- (IBAction)btnSalSlipTapped:(id)sender {
    if (_imgSalSlip.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgSalSlip setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgSalSlip setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnForm16Tapped:(id)sender {
    if (_imgForm16.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgForm16 setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgForm16 setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnBankStatementTapped:(id)sender {
    if (_imgBankStat.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgBankStat setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgBankStat setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnBadgeTapped:(id)sender {
    if (_imgBadge.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgBadge setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgBadge setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnIPRTapped:(id)sender {
    if (_imgIPR.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgIPR setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgIPR setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnEmpCerTApped:(id)sender {
    if (_imgEmployerCer.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgEmployerCer setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgEmployerCer setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnProofOfBusiTapped:(id)sender {
    if (_imgProofofBus.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgProofofBus setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgProofofBus setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnShopActTapped:(id)sender {
    if (_imgShopAct.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgShopAct setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgShopAct setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnInvestingReportTapped:(id)sender {
    if (_imgInvestigationRep.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgInvestigationRep setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgInvestigationRep setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnPdAssesmentTapped:(id)sender {
    if (_imgPDAss.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgPDAss setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgPDAss setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}
- (IBAction)btnAppointmentLetterTapped:(id)sender {
    if (_imgAppointmentRep.image == [UIImage imageNamed:@"uncheck1"]){
        [_imgAppointmentRep setImage:[UIImage imageNamed:@"checked"]];
        //Chebox cheked
        
    }else{
        [_imgAppointmentRep setImage:[UIImage imageNamed:@"uncheck1"]];
        //ChekboxUncheked
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.//320
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];//460  //320
}
- (IBAction)btnChangeStatusClicked:(id)sender {
    if ([_txtPickerView.text length] != 0){
        [self loadBkngFormIncChangeStatus];

    }else{
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Fields should not be empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
    }

    
    //[self loadBkngFormIncChangeStatus];
}
-(void)loadBkngFormIncChangeStatus{
   NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    ///NSString * userId = [prefs objectForKey:@"user_id"];
    NSString * userId = self.dictChangeStatusbkng[@"id"];

    NSString* urlString = [[NSString alloc]initWithFormat:@"http://13.126.129.245/xrbia/mobilecrm/sales/savemissing.php?"];
    
    
   NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
     [params setObject:userId forKey:@"id"];
     [params setObject:@"get_projects" forKey:@"requestType"];
    if (_imgForm16.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"form_16_c"];
    }else{
        [params setObject:@"0" forKey:@"form_16_c"];
    }
    
    if (_imgBankStat.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"bank_statement_c"];
    }else{
        [params setObject:@"0" forKey:@"bank_statement_c"];
    }
    
    if (_imgIPR.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"ipr_c"];
    }else{
        [params setObject:@"0" forKey:@"ipr_c"];
    }
    
    if (_imgAppointmentRep.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"appointment_letter_c"];
    }else{
        [params setObject:@"0" forKey:@"appointment_letter_c"];
    }
    
    if (_imgSalSlip.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"salary_slip_c"];
    }else{
        [params setObject:@"0" forKey:@"salary_slip_c"];
    }
    
    if (_imgEmployerCer.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"employment_certificate_c"];
    }else{
        [params setObject:@"0" forKey:@"employment_certificate_c"];
    }
    
    if (_imgInvestigationRep.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"investigation_report_c"];
    }else{
        [params setObject:@"0" forKey:@"investigation_report_c"];
    }
    
    if (_imgProofofBus.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"proof_of_business_c"];
    }else{
        [params setObject:@"0" forKey:@"proof_of_business_c"];
    }

    if (_imgShopAct.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"shop_act_c"];
    }else{
        [params setObject:@"0" forKey:@"shop_act_c"];
    }

    if (_imgBadge.image == [UIImage imageNamed:@"checked"]){
        [params setObject:@"1" forKey:@"badge_c"];
    }else{
        [params setObject:@"0" forKey:@"badge_c"];
    }

     if([_txtEmployerDetails.placeholder isEqualToString:@"Business Details"]){
       [params setObject:_txtEmployerDetails.text forKey:@"business_details_c"];
     }
    if([_txtEmployerDetails.placeholder isEqualToString:@"Employer Details"]){
        [params setObject:_txtEmployerDetails.text forKey:@"employer_details_c"];
    }
     [params setObject:selectedCustType forKey:@"customer_type_c"];
    [params setObject:@"" forKey:@"cibil_score_c"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [indicator2 startAnimating];

    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *msg = [[userDict valueForKey:@"Android"] valueForKey:@"projects"];
        [indicator2 stopAnimating];
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator2 stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }];
}
- (IBAction)btnCancelClicked:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
   // [self.view.dis]
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
