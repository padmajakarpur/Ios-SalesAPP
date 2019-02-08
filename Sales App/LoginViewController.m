//
//  LoginViewController.m
//  Sales App
//
//  Created by Infinitum on 06/02/18.
//  Copyright © 2018 Infinitumus.com. All rights reserved.
//
#import "LoginViewController.h"
#import "UIColor+Expanded.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "RegisterViewController.h"
#import <AFNetworking.h>
#import "Front_OfficeViewController.h"
#import "SalesHeadViewController.h"
#import <AFHTTPSessionManager.h>
#import "ColletionTeamViewController.h"

#define NO_OF_FORM_FIELDS 7

typedef enum
{
    eMerchantID = 1,
    eCustomerID,
    eTransactionAmount,
    eChannelID,
    eIndustryTypeID,
    eWebsite,
    eTheme,
}FormFieldType;

static NSString *kMerchantChecksumGenURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp";
static NSString *kMerchantChecksumValURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp";

@interface LoginViewController ()
@property (nonatomic, strong) NSTimer *statusTimer;
@property (nonatomic, strong) PGOrder *currentOrder;
@end
@implementation LoginViewController
@synthesize emailTxt,passwordeTxt,appDelegate,TakePhotoView,mobtxt,usernametxt,numberToolbarzip,indicator,buyBtn,reference_no;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    // Do any additional setup after loading the view from its nib.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    appDelegate=[[UIApplication sharedApplication] delegate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    if ([prefs objectForKey:@"user_id"]!=nil) {
        if (![[prefs objectForKey:@"user_id"] isEqualToString:@""]) {
            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            appDelegate.index=0;
            appDelegate.calltime=1;
            [self.navigationController pushViewController:mainvc animated:YES];
        }
    }
    
    UIImage *backgroundImage = [UIImage imageNamed:@"Log in Page BG Image_In black.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
 //   [self.view addSubview:backgroundImageView];

    UIImageView *mobileimageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.23, screenRect.size.height*0.24, screenRect.size.width*0.57,screenRect.size.height*0.07)];
    mobileimageview.image=[UIImage imageNamed:@"Xrbia_logo_white.png"];
    //mobileimageview.backgroundColor = UIColor.whiteColor;
    [mobileimageview setContentMode:UIViewContentModeScaleAspectFit];
    //backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
       [self.view addSubview:mobileimageview];

    UILabel *leftarrlbl = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.32,screenRect.size.width*0.90,screenRect.size.height*0.10)];
    leftarrlbl.font=[UIFont systemFontOfSize:screenRect.size.width*0.050];
    leftarrlbl.text =@"JOIN OUR SALES NETWORK\nMANAGE YOUR OWN GROWTH.";
    [leftarrlbl setTextColor:[UIColor whiteColor]];
    leftarrlbl.backgroundColor=[UIColor clearColor];
    leftarrlbl.lineBreakMode = NSLineBreakByWordWrapping;
    leftarrlbl.numberOfLines = 0;
    leftarrlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftarrlbl];

    emailTxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.43,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    emailTxt.textAlignment=NSTextAlignmentLeft;
    emailTxt.delegate = self;
    emailTxt.textColor=[UIColor whiteColor];
    [emailTxt setBackgroundColor:[UIColor clearColor]];
    emailTxt.leftViewMode = UITextFieldViewModeAlways;
    [emailTxt setKeyboardType:UIKeyboardTypeEmailAddress];
    emailTxt.returnKeyType=UIReturnKeyDone;
    emailTxt.floatingLabelActiveTextColor = [UIColor redColor];
    emailTxt.floatingLabelInactiveTextColor = [UIColor whiteColor];
    CALayer *bottomBorders3 = [CALayer layer];
    bottomBorders3.frame = CGRectMake(0.0f, emailTxt.frame.size.height - 5, emailTxt.frame.size.width, 1.0f);
    bottomBorders3.backgroundColor = [UIColor whiteColor].CGColor;
    [emailTxt.layer addSublayer:bottomBorders3];
    emailTxt.placeholder=@"Username";
    emailTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTxt.font = [UIFont systemFontOfSize:14];
    emailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    [self.view addSubview:emailTxt];
  
    passwordeTxt = [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.51,screenRect.size.width*0.90,screenRect.size.height*0.07)];
    passwordeTxt.textAlignment=NSTextAlignmentLeft;
    passwordeTxt.delegate = self;
    passwordeTxt.textColor=[UIColor whiteColor];
    [passwordeTxt setBackgroundColor:[UIColor clearColor]];
    passwordeTxt.leftViewMode = UITextFieldViewModeAlways;
    [passwordeTxt setKeyboardType:UIKeyboardTypeEmailAddress];
    passwordeTxt.returnKeyType=UIReturnKeyDone;
    passwordeTxt.secureTextEntry=YES;
    passwordeTxt.font = [UIFont systemFontOfSize:14];
    passwordeTxt.floatingLabelActiveTextColor = [UIColor redColor];
    passwordeTxt.floatingLabelInactiveTextColor = [UIColor whiteColor];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, passwordeTxt.frame.size.height - 5, passwordeTxt.frame.size.width, 1.0f);
    bottomBorders1.backgroundColor = [UIColor whiteColor].CGColor;
    [passwordeTxt.layer addSublayer:bottomBorders1];
    passwordeTxt.placeholder=@"Password";
    passwordeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.view addSubview:passwordeTxt];
    
    UIButton* downbtn3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*.80,screenRect.size.height*0.51,screenRect.size.width*.15,screenRect.size.height*.07)];
    [downbtn3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [downbtn3 setTitle:@"\uE8F5" forState:UIControlStateNormal];
    [downbtn3 setTitle:@"\uE8F4" forState:UIControlStateSelected];
    [downbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downbtn3.titleLabel setFont:[UIFont fontWithName:@"MaterialIcons-Regular" size:25]];
    [downbtn3 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:downbtn3];
    
    UIButton *Createvoucherbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.61,screenRect.size.width*0.80,screenRect.size.height*0.07)];
    Createvoucherbtn.layer.cornerRadius = 4.0f;
    [Createvoucherbtn setClipsToBounds:YES];
    [Createvoucherbtn setTitle:@"Log In" forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Createvoucherbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    Createvoucherbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [Createvoucherbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [Createvoucherbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
    [Createvoucherbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]] ;
    [self.view addSubview:Createvoucherbtn];

//    UIButton *loginbtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.81,screenRect.size.width*0.80,screenRect.size.height*0.07)];
//    loginbtn.layer.cornerRadius = 4.0f;
//    [loginbtn setClipsToBounds:YES];
//    [loginbtn setTitle:@"Paytm Intigration" forState:UIControlStateNormal];
//    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [loginbtn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    loginbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [loginbtn addTarget:self action:@selector(gocollection) forControlEvents:UIControlEventTouchUpInside];
//    [loginbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
//    [loginbtn setBackgroundColor:[UIColor blueColor]] ;
//    [self.view addSubview:loginbtn];
//
//    UIButton *imgupload=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.90,screenRect.size.width*0.80,screenRect.size.height*0.07)];
//    imgupload.layer.cornerRadius = 4.0f;
//    [imgupload setClipsToBounds:YES];
//    [imgupload setTitle:@"Img Intigration" forState:UIControlStateNormal];
//    [imgupload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [imgupload setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
//    imgupload.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [imgupload addTarget:self action:@selector(image) forControlEvents:UIControlEventTouchUpInside];
//    [imgupload.titleLabel setFont:[UIFont boldSystemFontOfSize:screenRect.size.width*0.05]];
//    [imgupload setBackgroundColor:[UIColor magentaColor]] ;
//    [self.view addSubview:imgupload];
//    

    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(screenRect.size.width *0.35, screenRect.size.height *0.40, screenRect.size.width *0.30,screenRect.size.width *0.30);
    indicator.color=[UIColor whiteColor];
    indicator.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    indicator.layer.cornerRadius=15.0f;

    //seales team
//    emailTxt.text=@"sales_xrbia1";
//    passwordeTxt.text=@"Xrbia@123";

    
    //
//    emailTxt.text=@"RahulT";
//        passwordeTxt.text=@"Xrbia@123";

    //sales head
//        emailTxt.text=@"MPritam";
//        passwordeTxt.text=@"123456";    //no need to change

    //frontview
//    emailTxt.text=@"FarhanaK";
//    passwordeTxt.text=@"123456";   //no need to change

    //sales manager
//    emailTxt.text=@"pradeeps";             Aghils
//    passwordeTxt.text=@"123456";           Xrbia@123

    // esc team
//        emailTxt.text=@"adnank";
//        passwordeTxt.text=@"123456";

    //esc manager
//        emailTxt.text=@"PratikSK";
//        passwordeTxt.text=@"123456";
    
//////
    //Ret manager
//        emailTxt.text=@"VinitSK";
//        passwordeTxt.text=@"123456";

    //ret team
//        emailTxt.text=@"shaikhb";
//        passwordeTxt.text=@"123456";
}
-(void)gocollection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"collection team" forKey:@"role_name"];
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];

}
- (void)UploadLookImage:(NSMutableArray* )imageDict otherParameters:(NSDictionary* )otherParameters postUrl:(NSString *)postUrl{
    
    }
