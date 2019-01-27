//
//  FollowUpEditViewController.m
//  Sales App
//
//  Created by Infinitum on 21/03/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "FollowUpEditViewController.h"
#import "UIColor+Expanded.h"
#import "AddbookingViewController.h"
#import <AFNetworking.h>

@interface FollowUpEditViewController ()
@end

@implementation FollowUpEditViewController
@synthesize dict,datetxt,reasontxt,Statustxt,numberToolbarzip,datePicker,statustr,statuspicker,statustoolbar,statusarr,Createvoucherbtn,indicator,tableViewHome,listarr,vieshistorybtn,historyarr,remarktxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _formatdatestr=[[NSString alloc]init];
    statustr=[[NSString alloc]init];

    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:30];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Edit";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:horizontallbl];
    
    UILabel *namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,screenRect.size.height*0.15,screenRect.size.width*.64,screenRect.size.height*0.05)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.045];
    NSArray *myArray = [[dict objectForKey:@"name"] componentsSeparatedByString:@"-"];
    namelbl.text =[NSString stringWithFormat:@"Name:%@",[dict objectForKey:@"customer_name_c"]];
    if ([_comestr isEqualToString:@"followup"]) {
        namelbl.text=[NSString stringWithFormat:@"Name:%@",[dict objectForKey:@"name"]];
    }
    
    namelbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:namelbl];
    
  
    
    Statustxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    Statustxt.textAlignment=NSTextAlignmentLeft;
    Statustxt.delegate = self;
    Statustxt.textColor=[UIColor blackColor];
    [Statustxt setBackgroundColor:[UIColor clearColor]];
    Statustxt.leftViewMode = UITextFieldViewModeAlways;
    [Statustxt setKeyboardType:UIKeyboardTypeEmailAddress];
    Statustxt.returnKeyType=UIReturnKeyDone;
    Statustxt.selectedLineColor = [UIColor redColor];
    Statustxt.selectedPlaceHolderColor = [UIColor redColor];
    Statustxt.placeHolderColor = [UIColor grayColor];
    Statustxt.placeholder=@"Status";
    Statustxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:Statustxt];

    reasontxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    reasontxt.textAlignment=NSTextAlignmentLeft;
    reasontxt.delegate = self;
    reasontxt.textColor=[UIColor blackColor];
    [reasontxt setBackgroundColor:[UIColor clearColor]];
    reasontxt.leftViewMode = UITextFieldViewModeAlways;
    [reasontxt setKeyboardType:UIKeyboardTypeEmailAddress];
    reasontxt.returnKeyType=UIReturnKeyDone;
    reasontxt.selectedLineColor = [UIColor redColor];
    reasontxt.selectedPlaceHolderColor = [UIColor redColor];
    reasontxt.placeHolderColor = [UIColor grayColor];
    reasontxt.placeholder=@"Reason";
    reasontxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:reasontxt];
    reasontxt.hidden=YES;
    
    datetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.30,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    datetxt.textAlignment=NSTextAlignmentLeft;
    datetxt.delegate = self;
    datetxt.textColor=[UIColor blackColor];
    [datetxt setBackgroundColor:[UIColor clearColor]];
    datetxt.leftViewMode = UITextFieldViewModeAlways;
    [datetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    datetxt.returnKeyType=UIReturnKeyDone;
    datetxt.selectedLineColor = [UIColor redColor];
    datetxt.selectedPlaceHolderColor = [UIColor redColor];
    datetxt.placeHolderColor = [UIColor grayColor];
    datetxt.placeholder=@"Date";
    datetxt.font = [UIFont systemFontOfSize:14];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done"
       style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
    
    [numberToolbarzip sizeToFit];
    datetxt.inputView =datePicker;
    numberToolbarzip.tintColor=[UIColor whiteColor];
    datetxt.inputAccessoryView = numberToolbarzip;
    [self.view addSubview:datetxt];
    datetxt.hidden=YES;

    remarktxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.40,screenRect.size.width*0.90,screenRect.size.height*0.07)];
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
    [self.view addSubview:remarktxt];
    remarktxt.hidden=YES;
    
