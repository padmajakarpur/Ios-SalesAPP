//
//  CollectChequeViewController.m
//  Sales App
//
//  Created by Infinitum on 03/08/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//

#import "CollectChequeViewController.h"
#import "UIColor+Expanded.h"
@interface CollectChequeViewController ()

@end

@implementation CollectChequeViewController
@synthesize numberToolbarzip,datePicker,indicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont *customFontdregs = [UIFont fontWithName:@"MaterialIcons-Regular" size:25];
   
    UIView* navigationView=[[UIView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.10)];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    
    UILabel *horizontallbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.18,screenRect.size.height*0.03,screenRect.size.width*.64,screenRect.size.height*0.07)];
    //   horizontallbl.backgroundColor = [UIColor colorWithHexString:@"#004c00"];
    horizontallbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.055];
    horizontallbl.text=@"Collect cheque";
    [horizontallbl setTextColor:[UIColor whiteColor]];
    horizontallbl.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:horizontallbl];

    UIButton* navigationbtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.03,screenRect.size.width*.18,screenRect.size.height*.07)];
    [navigationbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationbtn setTitle:@"\uE314" forState:UIControlStateNormal];
    [navigationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navigationbtn.titleLabel setFont:customFontdregs];
    [navigationbtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:navigationbtn];

    int hig=screenRect.size.height*0.11;

    UILabel*typelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.20,screenRect.size.height*0.08)];
    typelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    typelbl.text=@"Type";
    [typelbl setTextColor:[UIColor blackColor]];
    typelbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:typelbl];
    
    _typetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.65,screenRect.size.height*0.07)];
    _typetxt.textAlignment=NSTextAlignmentLeft;
    _typetxt.delegate = self;
    _typetxt.textColor=[UIColor blackColor];
    [_typetxt setBackgroundColor:[UIColor clearColor]];
    _typetxt.leftViewMode = UITextFieldViewModeAlways;
    [_typetxt setKeyboardType:UIKeyboardTypeEmailAddress];
    _typetxt.returnKeyType=UIReturnKeyDone;
    _typetxt.selectedLineColor = [UIColor redColor];
    _typetxt.selectedPlaceHolderColor = [UIColor redColor];
    _typetxt.placeHolderColor = [UIColor grayColor];
    _typetxt.placeholder=@"Type*";
    NSMutableArray * custtypearr=[[NSMutableArray alloc]initWithObjects:@"BAC",@"OCR", @"SD",nil];
    _typedownpicker = [[DownPicker alloc] initWithTextField:_typetxt withData:custtypearr];
    [_typedownpicker setPlaceholderWhileSelecting:@"Type*"];
    [_typedownpicker showArrowImage:YES];
    _typedownpicker.placeholder=@"Type*";
    [self.view addSubview:_typedownpicker];
    
    _typetxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_typetxt];
    
    hig=hig+screenRect.size.height*0.10;

    UILabel*Amountlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.20,screenRect.size.height*0.08)];
    Amountlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    Amountlbl.text=@"Amount";
    [Amountlbl setTextColor:[UIColor blackColor]];
    Amountlbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:Amountlbl];
    
    _amounttxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.65,screenRect.size.height*0.07)];
    _amounttxt.textAlignment=NSTextAlignmentLeft;
    _amounttxt.delegate = self;
    _amounttxt.textColor=[UIColor blackColor];
    [_amounttxt setBackgroundColor:[UIColor clearColor]];
    _amounttxt.leftViewMode = UITextFieldViewModeAlways;
    [_amounttxt setKeyboardType:UIKeyboardTypeNumberPad];
    _amounttxt.returnKeyType=UIReturnKeyDone;
    _amounttxt.selectedLineColor = [UIColor redColor];
    _amounttxt.selectedPlaceHolderColor = [UIColor redColor];
    _amounttxt.placeHolderColor = [UIColor grayColor];
    _amounttxt.placeholder=@"Amount*";
    _amounttxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_amounttxt];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    _amounttxt.inputAccessoryView = numberToolbarzip;
 _amounttxt.keyboardType = UIKeyboardTypeDecimalPad;
    
    hig=hig+screenRect.size.height*0.10;

    UILabel*chequeno = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.20,screenRect.size.height*0.08)];
    chequeno.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    chequeno.text=@"Cheq no";
    [chequeno setTextColor:[UIColor blackColor]];
    chequeno.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:chequeno];

    
    _chequetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.65,screenRect.size.height*0.07)];
    _chequetxt.textAlignment=NSTextAlignmentLeft;
    _chequetxt.delegate =self;
    _chequetxt.textColor=[UIColor blackColor];
    [_chequetxt setBackgroundColor:[UIColor clearColor]];
    _chequetxt.leftViewMode = UITextFieldViewModeAlways;
    _chequetxt.returnKeyType=UIReturnKeyDone;
    _chequetxt.selectedLineColor = [UIColor redColor];
    _chequetxt.selectedPlaceHolderColor = [UIColor redColor];
    _chequetxt.placeHolderColor = [UIColor grayColor];
    _chequetxt.placeholder=@"Cheque No*";
    _chequetxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_chequetxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    UILabel*bank = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.20,screenRect.size.height*0.08)];
    bank.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    bank.text=@"Bank";
    [bank setTextColor:[UIColor blackColor]];
    bank.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:bank];

    _banktxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.65,screenRect.size.height*0.07)];
    _banktxt.textAlignment=NSTextAlignmentLeft;
    _banktxt.delegate =self;
    _banktxt.textColor=[UIColor blackColor];
    [_banktxt setBackgroundColor:[UIColor clearColor]];
    _banktxt.leftViewMode = UITextFieldViewModeAlways;
    _banktxt.returnKeyType=UIReturnKeyDone;
    _banktxt.selectedLineColor = [UIColor redColor];
    _banktxt.selectedPlaceHolderColor = [UIColor redColor];
    _banktxt.placeHolderColor = [UIColor grayColor];
    _banktxt.placeholder=@"Bank*";
    _banktxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_banktxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    UILabel*branch = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.20,screenRect.size.height*0.08)];
    branch.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    branch.text=@"Branch";
    [branch setTextColor:[UIColor blackColor]];
    branch.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:branch];
    
    _branchtxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.65,screenRect.size.height*0.07)];
    _branchtxt.textAlignment=NSTextAlignmentLeft;
    _branchtxt.delegate =self;
    _branchtxt.textColor=[UIColor blackColor];
    [_branchtxt setBackgroundColor:[UIColor clearColor]];
    _branchtxt.leftViewMode = UITextFieldViewModeAlways;
    _branchtxt.returnKeyType=UIReturnKeyDone;
    _branchtxt.selectedLineColor = [UIColor redColor];
    _branchtxt.selectedPlaceHolderColor = [UIColor redColor];
    _branchtxt.placeHolderColor = [UIColor grayColor];
    _branchtxt.placeholder=@"Branch*";
    _branchtxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_branchtxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    UILabel*datelbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*.05,hig,screenRect.size.width*.20,screenRect.size.height*0.08)];
    datelbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.04];
    datelbl.text=@"Date";
    [datelbl setTextColor:[UIColor blackColor]];
    datelbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:datelbl];
    
    _datetxt=[[ACFloatingTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30,hig,screenRect.size.width*0.65,screenRect.size.height*0.07)];
    _datetxt.textAlignment=NSTextAlignmentLeft;
    _datetxt.delegate =self;
    _datetxt.textColor=[UIColor blackColor];
    [_datetxt setBackgroundColor:[UIColor clearColor]];
    _datetxt.leftViewMode = UITextFieldViewModeAlways;
    _datetxt.returnKeyType=UIReturnKeyDone;
    _datetxt.selectedLineColor = [UIColor redColor];
    _datetxt.selectedPlaceHolderColor = [UIColor redColor];
    _datetxt.placeHolderColor = [UIColor grayColor];
    _datetxt.placeholder=@"Date*";
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done"
style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad11:)]];
    [numberToolbarzip sizeToFit];
    _datetxt.inputView =datePicker;
    _datetxt.inputAccessoryView = numberToolbarzip;
    _datetxt.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_datetxt];
    
    hig=hig+screenRect.size.height*0.10;
    
    UIButton *Imageofcheque=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,hig+screenRect.size.height*0.02,screenRect.size.width*.50,screenRect.size.height*.06)];
    [Imageofcheque addTarget:self action:@selector(Uploadimage) forControlEvents:UIControlEventTouchUpInside];
    [Imageofcheque setTitle:@"Upload Image of cheque" forState:UIControlStateNormal];
    [Imageofcheque setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Imageofcheque setBackgroundColor:[UIColor lightGrayColor]];
    [Imageofcheque.titleLabel setFont:[UIFont systemFontOfSize:screenRect.size.width*0.04]];
    [self.view addSubview:Imageofcheque];
    
    _chequeimag=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.65,hig, screenRect.size.width*0.20,screenRect.size.height*0.10)];
    _chequeimag.clipsToBounds=YES;
    _chequeimag.contentMode = UIViewContentModeScaleAspectFill;
    _chequeimag.layer.borderWidth=0.05f;
    [self.view addSubview:_chequeimag];
    _chequeimag.backgroundColor=[UIColor colorWithHexString:@"#e9e9e9"];
    [[_chequeimag layer] setBorderColor:[UIColor grayColor].CGColor];
    hig=hig+screenRect.size.height*0.15;
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,hig,screenRect.size.width*0.60,screenRect.size.height*0.07)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn setClipsToBounds:YES];
    [Createvoucherbtn setTitle:@"Submit" forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Createvoucherbtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]] ;
    [self.view addSubview:Createvoucherbtn];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, screenRect.size.height *0.10, screenRect.size.width,screenRect.size.height *0.90);
    indicator.color=[UIColor colorWithHexString:@"#004c00"];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    
}
-(void)doneWithNumberPad11:(UITextField*)toolbar{
    NSDateFormatter*  dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    UIDatePicker *  picker = (UIDatePicker*)self.datetxt.inputView;
    NSString *dateString = [dateFormatter stringFromDate:[picker date]];
    _datetxt.text=dateString;
    [numberToolbarzip resignFirstResponder];
    [_datetxt resignFirstResponder];
}
-(void)save
{
    
    if (![_typetxt.text isEqualToString:@""]) {
        if (![_amounttxt.text isEqualToString:@""]) {
            if (![_chequetxt.text isEqualToString:@""]) {
                if (![_banktxt.text isEqualToString:@""]) {
                    if (![_branchtxt.text isEqualToString:@""]) {
                        if (![_datetxt.text isEqualToString:@""]) {
                            if (_chequeimag.image!=nil) {
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            formatter.dateFormat = @"yyyyMMddHHmmss";
                            NSString *datestr = [formatter stringFromDate:[NSDate date]];
                            
                            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                            NSMutableArray * imageDict=[[NSMutableArray alloc]init];
                            [indicator startAnimating];
                            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                            [params setObject:[_dict objectForKey:@"bknum"]  forKey:@"booking_no"];
                            [params setObject:[_dict objectForKey:@"unit_no"]  forKey:@"unit_no"];
                            [params setObject:[_dict objectForKey:@"name1"]  forKey:@"cust_name"];
                            [params setObject:[_dict objectForKey:@"mobile"]  forKey:@"mobile"];
                            [params setObject:_typetxt.text  forKey:@"type"];
                            [params setObject:_amounttxt.text  forKey:@"amount"];
                            [params setObject:_chequetxt.text  forKey:@"cheque_no"];
                            [params setObject:_banktxt.text  forKey:@"bank"];
                            [params setObject:_branchtxt.text  forKey:@"branch"];
                            [params setObject:_datetxt.text  forKey:@"cheque_date"];
                            [params setObject:@""  forKey:@"image"];
                            [params setObject:[prefs objectForKey:@"user_id"]  forKey:@"assigned_user_id"];
                            [params setObject:[_dict objectForKey:@"sr_empcode"]  forKey:@"emp_code"];
                            
                            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                            [dict setObject:[NSString stringWithFormat:@"%@_%@",[_dict objectForKey:@"sr_empcode"],datestr]  forKey:@"name"];
                            [dict setObject:_chequeimag.image  forKey:@"cheque_image[]"];
                            [imageDict addObject:dict];
                            
                            NSString*   urlString = [[NSString alloc]initWithFormat:@"%@collectCheque.php?",[prefs objectForKey:@"Link"]];
                            NSURL *url = [NSURL URLWithString:urlString];
                            NSMutableURLRequest *request= [[NSMutableURLRequest alloc] initWithURL:url] ;
                            [request setHTTPMethod:@"POST"];
                            NSString *boundary = @"---------------------------14737809831466499882746641449";
                            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                            
                            NSMutableData *postbody = [NSMutableData data];
                            NSString *postData = [self getHTTPBodyParamsFromDictionary:params boundary:boundary];
                            [postbody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
                            
                            //    [imageDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                            for(int i=0; i<imageDict.count; i++){
                                NSString *key=[[[imageDict objectAtIndex:i] allKeys] objectAtIndex:1];
                                NSString *name=[[imageDict objectAtIndex:i] objectForKey:@"name"];
                                
                                //        if ([key rangeOfString:@"pdf"].location != NSNotFound){
                                //            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                //            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.pdf\"\r\n",key,key] dataUsingEncoding:NSUTF8StringEncoding]];
                                //            [postbody appendData:[@"Content-Type: application/pdf\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                                //            [postbody appendData:[NSData dataWithData:[[imageDict objectAtIndex:i] valueForKey:key]]];
                                //
                                //        }else{
                        
                                [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                //    NSLog(@"%@", [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filetype=\"image/jpeg\"; filename=\"%@\"\r\n", key,[NSString stringWithFormat:@"%@.jpg",name ]]);
                                [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filetype=\"image/jpeg\"; filename=\"%@\"\r\n", key,[NSString stringWithFormat:@"%@.jpg",name ]] dataUsingEncoding:NSUTF8StringEncoding]];
                                [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                                CGFloat compression = 0.9f;
                                UIImage * image=_chequeimag.image;
                                
                                NSData * imageData = UIImageJPEGRepresentation(image, 0.1);
                                [postbody appendData:imageData];
                                //}
                            }
                            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                            [request setHTTPBody:postbody];
                            
                            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *returnData, NSError *error)

                             {
                                 NSString * returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                                 NSLog(@"Response in str = %@",returnString);
                                 NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
                           //      [self dismissViewControllerAnimated:YES completion:nil];
                                 // NSLog(@"JSON: %@", userDict);
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     if ([[userDict objectForKey:@"msg"] isEqualToString:@"Image uploaded"]) {
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                     }
                                     
                                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[userDict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                     [alert show];
                                     [ indicator stopAnimating];
                                 });
                                 
                             }];
                            }
                            else
                            {
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Please upload cheque image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                        }
                        else
                        {
                            [_datetxt showErrorWithText:@"select date"];
                        }
                    }
                    else
                    {
                        [_branchtxt showErrorWithText:@"Enter branch Name"];
                    }
                }
                else
                {
                    [_banktxt showErrorWithText:@"Enter Bank Name"];
                }
            }
            else
            {
                [_chequetxt showErrorWithText:@"Enter Cheque No"];
            }
        }
        else
        {
            [_amounttxt showErrorWithText:@"Enter amount"];
        }
    }
    else
    {
        [_typetxt showErrorWithText:@"Enter amount"];
    }
}
-(void)doneWithNumberPad{
    [_amounttxt resignFirstResponder];
}

-(NSString *) getHTTPBodyParamsFromDictionary: (NSDictionary* )params boundary:(NSString *)boundary
{
    NSMutableString *tempVal = [[NSMutableString alloc] init];
    for(NSString * key in params)
    {
        [tempVal appendFormat:@"\r\n--%@\r\n", boundary];
        [tempVal appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",key,[params objectForKey:key]];
    }
    return [tempVal description];
}
-(IBAction)cancelBtnpress{
    [_datetxt resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(ACFloatingTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)Uploadimage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _chequeimag.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