-(void)image
{
    NSMutableArray * imageDict=[[NSMutableArray alloc]init];
    {
        NSMutableDictionary *otherParameters=[[NSMutableDictionary alloc]init];
        [otherParameters setObject:@"Chembur"  forKey:@"name"];
        [otherParameters setObject:[UIImage imageNamed:@"Chembur.jpg"] forKey:@"uploaded_file[]"];
        [imageDict addObject:otherParameters];
    }
    {
        NSMutableDictionary *otherParameters=[[NSMutableDictionary alloc]init];
        [otherParameters setObject:@"Xrbia logo"  forKey:@"name"];
        [otherParameters setObject:[UIImage imageNamed:@"Xrbia Logo.png"] forKey:@"uploaded_file[]"];
        [imageDict addObject:otherParameters];
    }
    NSMutableDictionary *otherParameters=[[NSMutableDictionary alloc]init];
    [otherParameters setObject:emailTxt.text  forKey:@"username"];
    [otherParameters setObject:passwordeTxt.text forKey:@"password"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@imgtest.php",[prefs objectForKey:@"Link"]];

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] initWithURL:url] ;
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postbody = [NSMutableData data];
    NSString *postData = [self getHTTPBodyParamsFromDictionary:otherParameters boundary:boundary];
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
            NSLog(@"%@", [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filetype=\"image/jpeg\"; filename=\"%@\"\r\n", key,[NSString stringWithFormat:@"%@.jpg",name ]]);
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filetype=\"image/jpeg\"; filename=\"%@\"\r\n", key,[NSString stringWithFormat:@"%@.jpg",name ]] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            CGFloat compression = 0.9f;
            UIImage * image=[[imageDict objectAtIndex:i] valueForKey:key];
            
            NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
            [postbody appendData:imageData];
        //}
    }    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *returnData, NSError *error)
     {
         if (returnData!=nil && returnData.length > 0)
         {
             NSError *error;
             NSString * returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
             NSLog(@"Response in str = %@",returnString);
        //     NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions  error:&error];
             
//             NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self getMethodSignature]];
//             [invocation setSelector:selector];
//             [invocation setTarget: aDelegate];
//             [invocation setArgument:&responseDict atIndex:2];
//             [invocation invoke];
         }
         else
         {
             NSMutableDictionary *mDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Please try again later.",@"Message",@"0",@"Success", nil];
           //  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self getMethodSignature]];
//             [invocation setSelector:selector];
//             [invocation setTarget: aDelegate];
//             [invocation setArgument:&mDict atIndex:2];
//             [invocation invoke];
             
         }
     }];
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
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)updateMerchantConfigurationWithLatestValues
{
//    PGMerchantConfiguration *defaultConfig = [PGMerchantConfiguration defaultConfiguration];
//    defaultConfig.merchantID = self.merchantIDTextField.text;
//    defaultConfig.channelID = self.channelIDTextField.text;
//    defaultConfig.industryID = self.industryTypeIDTextField.text;
//    defaultConfig.website = self.websiteTextField.text;
//    defaultConfig.theme = self.themeTextField.text;
//
//    if (!self.checksumGenTextField.hidden)
//    {
//        defaultConfig.checksumGenerationURL = [self.checksumGenTextField.text copy];
//        defaultConfig.checksumValidationURL = self.checksumValidTextfield.text;
//    }
//    else
//    {
//        [PGMerchantConfiguration defaultConfiguration].checksumGenerationURL = nil;
//        [PGMerchantConfiguration defaultConfiguration].checksumValidationURL = nil;
//    }
}
+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix
{
    srand ( (unsigned)time(NULL) );
    NSInteger randomNo = rand(); //just randomizing the number
    NSString *orderID = [NSString stringWithFormat:@"%@%ld", prefix, (long)randomNo];
    return orderID;
}