//
   vieshistorybtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [vieshistorybtn addTarget:self
               action:@selector(remarkhistory)
     forControlEvents:UIControlEventTouchUpInside];
    [vieshistorybtn setTitle:@"Remark History" forState:UIControlStateNormal];
    vieshistorybtn.frame = CGRectMake(screenRect.size.width*0.60,screenRect.size.height*0.105,screenRect.size.width*0.40,screenRect.size.height*0.05);
    [self.view addSubview:vieshistorybtn];

    Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.53,screenRect.size.width*0.80,screenRect.size.height*0.07)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn setClipsToBounds:YES];
    [Createvoucherbtn setTitle:@"OK" forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Createvoucherbtn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]] ;
    [self.view addSubview:Createvoucherbtn];
    
    tableViewHome = [[UITableView alloc] init];
    [tableViewHome setFrame:CGRectMake(screenRect.size.width*0.0,screenRect.size.height*.62, screenRect.size.width,screenRect.size.height*.38)];
    tableViewHome.backgroundColor=[UIColor clearColor];
    tableViewHome.delegate = self;
    tableViewHome.dataSource = self;
    tableViewHome.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewHome];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}

-(void)remarkhistory
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[dict objectForKey:@"lead_number_c"]  forKey:@"leadnumberc"];
    [params setObject:@"getearlierfollowup"  forKey:@"requestType"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getearlierfollowup.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        historyarr=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", historyarr);
        [tableViewHome reloadData];
        [indicator stopAnimating];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return historyarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSDictionary *dict=[historyarr objectAtIndex:indexPath.row];
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    //    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,0,screenRect.size.width*0.02,screenRect.size.height*0.12)];
    //    leftview.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    //    leftview.layer.shadowOffset = CGSizeMake(0, 2.0f);
    //    leftview.layer.shadowOpacity = 1.0f;
    //    leftview.layer.shadowRadius = 0.0f;
    //    leftview.layer.masksToBounds = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,0,screenRect.size.width*0.96,screenRect.size.height*0.14)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    headerView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    headerView.layer.shadowOpacity = 1.0f;
    headerView.layer.shadowRadius = 2.0f;
    headerView.layer.masksToBounds = NO;
    headerView.backgroundColor=[UIColor whiteColor];
    
    UILabel*  Srnolbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    Srnolbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.04];
    Srnolbl.textAlignment = NSTextAlignmentLeft;
    Srnolbl.text =[NSString stringWithFormat:@"Name:%@",[dict objectForKey:@"name"]];
    ;
    Srnolbl.backgroundColor = [UIColor clearColor];
    Srnolbl.textColor=[UIColor blackColor];
    Srnolbl.lineBreakMode = NSLineBreakByWordWrapping;
    Srnolbl.numberOfLines = 0;
    [headerView addSubview:Srnolbl];
    
    UILabel*  namelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.05,screenRect.size.width*0.80,screenRect.size.height*0.04)];
    namelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    namelbl.textAlignment = NSTextAlignmentLeft;
    namelbl.text =[NSString stringWithFormat:@"Status: %@",[dict objectForKey:@"status"]];
    namelbl.backgroundColor = [UIColor clearColor];
    namelbl.textColor=[UIColor blackColor];
    namelbl.lineBreakMode = NSLineBreakByWordWrapping;
    namelbl.numberOfLines = 0;
    
    [headerView addSubview:namelbl];
    
    UILabel*  remaklbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.09,screenRect.size.width*0.80,screenRect.size.height*0.05)];
    remaklbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    remaklbl.textAlignment = NSTextAlignmentLeft;
    remaklbl.text =[NSString stringWithFormat:@"Remark: %@",[dict objectForKey:@"remark"]];
    remaklbl.backgroundColor = [UIColor clearColor];
    remaklbl.textColor=[UIColor blackColor];
    remaklbl.lineBreakMode = NSLineBreakByWordWrapping;
    remaklbl.numberOfLines = 0;
    
    [headerView addSubview:remaklbl];
    
    [cell.contentView addSubview:headerView];
    
    //   headerView.masksToBounds = NO;
    //   headerView.shadowOffset = CGSizeMake(-15, 20);
    //   headerView.shadowRadius = 5;
    //   headerView.shadowOpacity = 0.5;
    
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
    return screenRect.size.height*0.15;
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)datetxt.inputView;
    datetxt.text = [NSString stringWithFormat:@"%@",picker.date];
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == statuspicker)
    {
        rowItem = [statusarr objectAtIndex: row];
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
    
    
    if (pickerView ==statuspicker)
    {
        statustr=[[NSString alloc]init];
        statustr=[NSString stringWithFormat:@"%@",[statusarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if (pickerView == statuspicker)
    {
        return [statusarr objectAtIndex:row];
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
    
    
    statuspicker.hidden=YES;
    statustoolbar.hidden=YES;
    
    
    if (textField ==Statustxt) {
        statusarr=[[NSMutableArray alloc]initWithObjects:@"Hot",@"Warm",@"Cold",@"Existing Customer",@"Unqualified",@"Booked", nil];
        statuspicker = [[UIPickerView alloc] init];
        [statuspicker setDataSource: self];
        [statuspicker setDelegate: self];
        statuspicker.backgroundColor = [UIColor whiteColor];
        [statuspicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        statuspicker.showsSelectionIndicator = YES;
        [statuspicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: statuspicker];
        statuspicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            statustoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [statustoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        statustoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:statustoolbar];
        
        statustoolbar.hidden=NO;
        [Statustxt resignFirstResponder];
        return NO;
    }
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([pickerView isEqual: statuspicker]) {
        return [statusarr count];
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
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM d,yyyy h:mm a"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.datetxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    datetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   _formatdatestr =[dateFormatter stringFromDate:[picker date]];
    [datetxt resignFirstResponder];
}
-(IBAction)doneBtnPressed4{
    statuspicker.hidden=YES;
    statustoolbar.hidden=YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    if ([statustr isEqualToString:@""] || statustr==nil) {
        if (statusarr.count>0) {
            Statustxt.text=[statusarr objectAtIndex:0];
            statustr=[statusarr objectAtIndex:0];
            datetxt.hidden=NO;
            reasontxt.hidden=YES;
            [Createvoucherbtn setTitle:@"OK" forState:UIControlStateNormal];
        }
    }
    else{
        Statustxt.text=statustr;
    }
    if ([Statustxt.text isEqualToString:@"Hot"]||[Statustxt.text isEqualToString:@"Warm"]||[Statustxt.text isEqualToString:@"Cold"])
    {
        datetxt.hidden=NO;
        remarktxt.hidden=NO;
        vieshistorybtn.hidden=NO;
        reasontxt.text=@"";
        reasontxt.hidden=YES;
        [Createvoucherbtn setTitle:@"OK" forState:UIControlStateNormal];
    }
    if ([Statustxt.text isEqualToString:@"Unqualified"]) {
        datetxt.hidden=YES;
        remarktxt.hidden=YES;
        datetxt.text=@"";
        remarktxt.text=@"";
        reasontxt.hidden=NO;
        vieshistorybtn.hidden=YES;
        [Createvoucherbtn setTitle:@"OK" forState:UIControlStateNormal];
    }
    if ([Statustxt.text isEqualToString:@"Existing Customer"])
    {
        datetxt.hidden=YES;
        remarktxt.hidden=NO;
        vieshistorybtn.hidden=NO;
        reasontxt.text=@"";
        reasontxt.hidden=YES;
        [Createvoucherbtn setTitle:@"OK" forState:UIControlStateNormal];
    }
    
    
    if ([Statustxt.text isEqualToString:@"Booked"]) {
        datetxt.hidden=YES;
        reasontxt.hidden=YES;
        [Createvoucherbtn setTitle:@"Convert To Booking" forState:UIControlStateNormal];
    }
}

-(IBAction)cancelBtnpress{
    
    statuspicker.hidden=YES;
    statustoolbar.hidden=YES;
    [datetxt resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ok:(UIButton*)btn
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([btn.titleLabel.text isEqualToString: @"Convert To Booking"]) {
        AddbookingViewController *mainvc=[[AddbookingViewController alloc] initWithNibName:@"AddbookingViewController" bundle:nil];
        mainvc.comefromstr=@"Visit";
        mainvc.dict=dict;
        [self.navigationController pushViewController:mainvc animated:YES];
    }
   else {
       NSString *str=[[NSString alloc]init];
       
       if ([statustr isEqualToString:@"Hot"]||[statustr isEqualToString:@"Warm"]||[statustr isEqualToString:@"Cold"]||[statustr isEqualToString:@"Existing Customer"]) {
           str=@"Followup";
       }
       else
       {
           str=@"Unqualified";
       }

       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
       NSString *datestr = [formatter stringFromDate:[NSDate date]];
              
       NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
       [data setObject:[prefs objectForKey:@"username"] forKey:@"username"];
       [data setObject:[prefs objectForKey:@"password"] forKey:@"password"];
       [data setObject:[prefs objectForKey:@"user_id"]  forKey:@"usersimplecrmId"];
       [data setObject:[prefs objectForKey:@"url"] forKey:@"url"];
       [data setObject:@"Sales_Sales_Person"  forKey:@"module_name"];
       
       int visit= [[dict objectForKey:@"no_of_visits_c"]intValue];
       visit++;
       _submitdict=[[NSMutableDictionary alloc]init];
       [_submitdict setObject:[dict objectForKey:@"id"] forKey:@"id"];
       [_submitdict setObject:str forKey:@"att_stage1_c"];
       [_submitdict setObject:statustr forKey:@"prospect_stage_c"];
       [_submitdict setObject:@"1" forKey:@"visit_done_c"];
       [_submitdict setObject:_formatdatestr forKey:@"fu_date_c"];
       [_submitdict setObject:datestr  forKey:@"date_modified_mobile_c"];
       [_submitdict setObject:datestr  forKey:@"att_date_c"];
       [_submitdict setObject:[NSString stringWithFormat:@"%d",visit]  forKey:@"no_of_visits_c"];
       [_submitdict setObject:reasontxt.text  forKey:@"unqualified_reason_c"];
       [_submitdict setObject:remarktxt.text  forKey:@"visits_remarks_history_c"];

       NSMutableDictionary *jsonDict=[[NSMutableDictionary alloc]init];
       [jsonDict setObject:@"25"forKey:@"ID"];
       NSMutableArray *arr =[NSMutableArray arrayWithObjects:_submitdict, nil];
       [jsonDict setObject:arr  forKey:@"data"];
       
       NSString *jsonString;
       NSError *error;
       NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                          options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                            error:&error];
       if (! jsonData) {
           //  NSLog(@"Got an error: %@", error);
       } else {
           jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
           // NSLog(@"Got Stringr %@",jsonString);
//           NSArray* words = [jsonString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//           jsonString = [words componentsJoinedByString:@""];
//           jsonString=[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
       }
       NSString*   encodedUrl = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
       [data setObject:encodedUrl  forKey:@"jsonParam"];
       
       [indicator startAnimating];
       AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       NSString*   urlString = [[NSString alloc]initWithFormat:@"%@androupdatedatatocrm.php?",[prefs objectForKey:@"Link"]];
       
       [indicator startAnimating];
       
       [manager GET:urlString parameters:data progress:nil success:^(NSURLSessionTask *task, id responseObject) {
           NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
           
           NSLog(@"JSON: %@", userDict);
           NSMutableArray *recordarr=[[userDict objectForKey:@"Android"] objectForKey:@"records"];
           
           NSDictionary *dict=[recordarr objectAtIndex:0];
           {
               if (![[dict objectForKey:@"mobile_id_c"] isEqualToString:@""]||!([dict objectForKey:@"mobile_id_c"]==nil)) {
                   [self.navigationController popViewControllerAnimated:YES];
               }
               else
               {
                   UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to update"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                   [alert show];
               }
           }
           [ indicator stopAnimating];
           
       } failure:^(NSURLSessionTask *operation, NSError *error) {
           NSLog(@"Error: %@", error);
           [indicator stopAnimating];
           UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
           [indicator stopAnimating];
       }];
   }
       
    }
    
//    else
//    [self.navigationController popViewControllerAnimated:YES];

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
