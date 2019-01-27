//
//  FilterInvinteryViewController.m
//  Sales App
//
//  Created by Infinitum on 17/04/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "FilterInvinteryViewController.h"
#import "UIColor+Expanded.h"
#import <AFNetworking.h>
#import "inventaryViewController.h"
@interface FilterInvinteryViewController ()

@end

@implementation FilterInvinteryViewController
@synthesize projectxt,sizetxt,valuetx,protypetxt,projectarr,projectstr,projectidarr,projectidstr,projectoolbar,projectpicker,typearr,typestr,typepicker,typetoolbar,sizearr,sizestr,sizepicker,sizetoolbar,rangeSliderCurrency,swirchview,minsizestr,minvaluestr,maxsizestr,maxvaluestr,switchstr,appDelegate,indicator,rangeSlider,privateSwitch;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    switchstr=[[NSString alloc]init];
    projectidstr=[[NSString alloc]init];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Filter";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];
    
    UIButton *filterbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.7,screenRect.size.height*0.03,screenRect.size.width*0.15,screenRect.size.height*0.07)];
    filterbtn.layer.cornerRadius = 4.0f;
    [filterbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [filterbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    filterbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [filterbtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [filterbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.035]];
    [filterbtn setTitle:@"Clear" forState:UIControlStateNormal];
    [self.view addSubview:filterbtn];
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.10,screenRect.size.width,screenRect.size.height*0.90)];
    backgroundview.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    [self.view addSubview:backgroundview];
    
    
    int hig=screenRect.size.height*0.11;
    
    UIButton* projectbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.0,hig,screenRect.size.width*.2,screenRect.size.height*.07)];
  //  [projectbtn addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
    [projectbtn setTitle:@"Projects" forState:UIControlStateNormal];
    [projectbtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    projectbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [projectbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.04]];

    [self.view addSubview:projectbtn];
    
    hig=hig+screenRect.size.height*0.07;
 
        projectxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,hig,screenRect.size.width*0.80,screenRect.size.height*0.07)];
        projectxt.textAlignment=NSTextAlignmentLeft;
        projectxt.delegate = self;
        projectxt.textColor=[UIColor blackColor];
        [projectxt setBackgroundColor:[UIColor clearColor]];
        projectxt.leftViewMode = UITextFieldViewModeAlways;
        [projectxt setKeyboardType:UIKeyboardTypeEmailAddress];
        projectxt.returnKeyType=UIReturnKeyDone;
        projectxt.selectedLineColor = [UIColor redColor];
        projectxt.selectedPlaceHolderColor = [UIColor redColor];
        projectxt.placeHolderColor = [UIColor grayColor];
        projectxt.placeholder=@"Projects";
        projectxt.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:projectxt];

    hig=hig+screenRect.size.height*0.08;
    
    UIButton* typebtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.00,hig,screenRect.size.width*.20,screenRect.size.height*.07)];
  //  [typebtn addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
    [typebtn setTitle:@"Type" forState:UIControlStateNormal];
    [typebtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    typebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [typebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.04]];
    [self.view addSubview:typebtn];
    
    hig=hig+screenRect.size.height*0.07;

        protypetxt = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,hig,screenRect.size.width*0.80,screenRect.size.height*0.07)];
        protypetxt.textAlignment=NSTextAlignmentLeft;
        protypetxt.delegate = self;
        protypetxt.textColor=[UIColor blackColor];
        [protypetxt setBackgroundColor:[UIColor clearColor]];
        protypetxt.leftViewMode = UITextFieldViewModeAlways;
        [protypetxt setKeyboardType:UIKeyboardTypeEmailAddress];
        protypetxt.returnKeyType=UIReturnKeyDone;
        protypetxt.selectedLineColor = [UIColor redColor];
        protypetxt.selectedPlaceHolderColor = [UIColor redColor];
        protypetxt.placeHolderColor = [UIColor grayColor];
        protypetxt.placeholder=@"Type";
        protypetxt.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:protypetxt];
    
    hig=hig+screenRect.size.height*0.08;
  
        UIButton* value=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.0,hig,screenRect.size.width*.20,screenRect.size.height*.07)];
        [value addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
        [value setTitle:@"Values" forState:UIControlStateNormal];
        [value setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
        value.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [value.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.04]];
        [self.view addSubview:value];
    
    hig=hig+screenRect.size.height*0.07;
    
    
    
    rangeSliderCurrency = [[TTRangeSlider alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15,hig,screenRect.size.width*0.70,screenRect.size.height*0.10)];
    rangeSliderCurrency.delegate = self;
    rangeSliderCurrency.minValue = 500000;
    rangeSliderCurrency.maxValue = 20000000;
    rangeSliderCurrency.selectedMinimum = 500000;
    rangeSliderCurrency.selectedMaximum = 20000000;
    minvaluestr=@"500000";
    maxvaluestr=@"20000000";
    rangeSliderCurrency.handleColor = [UIColor blueColor];
    rangeSliderCurrency.handleDiameter = 15;
    rangeSliderCurrency.handleBorderWidth = 1;
    rangeSliderCurrency.selectedHandleDiameterMultiplier = 1.0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    rangeSliderCurrency.numberFormatterOverride = formatter;
    [self.view addSubview:rangeSliderCurrency];
   
    hig=hig+screenRect.size.height*0.10;
    
        UIButton* size=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.0,hig,screenRect.size.width*.2,screenRect.size.height*.07)];
        [size addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
        [size setTitle:@"Size" forState:UIControlStateNormal];
        [size setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
        size.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [size.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.04]];
        [self.view addSubview:size];
    
    hig=hig+screenRect.size.height*0.07;

   
    rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(screenRect.size.width*0.15,hig,screenRect.size.width*0.70,screenRect.size.height*0.10)];
    rangeSlider.delegate = self;
    rangeSlider.minValue = 150;
    rangeSlider.maxValue = 2000;
    rangeSlider.selectedMinimum = 150;
    rangeSlider.selectedMaximum = 2000;
    minsizestr=@"150";
    maxsizestr=@"2000";
    rangeSlider.handleColor = [UIColor blueColor];
    [self.view addSubview:rangeSlider];
    
    hig=hig+screenRect.size.height*0.12;

        swirchview = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0,hig,screenRect.size.width,screenRect.size.height*0.07)];
        [self.view addSubview:swirchview];

    {
        _checkboxbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.10,screenRect.size.height*0.01,screenRect.size.width*.10,screenRect.size.height*.05)];
        [_checkboxbtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        [_checkboxbtn setTitle:@"\uE835" forState:UIControlStateNormal];
        _checkboxbtn.tag=0;
        [_checkboxbtn setTitle:@"\uE834" forState:UIControlStateSelected];
        [_checkboxbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_checkboxbtn.titleLabel setFont:customFontdregs];
        [swirchview addSubview:_checkboxbtn];
        
        UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.22,0,screenRect.size.width*.20,screenRect.size.height*0.07)];
        //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
        horizontallbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        horizontallbl.text=@"Premium";
        [horizontallbl setTextColor:[UIColor blackColor]];
        horizontallbl.textAlignment = NSTextAlignmentLeft;
        [swirchview addSubview:horizontallbl];
        
        _checkboxbtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.45,screenRect.size.height*0.01,screenRect.size.width*.10,screenRect.size.height*.05)];
        [_checkboxbtn2 addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        [_checkboxbtn2 setTitle:@"\uE835" forState:UIControlStateNormal];
        [_checkboxbtn2 setTitle:@"\uE834" forState:UIControlStateSelected];
        _checkboxbtn2.tag=1;
        [_checkboxbtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_checkboxbtn2.titleLabel setFont:customFontdregs];
        [swirchview addSubview:_checkboxbtn2];
        
        UILabel *rightlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.57,0,screenRect.size.width*.30,screenRect.size.height*0.07)];
        //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
        rightlbl.font=[UIFont boldSystemFontOfSize:screenRect.size.width*0.035];
        rightlbl.text=@"Non premium";
        [rightlbl setTextColor:[UIColor blackColor]];
        rightlbl.textAlignment = NSTextAlignmentLeft;
        [swirchview addSubview:rightlbl];
    }
    hig=hig+screenRect.size.height*0.15;

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.35,hig,screenRect.size.width*0.30,screenRect.size.height*0.07)];
    [cancelBtn setTitle:@"Apply" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.font=[UIFont systemFontOfSize:14];
    // [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    cancelBtn.tag=5;
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#F8F8F8"]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
    cancelBtn.layer.borderWidth = 0.5;
    [self.view addSubview:cancelBtn];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
}
-(void)clear
{
    appDelegate.premiumstr=@"";
    switchstr=@"";
    rangeSlider.selectedMinimum=150;
    rangeSlider.selectedMaximum = 2000;
    rangeSliderCurrency.selectedMinimum = 500000;
    rangeSliderCurrency.selectedMaximum = 20000000;
    minsizestr=@"150";
    maxsizestr=@"2000";
    minvaluestr=@"500000";
    maxvaluestr=@"20000000";
    
    projectxt.text=@"";
    appDelegate.projectstr=@"";
    projectidstr=@"";
    appDelegate.projectId=@"";
    protypetxt.text=@"";
    appDelegate.unitType=@"";
}
-(void)select:(UIButton *)btn
{
    if (btn.selected) {
        btn.selected=NO;
    }
    else
    {
        btn.selected=YES;
    }
}
-(void)apply
{
    if (_checkboxbtn.selected) {
        switchstr=@"0";
    }
    if (_checkboxbtn2.selected) {
        switchstr=@"1";
    }
    if (_checkboxbtn.selected&&_checkboxbtn2.selected) {
        switchstr=@"";
    }
 NSString*   encodedUrl = [protypetxt.text stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    [indicator startAnimating];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:projectidstr  forKey:@"projectId"];
    [params setObject:encodedUrl forKey:@"unitType"];
    [params setObject:minsizestr  forKey:@"unitMinSize"];
    [params setObject:minvaluestr  forKey:@"unitMinValue"];
    [params setObject:maxsizestr forKey:@"unitMaxSize"];
    [params setObject:maxvaluestr  forKey:@"unitMaxValue"];
    [params setObject:switchstr  forKey:@"premium"];
    [params setObject:@"getBuildingByFilters"  forKey:@"requestType"];
    
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    [indicator startAnimating];
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
     //   NSMutableString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
//                                                             length:[data length] encoding: NSUTF8StringEncoding];
        NSLog(@"JSON: %@", userDict);
        NSDictionary *dict=[userDict objectForKey:@"Android"];
        [indicator stopAnimating];
        if ([dict objectForKey:@"failure"]!=nil) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[dict objectForKey:@"failure"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            appDelegate.premiumstr=switchstr;
            appDelegate.unitMinSize=minsizestr;
            appDelegate.unitMinValue=minvaluestr;
            appDelegate.unitMaxSize=maxsizestr;
            appDelegate.unitMaxValue=maxvaluestr;
            appDelegate.projectId=projectidstr;
            appDelegate.unitType=protypetxt.text;
            appDelegate.projectstr=projectxt.text;
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationMessageEvent" object:nil userInfo:dict];
            }];
        }

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)logControlEvent:(TTRangeSlider *)sender {
    NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", sender.selectedMinimum, sender.selectedMaximum);
    minsizestr=[NSString stringWithFormat:@"%.0f",sender.selectedMinimum];
    minvaluestr=[NSString stringWithFormat:@"%.0f",sender.selectedMaximum];
}
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    if (sender == self.rangeSliderCurrency) {
        NSLog(@"Currency slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
        minvaluestr=[NSString stringWithFormat:@"%.0f",selectedMinimum];
        maxvaluestr=[NSString stringWithFormat:@"%.0f",selectedMaximum];
    }
     if (sender ==rangeSlider)
     {
         NSLog(@"slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
         minsizestr=[NSString stringWithFormat:@"%.0f",selectedMinimum];
         maxsizestr=[NSString stringWithFormat:@"%.0f",selectedMaximum];
     }
}
-(void)tab:(UIButton*)btn
{
    if (btn.tag==1) {
        projectxt.hidden=NO;
        protypetxt.hidden=YES;
        rangeSliderCurrency.hidden=YES;
        rangeSlider.hidden=YES;
        swirchview.hidden=YES;

    }
    if (btn.tag==2)     {
        projectxt.hidden=YES;
        protypetxt.hidden=NO;
        sizetxt.hidden=YES;
        valuetx.hidden=YES;
        rangeSliderCurrency.hidden=YES;
        rangeSlider.hidden=YES;
        swirchview.hidden=YES;

    }
    if (btn.tag==3)     {
        projectxt.hidden=YES;
        protypetxt.hidden=YES;
        rangeSliderCurrency.hidden=NO;
        rangeSlider.hidden=YES;
        swirchview.hidden=YES;

    }
    if (btn.tag==4)     {
        projectxt.hidden=YES;
        protypetxt.hidden=YES;
        rangeSliderCurrency.hidden=YES;
        rangeSlider.hidden=NO;
        swirchview.hidden=YES;

    }
    if (btn.tag==5)     {
        projectxt.hidden=YES;
        protypetxt.hidden=YES;
        rangeSlider.hidden=YES;
        rangeSliderCurrency.hidden=YES;
        swirchview.hidden=NO;
    }
}
-(void) viewWillAppear:(BOOL)animated
{
    if (![appDelegate.projectId isEqualToString:@""]||![appDelegate.premiumstr isEqualToString:@""]||![appDelegate.unitMinSize isEqualToString:@""]||![appDelegate.unitMinValue isEqualToString:@""]||![appDelegate.unitMaxSize isEqualToString:@""]||![appDelegate.unitMaxValue isEqualToString:@""]||![appDelegate.unitType isEqualToString:@""]||![appDelegate.projectstr isEqualToString:@""]) {
        switchstr=appDelegate.premiumstr;
        minsizestr=appDelegate.unitMinSize;
        minvaluestr=appDelegate.unitMinValue;
        maxsizestr=appDelegate.unitMaxSize;
        maxvaluestr=appDelegate.unitMaxValue;
        
        rangeSlider.selectedMinimum=[appDelegate.unitMinSize intValue];
        rangeSlider.selectedMaximum = [appDelegate.unitMaxSize intValue];
        rangeSliderCurrency.selectedMinimum = [appDelegate.unitMinValue intValue];
        rangeSliderCurrency.selectedMaximum = [appDelegate.unitMaxValue intValue];
       
        projectxt.text=appDelegate.projectstr;
        projectidstr=appDelegate.projectId;
        protypetxt.text=appDelegate.unitType;
        
        if ([switchstr isEqualToString:@"1"]) {
        }
        if ([switchstr isEqualToString:@"0"])
        {
            
        }
    }
    [self gettype];
}

-(void)gettype
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIActivityIndicatorView* acttyindicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    acttyindicator.frame = CGRectMake(screenRect.size.width *0.30, screenRect.size.height *0.0, screenRect.size.width *0.10,screenRect.size.width *0.10);
    //    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
    [protypetxt addSubview:acttyindicator];
    
    [acttyindicator startAnimating];
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"projectName=&requestType=getUnitTypes"]];
    
    urlString = [[NSString alloc]initWithFormat:@"%@getFilteredInventory.php?",[prefs objectForKey:@"Link"]];
    url=[[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error)
        {
            NSLog(@"Failed to submit request");
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [acttyindicator stopAnimating];
            [self gettype];
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            NSLog(@"content %@",content);
            NSError *error;
            if ([content isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Invalid Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [acttyindicator stopAnimating];
                
            }else {
                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"JSON: %@", userDict);
                typearr=[[NSMutableArray alloc]init];
                typearr=[[[userDict objectForKey:@"Android"] objectForKey:@"unit_types"] mutableCopy];
                
                for (int i = 0; i<typearr.count;i++){
                    if (typearr[i] == NULL || [typearr[i] isEqual:@""] || [typearr[i] isKindOfClass:[NSNull class]]){
                        [typearr removeObjectAtIndex:i];
                    }
                }
                
                [acttyindicator stopAnimating];
            }
        }
    }];
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == projectpicker)
    {
        rowItem = [projectarr objectAtIndex: row];
    }
   
    if (pickerView == typepicker)
    {
        rowItem = [typearr objectAtIndex: row];
    }
    if (pickerView == sizepicker)
    {
        rowItem = [sizearr objectAtIndex: row];
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
        projectidstr=[[NSString alloc]init];
        projectidstr=[NSString stringWithFormat:@"%@",[projectidarr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
   
    if (pickerView ==typepicker)
    {
        typestr=[[NSString alloc]init];
        typestr=[NSString stringWithFormat:@"%@",[typearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==sizepicker)
    {
        sizestr=[[NSString alloc]init];
        sizestr=[NSString stringWithFormat:@"%@",[sizearr objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == projectpicker)
    {
        return [projectarr objectAtIndex:row];
    }
   
    if (pickerView == typepicker)
    {
        return [typearr objectAtIndex:row];
    }
    if (pickerView == sizepicker)
    {
        return [sizearr objectAtIndex:row];
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
    typetoolbar.hidden=YES;
    typepicker.hidden=YES;
    sizetoolbar.hidden=YES;
    sizepicker.hidden=YES;
    
    if (textField ==projectxt) {
                projectidarr=[[NSMutableArray alloc]init];
                projectarr=[[NSMutableArray alloc]init];
        
        for (int i=0; i<appDelegate.projectarr.count; i++) {
            NSDictionary* dict=[appDelegate.projectarr objectAtIndex:i];
            [projectarr addObject:[dict objectForKey:@"name"]];
            [projectidarr addObject:[dict objectForKey:@"id"]];
        }
//
//        for (int i=0; i<_totalprojectarr.count; i++) {
//            NSDictionary *dict=[_totalprojectarr objectAtIndex:i];
//            [projectarr addObject: [dict objectForKey:@"name"]];
//            [projectidarr addObject:[dict objectForKey:@"id"]];
//        }
        //
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
        [projectxt resignFirstResponder];
        return NO;
    }
   
    if (textField ==protypetxt) {
        
        //
     
        typepicker = [[UIPickerView alloc] init];
        [typepicker setDataSource: self];
        [typepicker setDelegate: self];
        typepicker.backgroundColor = [UIColor whiteColor];
        [typepicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        typepicker.showsSelectionIndicator = YES;
        [typepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: typepicker];
        typepicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            typetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            typetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [typetoolbar setBarStyle:UIBarStyleBlackOpaque];
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
        
        typetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:typetoolbar];
        
        typetoolbar.hidden=NO;
        [protypetxt resignFirstResponder];
        return NO;
    }
    if (textField ==sizetxt) {
        
        sizearr=[[NSMutableArray alloc]initWithObjects:@"836.00",@"833.00",@"839.00",@"840.00",@"848.00", nil];
        sizepicker = [[UIPickerView alloc] init];
        [sizepicker setDataSource: self];
        [sizepicker setDelegate: self];
        sizepicker.backgroundColor = [UIColor whiteColor];
        [sizepicker setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        sizepicker.showsSelectionIndicator = YES;
        [sizepicker selectRow:0 inComponent:0 animated:YES];
        [self.view addSubview: sizepicker];
        sizepicker.hidden=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            sizetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        }
        else{
            sizetoolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
        }
        [sizetoolbar setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressed3)];
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
        
        sizetoolbar.items = @[rightButton,flex,leftButton];
        [self.view addSubview:sizetoolbar];
        
        sizetoolbar.hidden=NO;
        [sizetxt resignFirstResponder];
        return NO;
    }
    return YES;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([pickerView isEqual: projectpicker]) {
        return [projectarr count];
    }
   
    if ([pickerView isEqual: typepicker]) {
        return [typearr count];
    }
    if ([pickerView isEqual: sizepicker]) {
        return [sizearr count];
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
            projectxt.text=[projectarr objectAtIndex:0];
            projectidstr=[projectidarr objectAtIndex:0];
        }
    }
    else{
        projectxt.text=projectstr;
    }
}

-(IBAction)doneBtnPressed2{
    typetoolbar.hidden=YES;
    typepicker.hidden=YES;
    
    if ([typestr isEqualToString:@""] || typestr==nil) {
        if (typearr.count>0) {
            protypetxt.text=[typearr objectAtIndex:0];
        }
    }
    else{
        protypetxt.text=typestr;
    }
}
-(IBAction)doneBtnPressed3{
    sizetoolbar.hidden=YES;
    sizepicker.hidden=YES;
    
    if ([sizestr isEqualToString:@""] || sizestr==nil) {
        if (sizearr.count>0) {
            sizetxt.text=[sizearr objectAtIndex:0];
        }
    }
    else{
        sizetxt.text=sizestr;
    }
}

-(IBAction)cancelBtnpress{
    projectpicker.hidden=YES;
    projectoolbar.hidden=YES;
  
    typetoolbar.hidden=YES;
    typepicker.hidden=YES;
    sizetoolbar.hidden=YES;
    sizepicker.hidden=YES;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