+(NSString*)generateCustomerID
{
    srand ( (unsigned)time(NULL) );
    NSInteger randomNo = rand(); //just randomizing the number
    NSString *orderID = [NSString stringWithFormat:@"CUST%ld", (long)randomNo];
    return orderID;
}

- (void)setOrderParameterFields
{
    //set the customer field only once when the app is launched
    if ([self.customerIDTextField.text isEqualToString:@""] || self.customerIDTextField.text == nil) {
        self.customerIDTextField.text = [LoginViewController generateCustomerID];
    }
    
    //create a new order id every time a order preparation view appears
    self.orderIDField.text = [LoginViewController generateOrderIDWithPrefix:@"ORDER"];
    self.customerIDTextField.text = @"CUSTOMER123";
    self.transactionAmountTextField.text = @"1"; //reset amount to 1 for safety
    self.custeMailTextField.text = @"customer123@paytm.com";
    self.custMobileNoTextField.text = @"9343999888";
}

- (void)setDefaultMerchantParamsAndFields
{
    //set the client SSL cert settings
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"Client" ofType:@"p12"];
    
    PGMerchantConfiguration *merchant = [PGMerchantConfiguration defaultConfiguration];
    merchant.clientSSLCertPath = certPath;
    merchant.clientSSLCertPassword = @"admin";
    
    //set the merchant params
    merchant.merchantID = @"WorldP64425807474247"; //STAGING MID
    //merchant.merchantID = @"robote84198990953406"; //PRODUCTION MID
    merchant.website = @"worldpressplg";
    merchant.industryID = @"Retail";
    merchant.checksumGenerationURL = kMerchantChecksumGenURL;
    merchant.checksumValidationURL = kMerchantChecksumValURL;
    
    
    //Display these below values as default values and consider these values only as parameters if fields are not modified.
    self.merchantIDTextField.text = merchant.merchantID;
    self.channelIDTextField.text = merchant.channelID;
    self.industryTypeIDTextField.text = merchant.industryID;
    self.websiteTextField.text = merchant.website;
    self.themeTextField.text = merchant.theme;
    self.checksumGenTextField.text = merchant.checksumGenerationURL;
    self.checksumValidTextfield.text = merchant.checksumValidationURL;
}



