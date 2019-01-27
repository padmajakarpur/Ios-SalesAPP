//
//  AddVisitViewController.m
//  Sales App
//
//  Created by Infinitum on 16/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "AddVisitViewController.h"
#import "UIColor+Expanded.h"

@interface AddVisitViewController ()
@end

@implementation AddVisitViewController
@synthesize scrollView,projecttxt,mobiletxt,prospextTxt,attendtxt,assignedtxt,prospestagetxt,remarktxt,unitnotxt,scheduledatetxt,datePicker,numberToolbarzip,projectarr,projectstr,projectoolbar,projectpicker,prosjectidarr,appDelegate,leadstr,leadsarr,leadspicker,leadstoolbar,leadsdict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIButton*  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*0.03,screenRect.size.width*0.20,screenRect.size.height*.07)];
    //  [backBtn setTitle:@"\uE5C4" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow_back_white.png"] forState:UIControlStateNormal];
    [navigationView addSubview:backBtn];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* addbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.85,screenRect.size.height*0.03,screenRect.size.width*.10,screenRect.size.height*.07)];
    [addbtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setTitle:@"\uE161" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn.titleLabel setFont:customFontdregs];
    [addbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:addbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Create Visit";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
    CGRect scrollViewFrame1 = CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.10,screenRect.size.width,screenRect.size.height*0.90);
    scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame1];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    int hig=screenRect.size.height*0.02;
    
    prospextTxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    prospextTxt.textAlignment=NSTextAlignmentLeft;
    prospextTxt.delegate = self;
    prospextTxt.textColor=[UIColor blackColor];
    [prospextTxt setBackgroundColor:[UIColor clearColor]];
    prospextTxt.leftViewMode = UITextFieldViewModeAlways;
    [prospextTxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prospextTxt.returnKeyType=UIReturnKeyDone;
    prospextTxt.selectedLineColor = [UIColor redColor];
    prospextTxt.selectedPlaceHolderColor = [UIColor redColor];
    prospextTxt.placeHolderColor = [UIColor grayColor];
    prospextTxt.placeholder=@"Select Prospect";
    prospextTxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:prospextTxt];
    
    hig=hig+screenRect.size.height*0.10;

    mobiletxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    mobiletxt.textAlignment=NSTextAlignmentLeft;
    mobiletxt.delegate = self;
    mobiletxt.textColor=[UIColor blackColor];
    [mobiletxt setBackgroundColor:[UIColor clearColor]];
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    [mobiletxt setKeyboardType:UIKeyboardTypeEmailAddress];
    mobiletxt.returnKeyType=UIReturnKeyDone;
    mobiletxt.selectedLineColor = [UIColor redColor];
    mobiletxt.selectedPlaceHolderColor = [UIColor redColor];
    mobiletxt.placeHolderColor = [UIColor grayColor];
    mobiletxt.placeholder=@"Prospect Mobile";
    mobiletxt.placeholder=@"Mobile*";
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    numberToolbarzip.tintColor=[UIColor whiteColor];
    mobiletxt.inputAccessoryView = numberToolbarzip;
    mobiletxt.leftViewMode = UITextFieldViewModeAlways;
    mobiletxt.keyboardType = UIKeyboardTypeDecimalPad;
    mobiletxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:mobiletxt];
    
    hig=hig+screenRect.size.height*0.10;

    projecttxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    projecttxt.textAlignment=NSTextAlignmentLeft;
    projecttxt.delegate = self;
    projecttxt.textColor=[UIColor blackColor];
    [projecttxt setBackgroundColor:[UIColor clearColor]];
    projecttxt.leftViewMode = UITextFieldViewModeAlways;
    [projecttxt setKeyboardType:UIKeyboardTypeEmailAddress];
    projecttxt.returnKeyType=UIReturnKeyDone;
    projecttxt.selectedLineColor = [UIColor redColor];
    projecttxt.selectedPlaceHolderColor = [UIColor redColor];
    projecttxt.placeHolderColor = [UIColor grayColor];
    projecttxt.placeholder=@"Project";
    projecttxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:projecttxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    attendtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    attendtxt.textAlignment=NSTextAlignmentLeft;
    attendtxt.delegate = self;
    attendtxt.textColor=[UIColor blackColor];
    [attendtxt setBackgroundColor:[UIColor clearColor]];
    attendtxt.leftViewMode = UITextFieldViewModeAlways;
    [attendtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    attendtxt.returnKeyType=UIReturnKeyDone;
    attendtxt.selectedLineColor = [UIColor redColor];
    attendtxt.selectedPlaceHolderColor = [UIColor redColor];
    attendtxt.placeHolderColor = [UIColor grayColor];
    attendtxt.placeholder=@"Attend Date";
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                               style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
    [numberToolbarzip sizeToFit];
    attendtxt.inputView =datePicker;
    numberToolbarzip.tintColor=[UIColor whiteColor];
    attendtxt.inputAccessoryView = numberToolbarzip;
    attendtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:attendtxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    assignedtxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    assignedtxt.textAlignment=NSTextAlignmentLeft;
    assignedtxt.delegate = self;
    assignedtxt.textColor=[UIColor lightGrayColor];
    [assignedtxt setBackgroundColor:[UIColor clearColor]];
    assignedtxt.leftViewMode = UITextFieldViewModeAlways;
    [assignedtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    assignedtxt.returnKeyType=UIReturnKeyDone;
    assignedtxt.selectedLineColor = [UIColor redColor];
    assignedtxt.selectedPlaceHolderColor = [UIColor redColor];
    assignedtxt.placeHolderColor = [UIColor grayColor];
    assignedtxt.placeholder=@"Assigned To";
    assignedtxt.text=@"Sales_Xrbia1";
    assignedtxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:assignedtxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    prospestagetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    prospestagetxt.textAlignment=NSTextAlignmentLeft;
    prospestagetxt.delegate = self;
    prospestagetxt.textColor=[UIColor blackColor];
    [prospestagetxt setBackgroundColor:[UIColor clearColor]];
    prospestagetxt.leftViewMode = UITextFieldViewModeAlways;
    [prospestagetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    prospestagetxt.returnKeyType=UIReturnKeyDone;
    prospestagetxt.selectedLineColor = [UIColor redColor];
    prospestagetxt.selectedPlaceHolderColor = [UIColor redColor];
    prospestagetxt.placeHolderColor = [UIColor grayColor];
    prospestagetxt.placeholder=@"Prospect Stage";
    prospestagetxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:prospestagetxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    unitnotxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    unitnotxt.textAlignment=NSTextAlignmentLeft;
    unitnotxt.delegate = self;
    unitnotxt.textColor=[UIColor blackColor];
    [unitnotxt setBackgroundColor:[UIColor clearColor]];
    unitnotxt.leftViewMode = UITextFieldViewModeAlways;
    [unitnotxt setKeyboardType:UIKeyboardTypeEmailAddress];
    unitnotxt.returnKeyType=UIReturnKeyDone;
    unitnotxt.selectedLineColor = [UIColor redColor];
    unitnotxt.selectedPlaceHolderColor = [UIColor redColor];
    unitnotxt.placeHolderColor = [UIColor grayColor];
    unitnotxt.placeholder=@"Unit No.";
    unitnotxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:unitnotxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    scheduledatetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    scheduledatetxt.textAlignment=NSTextAlignmentLeft;
    scheduledatetxt.delegate = self;
    scheduledatetxt.textColor=[UIColor blackColor];
    [scheduledatetxt setBackgroundColor:[UIColor clearColor]];
    scheduledatetxt.leftViewMode = UITextFieldViewModeAlways;
    [scheduledatetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    scheduledatetxt.returnKeyType=UIReturnKeyDone;
    scheduledatetxt.selectedLineColor = [UIColor redColor];
    scheduledatetxt.selectedPlaceHolderColor = [UIColor redColor];
    scheduledatetxt.placeHolderColor = [UIColor grayColor];
    scheduledatetxt.placeholder=@"Schedule Date";
    scheduledatetxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:scheduledatetxt];
    scheduledatetxt.hidden=YES;
    
    hig=hig+screenRect.size.height*0.10;
 
    remarktxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hig,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    remarktxt.textAlignment=NSTextAlignmentLeft;
    remarktxt.delegate = self;
    remarktxt.textColor=[UIColor blackColor];
    [remarktxt setBackgroundColor:[UIColor clearColor]];
    remarktxt.leftViewMode = UITextFieldViewModeAlways;
    [remarktxt setKeyboardType:UIKeyboardTypeEmailAddress];
    remarktxt.returnKeyType=UIReturnKeyDone;
    remarktxt.selectedLineColor = [UIColor redColor];
    remarktxt.selectedPlaceHolderColor = [UIColor redColor];
    remarktxt.placeHolderColor = [UIColor grayColor];
    remarktxt.placeholder=@"Remark";
    remarktxt.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:remarktxt];
    
    hig=hig+screenRect.size.height*0.20;
    scrollView.contentSize=CGSizeMake(screenRect.size.width,hig);
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM d,yyyy h:mm a"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.attendtxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    attendtxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd+HH:mm"];
//    _formatteddatestr=[dateFormatter stringFromDate:[picker date]];
    [attendtxt resignFirstResponder];
}
-(void)save
{
  [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
    if (pickerView == leadspicker)
    {
        rowItem = [leadsarr objectAtIndex: row];
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
    
    
    if (pickerView ==projectpicker)
    {
        projectstr=[[NSString alloc]init];
        projectstr=[NSString stringWithFormat:@"%@",[projectarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==leadspicker)
    {
        leadstr=[[NSString alloc]init];
        leadstr=[NSString stringWithFormat:@"%@",[leadsarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
        leadsdict=[appDelegate.leadsarr objectAtIndex:[pickerView selectedRowInComponent:0]];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
    if (pickerView == leadspicker)
    {
        return [leadsarr objectAtIndex:row];
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
    
    
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    leadstoolbar.hidden=YES;
    leadspicker.hidden=YES;
    
    if (textField ==projecttxt) {
        projectarr=[[NSMutableArray alloc]init];
        prosjectidarr=[[NSMutableArray alloc]init];
        for (int i=0; i<appDelegate.projectarr.count; i++) {
            NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
            [projectarr addObject:[dict objectForKey:@"name"]];
            [prosjectidarr addObject:[dict objectForKey:@"id"]];
        }
        
//        if (projectoremove.count>0) {
//            for (NSInteger i=projectarr.count-1; i>=0;i-- )
//            {
//                for (int j=0; j<projectoremove.count; j++) {
//                    if ([[projectoremove objectAtIndex:j]isEqualToString:[projectarr objectAtIndex:i]]) {
//                        [projectarr removeObject:[projectarr objectAtIndex:i]];
//                        [prosjectidarr removeObjectAtIndex:i];
//                    }
//                }
//
//            }
//        }
        
        projectpicker = [[UIPickerView alloc] init];
        [projectpicker setDataSource: self];
        [projectpicker setDelegate: self];
        projectpicker.backgroundColor = [UIColor whiteColor];
        [projectpicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        projectpicker.showsSelectionIndicator = YES;
        [projectpicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: projectpicker];
        projectpicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            projectoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            projectoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [projectoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed4)];
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
        
        projectoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:projectoolbar];
        
        projectoolbar.hidden=NO;
        [projecttxt resignFirstResponder];
        return NO;
    }
    if (textField ==prospextTxt) {
        leadsarr=[[NSMutableArray alloc]init];
        for (int i=0; i<appDelegate.leadsarr.count; i++) {
            NSDictionary* dict=[appDelegate.leadsarr objectAtIndex:i];
            [leadsarr addObject:[NSString stringWithFormat:@"%@ %@-%@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"],[dict objectForKey:@"project_name"]]];
        }
        
       
        leadspicker = [[UIPickerView alloc] init];
        [leadspicker setDataSource: self];
        [leadspicker setDelegate: self];
        leadspicker.backgroundColor = [UIColor whiteColor];
        [leadspicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        leadspicker.showsSelectionIndicator = YES;
        [leadspicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: leadspicker];
        leadspicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            leadstoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            leadstoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [leadstoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed2)];
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
        
        leadstoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:leadstoolbar];
        
        leadstoolbar.hidden=NO;
        [prospextTxt resignFirstResponder];
        return NO;
    }
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
    if ([pickerView isEqual: leadspicker]) {
        return [leadsarr count];
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
-(IBAction)doneBtnPressed4{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    
    if ([projectstr isEqualToString:@""] || projectstr==nil) {
        if (projectarr.count>0) {
            projecttxt.text=[projectarr objectAtIndex:0];
        }
    }
    else{
        projecttxt.text=projectstr;
    }
}
-(IBAction)doneBtnPressed2{
    leadstoolbar.hidden=YES;
    leadspicker.hidden=YES;
    if ([leadstr isEqualToString:@""] || leadstr==nil) {
        if (leadsarr.count>0) {
            prospextTxt.text=[leadsarr objectAtIndex:0];
            leadsdict=[appDelegate.leadsarr objectAtIndex:0];
        }
    }
    else{
        prospextTxt.text=leadstr;
    }
    mobiletxt.text=[leadsdict objectForKey:@"phone_mobile"];
    projecttxt.text=[leadsdict objectForKey:@"project_name"];
    mobiletxt.enabled=NO;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
    
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height - 250 );
    //resize
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==mobiletxt)
    {
        if(textField.text.length >9 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}

-(IBAction)cancelBtnpress{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
    leadstoolbar.hidden=YES;
    leadspicker.hidden=YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doneWithNumberPad{
    [mobiletxt resignFirstResponder];
    [attendtxt resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
    
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height + 250 );
    
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