- (IBAction)beginPayment:(id)sender
{
    //Set the latest merchant id in case it has been changed
    [self updateMerchantConfigurationWithLatestValues];

    [PGServerEnvironment selectServerDialog:self.view completionHandler:^(ServerType type)
     {
         PGOrder *order = [PGOrder orderForOrderID:@""
                                        customerID:@""
                                            amount:@""
                                      customerMail:@""
                                    customerMobile:@""];
         
         order.params =   @{@"MID" : @"TECHOP10964184510936",
                            @"ORDER_ID": @"1520843747890",
                            @"CUST_ID" : @"test111",
                            @"CHANNEL_ID": @"WAP",
                            @"INDUSTRY_TYPE_ID": @"Retail",
                            @"WEBSITE": @"TECHweb",
                            @"TXN_AMOUNT": @"1",
                            @"CHECKSUMHASH":@"Bzk47IMatCI7T3b21iB403MsRBNhJ9DWHeK79iD+dli6GUg5w+JKDk6gk6roSjuKrtFzDiXwuUsfgVz30Xa2+W+kgwnNQaZXJTSfKPy6gU4=",
                            @"CALLBACK_URL":@"https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=1520843747890"
                            };
         PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
         txnController.loggingEnabled = YES;
         
         if (type != eServerTypeNone)
             txnController.serverType = type;
         else return;
         txnController.merchant = [PGMerchantConfiguration defaultConfiguration];
         txnController.delegate = self;

         [self.navigationController pushViewController:txnController animated:YES];
         [[self navigationController] setNavigationBarHidden:NO animated:YES];
     }];
}
- (void)checkStatus:(id)sender
{
    [PGServerEnvironment statusForOrderID:_currentOrder.orderID responseHandler:^(NSDictionary *response, NSError *error)
     {
         if (error)DEBUGLOG(@"STATUS ERROR: %@",error.localizedDescription);
         else      DEBUGLOG(@"STATUS RESPONSE: %@",response.description);
     }];
}

#pragma mark PGTransactionViewController delegate

-(void)didFinishedResponse:(PGTransactionViewController *)controller response:(NSString *)responseString {
    DEBUGLOG(@"ViewController::didFinishedResponse:response = %@", responseString);
    [controller.navigationController popViewControllerAnimated:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}


-(void)didCancelTrasaction:(PGTransactionViewController *)controller {
    
    [_statusTimer invalidate];

    NSString *msg = [NSString stringWithFormat:@"UnSuccessful"];
    [[[UIAlertView alloc] initWithTitle:@"Transaction Cancel" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [controller.navigationController popViewControllerAnimated:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

}

//Called when a required parameter is missing.
-(void)errorMisssingParameter:(PGTransactionViewController *)controller error:(NSError *) error {
    DEBUGLOG(@"Parameter is missing %@",error.localizedDescription);
    [controller.navigationController popViewControllerAnimated:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

}


-(IBAction)saleshead:(id)sender
{
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=0;
        appDelegate.rolestr=@"SalesHead";
        [self.navigationController pushViewController:mainvc animated:YES];
        [indicator stopAnimating];
}
-(IBAction)frontoffice:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"front_office" forKey:@"role_name"];

    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];
    [indicator stopAnimating];
    //
}
-(IBAction)BuyAction:(id)sender
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(RPFloatingPlaceholderTextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)show:(UIButton*)btn
{
    if (btn.selected) {
        passwordeTxt.secureTextEntry=YES;
        btn.selected=NO;
    }
    else
    {
        passwordeTxt.secureTextEntry=NO;
        btn.selected=YES;
    }
}
-(void)forgetpassbtn
{
    TakePhotoView = [[CustomIOS7AlertView alloc] init];
    [TakePhotoView setContainerView:[self signImageSetAlert]];
    [TakePhotoView setDelegate:self];
    [TakePhotoView setUseMotionEffects:true];
    [TakePhotoView show];
}
-(UIView *)signImageSetAlert{
    int heig=0;
    UIView *demoView;
    heig=150;
    
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,170)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];

    usernametxt= [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(10, 20, 280, 40)];
    usernametxt.textAlignment=NSTextAlignmentLeft;
    usernametxt.delegate = self;
    usernametxt.textColor=[UIColor blackColor];
    [usernametxt setBackgroundColor:[UIColor clearColor]];
    usernametxt.leftViewMode = UITextFieldViewModeAlways;
    [usernametxt setKeyboardType:UIKeyboardTypeEmailAddress];
    usernametxt.returnKeyType=UIReturnKeyDone;
    usernametxt.floatingLabelActiveTextColor = [UIColor redColor];
    usernametxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, usernametxt.frame.size.height - 5, usernametxt.frame.size.width, 1.0f);
    bottomBorders1.backgroundColor = [UIColor redColor].CGColor;
    [usernametxt.layer addSublayer:bottomBorders1];
    usernametxt.placeholder = @"Username/Email*";
    [demoView addSubview:usernametxt];
    
    UIButton *galleryOption=[[UIButton alloc] initWithFrame:CGRectMake(0,70, 300,50)];
    
     mobtxt= [[RPFloatingPlaceholderTextField alloc] initWithFrame:CGRectMake(10,75, 280,40)];
    mobtxt.textAlignment=NSTextAlignmentLeft;
    mobtxt.delegate = self;
    mobtxt.textColor=[UIColor blackColor];
    [mobtxt setBackgroundColor:[UIColor clearColor]];
    mobtxt.leftViewMode = UITextFieldViewModeAlways;
    [mobtxt setKeyboardType:UIKeyboardTypeEmailAddress];
    mobtxt.returnKeyType=UIReturnKeyDone;
    mobtxt.floatingLabelActiveTextColor = [UIColor redColor];
    mobtxt.floatingLabelInactiveTextColor = [UIColor grayColor];
    CALayer *bottomBorders3 = [CALayer layer];
    bottomBorders3.frame = CGRectMake(0.0f, mobtxt.frame.size.height - 5, mobtxt.frame.size.width, 1.0f);
    bottomBorders3.backgroundColor = [UIColor redColor].CGColor;
    [mobtxt.layer addSublayer:bottomBorders3];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    numberToolbarzip.tintColor=[UIColor whiteColor];
    mobtxt.inputAccessoryView = numberToolbarzip;
    mobtxt.leftViewMode = UITextFieldViewModeAlways;
    mobtxt.keyboardType = UIKeyboardTypeDecimalPad;
    mobtxt.placeholder = @"Mobile No*";
    [demoView addSubview:mobtxt];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(10,120,135,40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:cancelBtn];
    
    UIButton *okbtn=[[UIButton alloc] initWithFrame:CGRectMake(155,120,135,40)];
    [okbtn setTitle:@"Submit" forState:UIControlStateNormal];
        [okbtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [okbtn setBackgroundColor:[UIColor colorWithHexString:@"#ED2026"]];
    okbtn.tag=1;
    [okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [demoView addSubview:okbtn];
    return demoView;
}
-(void)submit:(id)sender{
    
    NSUInteger r = arc4random_uniform(999999);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"passwordReset"  forKey:@"requestType"];
    [params setObject:usernametxt.text forKey:@"user_name"];
    [params setObject:mobtxt.text forKey:@"mobile_no"];
    [params setObject:[NSString stringWithFormat:@"%lu",(unsigned long)r] forKey:@"otp"];

    [indicator startAnimating];
    NSString* urlString =@"http://13.126.129.245/xrbia/mobilecrm/forgotpassword.php?";
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
        [indicator stopAnimating];

        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        if ([[dic objectForKey:@"user_id"]isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:[dic objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
           [TakePhotoView close];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
-(void)closeAlert:(id)sender{
    [TakePhotoView close];
}
-(void)doneWithNumberPad{
    [mobtxt resignFirstResponder];
}
-(void)Register
{
    RegisterViewController *mainvc=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(void)login
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:emailTxt.text  forKey:@"username"];
    [params setObject:passwordeTxt.text forKey:@"password"];
    [params setObject:[prefs objectForKey:@"url"] forKey:@"url"];
    
    [indicator startAnimating];
    NSString*   urlString = [[NSString alloc]initWithFormat:@"%@andrologin.php",[prefs objectForKey:@"Link"]];

    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"JSON: %@", userDict);
//
        //            NSString *content = [[NSString alloc]  initWithBytes:[responseObject bytes]
        //                                                          length:[responseObject length] encoding: NSUTF8StringEncoding];
        //            NSLog(@"content %@",content);
        
        NSMutableDictionary* dic =[userDict objectForKey:@"Android"];
        int boolValue =[[dic objectForKey:@"success"] intValue];
        if ([dic objectForKey:@"name"]!=nil) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[dic objectForKey:@"name"] message:[dic objectForKey:@"description"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [indicator stopAnimating];
        }
        else
        {
            [prefs setObject:emailTxt.text forKey:@"username"];
            [prefs setObject:passwordeTxt.text forKey:@"password"];

            appDelegate.name_value_list=[dic objectForKey:@"name_value_list"];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:[dic objectForKey:@"discount_allowed"] forKey:@"discount_allowed"];
            [prefs setObject:[dic objectForKey:@"id"] forKey:@"id"];
            [prefs setObject:[dic objectForKey:@"module_name"] forKey:@"module_name"];
            [prefs setObject:[dic objectForKey:@"no_of_units_blocked_by_user_c"] forKey:@"no_of_units_blocked_by_user_c"];
            [prefs setObject:[dic objectForKey:@"role_id"] forKey:@"role_id"];
            [prefs setObject:[dic objectForKey:@"no_of_units_blocked_by_user_c"] forKey:@"no_of_units_blocked_by_user_c"];
            [prefs setObject:[dic objectForKey:@"role_name"] forKey:@"role_name"];
            [prefs setObject:[dic objectForKey:@"did_no"] forKey:@"did_no"];
            [prefs setObject:[[appDelegate.name_value_list objectForKey:@"user_id"] objectForKey:@"value"] forKey:@"user_id"];
            [prefs setObject:[[appDelegate.name_value_list objectForKey:@"user_is_admin"] objectForKey:@"value"] forKey:@"user_is_admin"];
            [prefs setObject:[[appDelegate.name_value_list objectForKey:@"user_name"] objectForKey:@"value"] forKey:@"user_name"];

            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            appDelegate.index=0;
            appDelegate.calltime=1;
            [self.navigationController pushViewController:mainvc animated:YES];
            [indicator stopAnimating];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Xrbia" message:@"Failed to submit request"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
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
